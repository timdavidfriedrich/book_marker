import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:core/security/backup_verifier.dart';
import 'package:core/security/master_key_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/account_entitlement.dart';
import 'package:shared/domain/repositories/auth_repository.dart';
import 'package:shared/domain/repositories/entitlement_repository.dart';
import 'package:shared/presentation/account/account_event.dart';
import 'package:shared/presentation/account/account_state.dart';

@injectable
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc(
    this._authRepository,
    this._masterKeyStore,
    this._backupVerifier,
    this._entitlementRepository,
  ) : super(const AccountRestoring()) {
    on<AccountStarted>(_onStarted);
    on<AccountUpdated>(_onUpdated);
    on<AccountGoogleSignInRequested>(_onGoogleSignInRequested);
    on<AccountAppleSignInRequested>(_onAppleSignInRequested);
    on<AccountSignOutRequested>(_onSignOutRequested);
    on<AccountUnlocked>(_onUnlocked);
    on<AccountEntitlementRefreshed>(_onEntitlementRefreshed);
  }

  final AuthRepository _authRepository;
  final MasterKeyStore _masterKeyStore;
  final BackupVerifier _backupVerifier;
  final EntitlementRepository _entitlementRepository;
  StreamSubscription<AppResult<Account?>>? _accountSubscription;
  AccountEntitlement? _entitlement;
  String? _blockedReason;

  @override
  Future<void> close() async {
    await _accountSubscription?.cancel();
    return super.close();
  }

  Future<void> _onStarted(AccountStarted event, Emitter<AccountState> emit) async {
    // * restore before listening, so the first emission already reflects a
    // * session that survived the app being killed
    await _authRepository.restoreSession();
    await _accountSubscription?.cancel();
    _accountSubscription = _authRepository.watchAccount().listen(
      (result) => add(AccountUpdated(result)),
    );
  }

  Future<void> _onUpdated(AccountUpdated event, Emitter<AccountState> emit) async {
    switch (event.result) {
      case Failure():
        _entitlement = null;
        emit(const AccountSignedOut());
      case Success(:final data?):
        // * paint from what is already on the device, then correct once the
        // * server answers. First frame must never wait on the network
        emit(await _resolve(data));
        add(const AccountEntitlementRefreshed());
      case Success():
        _entitlement = null;
        emit(const AccountSignedOut());
    }
  }

  Future<void> _onGoogleSignInRequested(
    AccountGoogleSignInRequested event,
    Emitter<AccountState> emit,
  ) => _signIn(emit, SignInProvider.google, _authRepository.signInWithGoogle);

  Future<void> _onAppleSignInRequested(
    AccountAppleSignInRequested event,
    Emitter<AccountState> emit,
  ) => _signIn(emit, SignInProvider.apple, _authRepository.signInWithApple);

  Future<void> _onSignOutRequested(
    AccountSignOutRequested event,
    Emitter<AccountState> emit,
  ) async {
    await _authRepository.signOut(allDevices: false);
    if (event.removesLocalData) await _masterKeyStore.clear();
    _blockedReason = null;
    _entitlement = null;
    emit(const AccountSignedOut());
  }

  Future<void> _onUnlocked(AccountUnlocked event, Emitter<AccountState> emit) async {
    if (state case AccountLocked(:final account)) emit(await _resolve(account));
  }

  Future<void> _onEntitlementRefreshed(
    AccountEntitlementRefreshed event,
    Emitter<AccountState> emit,
  ) async {
    await _loadEntitlement();
    if (state
        case AccountLocked(:final account) ||
            AccountBlocked(:final account) ||
            AccountReady(:final account)) {
      emit(await _resolve(account));
    }
  }

  Future<void> _signIn(
    Emitter<AccountState> emit,
    SignInProvider provider,
    Future<AppResult<Account>> Function() signIn,
  ) async {
    emit(AccountSignedOut(pendingProvider: provider));
    switch (await signIn()) {
      case Success(:final data):
        // * awaited here, unlike the stream path: the server was just reached,
        // * and resolving without it would show the wrong recovery screen
        await _loadEntitlement();
        emit(await _resolve(data));
      case Failure(:final error):
        if (error case AccountBlockedError(:final reason)) _blockedReason = reason;
        emit(AccountSignedOut(error: error));
    }
  }

  // * a failure leaves the previous answer in place. Guessing on behalf of an
  // * unreachable server happens in _lockedReason, once, and on the safe side
  Future<void> _loadEntitlement() async {
    if (await _entitlementRepository.fetch() case Success(:final data)) {
      _entitlement = data;
    }
  }

  // * a session alone is not enough to read anything: without the master key the
  // * library is intact but unreadable, which is a different state from being
  // * signed out and must not be shown as an empty library
  Future<AccountState> _resolve(Account account) async {
    final entitlement = _entitlement;
    if (entitlement != null && entitlement.status == AccountStatus.blocked) {
      return AccountBlocked(account: account, reason: entitlement.blockedReason);
    }
    final reason = _blockedReason;
    if (reason != null) return AccountBlocked(account: account, reason: reason);
    if (await _hasUsableKey(entitlement)) return AccountReady(account: account);
    return AccountLocked(account: account, reason: _lockedReason(entitlement));
  }

  // * a key on the device is not automatically this account's key. Signing out
  // * while keeping local data and back in with a different account leaves the
  // * previous one behind, and using it would render the library unreadable
  // * rather than say so
  Future<bool> _hasUsableKey(AccountEntitlement? entitlement) async {
    final key = await _masterKeyStore.read();
    if (key == null) return false;
    // * unknown means the server could not be reached. The key on the device is
    // * then the best answer there is, and local use must not stop for it
    if (entitlement == null) return true;
    final verifier = entitlement.backupVerifier;
    if (verifier == null) return false;
    return _backupVerifier.matches(verifier, key);
  }
}

// * unknown has to mean enterCode. Unlocking never destroys anything, while
// * generating a second code orphans everything encrypted under the first, so
// * an unreachable server must not be allowed to trigger a fresh setup
LockedReason _lockedReason(AccountEntitlement? entitlement) {
  if (entitlement == null) return LockedReason.enterCode;
  return entitlement.hasBackup ? LockedReason.enterCode : LockedReason.setUpBackup;
}
