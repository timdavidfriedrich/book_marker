import 'package:core/error/app_result.dart';
import 'package:core/security/backup_verifier.dart';
import 'package:core/security/master_key_store.dart';
import 'package:core/security/recovery_code.dart';
import 'package:feature_account/presentation/unlock/unlock_event.dart';
import 'package:feature_account/presentation/unlock/unlock_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/repositories/entitlement_repository.dart';

@injectable
class UnlockBloc extends Bloc<UnlockEvent, UnlockState> {
  UnlockBloc(this._entitlementRepository, this._backupVerifier, this._masterKeyStore)
    : super(const UnlockPreparing()) {
    on<UnlockStarted>(_onStarted);
    on<UnlockSubmitted>(_onSubmitted);
  }

  final EntitlementRepository _entitlementRepository;
  final BackupVerifier _backupVerifier;
  final MasterKeyStore _masterKeyStore;
  String? _verifier;

  Future<void> _onStarted(UnlockStarted event, Emitter<UnlockState> emit) async {
    emit(const UnlockPreparing());
    switch (await _entitlementRepository.fetch()) {
      case Failure():
        emit(const UnlockUnavailable(blocker: UnlockBlocker.unreachable));
      case Success(:final data) when data.backupVerifier == null:
        emit(const UnlockUnavailable(blocker: UnlockBlocker.noBackup));
      case Success(:final data):
        _verifier = data.backupVerifier;
        emit(const UnlockReady(isChecking: false, hasFailed: false));
    }
  }

  Future<void> _onSubmitted(UnlockSubmitted event, Emitter<UnlockState> emit) async {
    final verifier = _verifier;
    if (verifier == null) return;
    if (state case UnlockReady(isChecking: true)) return;
    emit(const UnlockReady(isChecking: true, hasFailed: false));

    // * one verdict for the whole code. A malformed code and a valid code from
    // * another account are reported identically, or the screen would tell an
    // * attacker which half of the input to keep
    final code = RecoveryCode.tryParse(event.code);
    if (code == null || !await _backupVerifier.matches(verifier, code.key)) {
      emit(const UnlockReady(isChecking: false, hasFailed: true));
      return;
    }

    await _masterKeyStore.write(code.key);
    emit(const UnlockSucceeded());
  }
}
