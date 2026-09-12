import 'dart:typed_data';

import 'package:core/error/app_result.dart';
import 'package:core/security/backup_verifier.dart';
import 'package:core/security/master_key_store.dart';
import 'package:core/security/recovery_code.dart';
import 'package:feature_account/presentation/unlock/unlock_event.dart';
import 'package:feature_account/presentation/unlock/unlock_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/database/library_reencryption.dart';
import 'package:shared/domain/repositories/entitlement_repository.dart';

@injectable
class UnlockBloc extends Bloc<UnlockEvent, UnlockState> {
  UnlockBloc(
    this._entitlementRepository,
    this._backupVerifier,
    this._masterKeyStore,
    this._reencryption,
  ) : super(const UnlockPreparing()) {
    on<UnlockStarted>(_onStarted);
    on<UnlockSubmitted>(_onSubmitted);
  }

  final EntitlementRepository _entitlementRepository;
  final BackupVerifier _backupVerifier;
  final MasterKeyStore _masterKeyStore;
  final LibraryReencryption _reencryption;
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

    // * a device that was used before signing in already holds a key, and every
    // * local row is encrypted under it. Adopting the account's key without
    // * rewriting them first would not just hide them, it would adopt them into
    // * the account as ciphertext nobody can ever open
    final current = await _masterKeyStore.read();
    if (current != null && !_isSameKey(current, code.key)) {
      try {
        await _reencryption.rotate(from: current, to: code.key);
      } on Object {
        // * the key is deliberately not written. Committing it after a failed
        // * rewrite would leave the library encrypted under a key that is gone,
        // * so refusing is the only non destructive answer. It reads as a wrong
        // * code, which is wrong, but it is recoverable and losing the library
        // * is not
        emit(const UnlockReady(isChecking: false, hasFailed: true));
        return;
      }
    }

    await _masterKeyStore.write(code.key);
    emit(const UnlockSucceeded());
  }
}

bool _isSameKey(Uint8List a, Uint8List b) {
  if (a.length != b.length) return false;
  for (var index = 0; index < a.length; index++) {
    if (a[index] != b[index]) return false;
  }
  return true;
}
