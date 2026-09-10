import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:core/security/master_key_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/repositories/auth_repository.dart';
import 'package:shared/presentation/account/account_event.dart';
import 'package:shared/presentation/account/account_state.dart';

@injectable
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc(this._authRepository, this._masterKeyStore) : super(const AccountRestoring()) {
    on<AccountStarted>(_onStarted);
    on<AccountUpdated>(_onUpdated);
    on<AccountGoogleSignInRequested>(_onGoogleSignInRequested);
    on<AccountAppleSignInRequested>(_onAppleSignInRequested);
    on<AccountSignOutRequested>(_onSignOutRequested);
    on<AccountUnlocked>(_onUnlocked);
  }

  final AuthRepository _authRepository;
  final MasterKeyStore _masterKeyStore;
  StreamSubscription<AppResult<Account?>>? _accountSubscription;
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
        emit(const AccountSignedOut());
      case Success(:final data?):
        emit(await _resolve(data));
      case Success():
        emit(const AccountSignedOut());
    }
  }

  Future<void> _onGoogleSignInRequested(
    AccountGoogleSignInRequested event,
    Emitter<AccountState> emit,
  ) => _signIn(emit, _authRepository.signInWithGoogle);

  Future<void> _onAppleSignInRequested(
    AccountAppleSignInRequested event,
    Emitter<AccountState> emit,
  ) => _signIn(emit, _authRepository.signInWithApple);

  Future<void> _onSignOutRequested(
    AccountSignOutRequested event,
    Emitter<AccountState> emit,
  ) async {
    await _authRepository.signOut(allDevices: false);
    if (event.removesLocalData) await _masterKeyStore.clear();
    _blockedReason = null;
    emit(const AccountSignedOut());
  }

  Future<void> _onUnlocked(AccountUnlocked event, Emitter<AccountState> emit) async {
    if (state case AccountLocked(:final account)) emit(await _resolve(account));
  }

  Future<void> _signIn(
    Emitter<AccountState> emit,
    Future<AppResult<Account>> Function() signIn,
  ) async {
    emit(const AccountSignedOut(isSigningIn: true));
    switch (await signIn()) {
      case Success(:final data):
        emit(await _resolve(data));
      case Failure(:final error):
        if (error case AccountBlockedError(:final reason)) _blockedReason = reason;
        emit(AccountSignedOut(error: error));
    }
  }

  // * a session alone is not enough to read anything: without the master key the
  // * library is intact but unreadable, which is a different state from being
  // * signed out and must not be shown as an empty library
  Future<AccountState> _resolve(Account account) async {
    final reason = _blockedReason;
    if (reason != null) return AccountBlocked(account: account, reason: reason);
    final key = await _masterKeyStore.read();
    if (key == null) return AccountLocked(account: account);
    return AccountReady(account: account);
  }
}
