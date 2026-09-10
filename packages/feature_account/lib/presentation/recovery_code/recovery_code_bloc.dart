import 'package:core/error/app_result.dart';
import 'package:core/security/backup_verifier.dart';
import 'package:core/security/master_key_store.dart';
import 'package:core/security/recovery_code.dart';
import 'package:feature_account/presentation/recovery_code/recovery_code_event.dart';
import 'package:feature_account/presentation/recovery_code/recovery_code_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/repositories/entitlement_repository.dart';

@injectable
class RecoveryCodeBloc extends Bloc<RecoveryCodeEvent, RecoveryCodeState> {
  RecoveryCodeBloc(this._masterKeyStore, this._backupVerifier, this._entitlementRepository)
    : super(const RecoveryCodeGenerating()) {
    on<RecoveryCodeStarted>(_onStarted);
    on<RecoveryCodeCopied>(_onCopied);
    on<RecoveryCodeConfirmationToggled>(_onConfirmationToggled);
    on<RecoveryCodeAccepted>(_onAccepted);
  }

  final MasterKeyStore _masterKeyStore;
  final BackupVerifier _backupVerifier;
  final EntitlementRepository _entitlementRepository;
  RecoveryCode? _code;

  void _onStarted(RecoveryCodeStarted event, Emitter<RecoveryCodeState> emit) {
    final code = _code ??= RecoveryCode.generate();
    emit(
      RecoveryCodeReady(
        groups: code.groups,
        isCopied: false,
        isConfirmed: false,
        isStarting: false,
        failure: null,
      ),
    );
  }

  Future<void> _onCopied(RecoveryCodeCopied event, Emitter<RecoveryCodeState> emit) async {
    final code = _code;
    if (code == null) return;
    if (state case final RecoveryCodeReady ready) {
      await Clipboard.setData(ClipboardData(text: code.formatted));
      emit(_copy(ready, isCopied: true));
    }
  }

  void _onConfirmationToggled(
    RecoveryCodeConfirmationToggled event,
    Emitter<RecoveryCodeState> emit,
  ) {
    if (state case final RecoveryCodeReady ready) {
      emit(_copy(ready, isConfirmed: !ready.isConfirmed));
    }
  }

  // * server first, keystore second. A key the server has no record of is the
  // * one state that loses data later: the next device would be told no backup
  // * exists, generate a second code, and orphan everything under the first
  Future<void> _onAccepted(RecoveryCodeAccepted event, Emitter<RecoveryCodeState> emit) async {
    final code = _code;
    if (code == null) return;
    if (state case final RecoveryCodeReady ready when ready.isConfirmed && !ready.isStarting) {
      emit(_copy(ready, isStarting: true));
      final verifier = await _backupVerifier.create(code.key);
      switch (await _entitlementRepository.registerBackup(verifier)) {
        case Failure():
          emit(_copy(ready, failure: RecoveryCodeFailure.unreachable));
        case Success(:final data) when data.backupVerifier != verifier:
          emit(_copy(ready, failure: RecoveryCodeFailure.backupExists));
        case Success():
          await _masterKeyStore.write(code.key);
          emit(const RecoveryCodeCommitted());
      }
    }
  }
}

// * failure is always passed explicitly rather than inherited, so a stale
// * rejection cannot survive an unrelated change
RecoveryCodeReady _copy(
  RecoveryCodeReady base, {
  bool? isCopied,
  bool? isConfirmed,
  bool isStarting = false,
  RecoveryCodeFailure? failure,
}) {
  return RecoveryCodeReady(
    groups: base.groups,
    isCopied: isCopied ?? base.isCopied,
    isConfirmed: isConfirmed ?? base.isConfirmed,
    isStarting: isStarting,
    failure: failure,
  );
}
