import 'dart:async';

import 'package:core/sync/sync_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SyncCubit extends Cubit<SyncConnectionStatus> {
  SyncCubit(this._syncService) : super(SyncConnectionStatus.disconnected);

  final SyncService _syncService;
  StreamSubscription<SyncConnectionStatus>? _subscription;

  // * only meaningful in the synced state, and the status stream fires whenever
  // * sync finishes, so it is fresh every time it is shown
  DateTime? get lastSyncedAt => _syncService.lastSyncedAt;

  void start() {
    _subscription?.cancel();
    _subscription = _syncService.watchStatus().listen(emit);
  }

  Future<void> retry() => _syncService.connect();

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
