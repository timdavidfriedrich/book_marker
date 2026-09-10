import 'package:core/error/app_result.dart';
import 'package:core/sync/sync_service.dart';
import 'package:feature_account/presentation/delete_account/delete_account_event.dart';
import 'package:feature_account/presentation/delete_account/delete_account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/repositories/auth_repository.dart';

@injectable
class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  DeleteAccountBloc(this._authRepository, this._syncService)
    : super(const DeleteAccountIdle(hasFailed: false)) {
    on<DeleteAccountConfirmed>(_onConfirmed);
  }

  final AuthRepository _authRepository;
  final SyncService _syncService;

  // * the library comes back to the device before anything is destroyed, so
  // * the promise on the screen holds even if the delete fails halfway through
  Future<void> _onConfirmed(
    DeleteAccountConfirmed event,
    Emitter<DeleteAccountState> emit,
  ) async {
    if (state is DeleteAccountRunning) return;
    emit(const DeleteAccountRunning());
    await _syncService.disconnect(clearsLocalData: false);
    switch (await _authRepository.deleteAccount()) {
      case Success():
        emit(const DeleteAccountDone());
      case Failure():
        emit(const DeleteAccountIdle(hasFailed: true));
    }
  }
}
