import 'package:core/sync/sync_service.dart';
import 'package:injectable/injectable.dart';
import 'package:powersync/powersync.dart' as ps;
import 'package:shared/data/database/power_sync_connector.dart';
import 'package:shared/data/database/sync_database.dart';

@LazySingleton(as: SyncService)
class const PowerSyncService(
  final SyncDatabase _syncDatabase,
  final PowerSyncConnector _connector,
) implements SyncService {
  @override
  DateTime? get lastSyncedAt => _syncDatabase.database.currentStatus.lastSyncedAt;

  @override
  Stream<SyncConnectionStatus> watchStatus() => _syncDatabase.database.statusStream.map(_toStatus);

  // * adopting first is not optional: while the local only half owns the table
  // * names, a connected database would download rows into tables the app does
  // * not query, and the library would look empty while syncing perfectly
  @override
  Future<void> connect() async {
    await _syncDatabase.adoptLocalLibrary();
    await _syncDatabase.database.connect(connector: _connector);
  }

  // * clearsLocalData false is the "keep the library on this device" branch of
  // * signing out: the connection stops, the rows stay readable
  @override
  Future<void> disconnect({required bool clearsLocalData}) async {
    await _syncDatabase.releaseToLocalLibrary(keepsRows: !clearsLocalData);
  }
}

SyncConnectionStatus _toStatus(ps.SyncStatus status) {
  if (status.anyError != null) return SyncConnectionStatus.failed;
  if (!status.connected) {
    return status.connecting ? SyncConnectionStatus.connecting : SyncConnectionStatus.disconnected;
  }
  if (status.downloading || status.uploading) return SyncConnectionStatus.syncing;
  return SyncConnectionStatus.synced;
}
