import 'package:core/security/master_key_store.dart';
import 'package:core/security/recovery_code.dart';
import 'package:feature_account/presentation/recovery_code/recovery_code_event.dart';
import 'package:feature_account/presentation/recovery_code/recovery_code_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecoveryCodeBloc extends Bloc<RecoveryCodeEvent, RecoveryCodeState> {
  RecoveryCodeBloc(this._masterKeyStore) : super(const RecoveryCodeGenerating()) {
    on<RecoveryCodeStarted>(_onStarted);
    on<RecoveryCodeCopied>(_onCopied);
    on<RecoveryCodeConfirmationToggled>(_onConfirmationToggled);
    on<RecoveryCodeAccepted>(_onAccepted);
  }

  final MasterKeyStore _masterKeyStore;
  RecoveryCode? _code;

  Uint8List? get key => _code?.key;

  void _onStarted(RecoveryCodeStarted event, Emitter<RecoveryCodeState> emit) {
    final code = _code ??= RecoveryCode.generate();
    emit(
      RecoveryCodeReady(
        groups: code.groups,
        isCopied: false,
        isConfirmed: false,
        isStarting: false,
      ),
    );
  }

  Future<void> _onCopied(RecoveryCodeCopied event, Emitter<RecoveryCodeState> emit) async {
    final code = _code;
    if (code == null) return;
    if (state case final RecoveryCodeReady ready) {
      await Clipboard.setData(ClipboardData(text: code.formatted));
      emit(ready.copyWith(isCopied: true));
    }
  }

  void _onConfirmationToggled(
    RecoveryCodeConfirmationToggled event,
    Emitter<RecoveryCodeState> emit,
  ) {
    if (state case final RecoveryCodeReady ready) {
      emit(ready.copyWith(isConfirmed: !ready.isConfirmed));
    }
  }

  // * the key is only written once the user confirms they saved the code, so an
  // * abandoned setup leaves nothing behind that could later be mistaken for a
  // * usable backup
  Future<void> _onAccepted(RecoveryCodeAccepted event, Emitter<RecoveryCodeState> emit) async {
    final code = _code;
    if (code == null) return;
    if (state case final RecoveryCodeReady ready when ready.isConfirmed) {
      emit(ready.copyWith(isStarting: true));
      await _masterKeyStore.write(code.key);
    }
  }
}

extension on RecoveryCodeReady {
  RecoveryCodeReady copyWith({bool? isCopied, bool? isConfirmed, bool? isStarting}) {
    return RecoveryCodeReady(
      groups: groups,
      isCopied: isCopied ?? this.isCopied,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      isStarting: isStarting ?? this.isStarting,
    );
  }
}
