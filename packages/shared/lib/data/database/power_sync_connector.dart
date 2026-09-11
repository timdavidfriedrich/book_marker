import 'dart:convert';

import 'package:core/config/build_config.dart';
import 'package:injectable/injectable.dart';
import 'package:powersync/powersync.dart';
import 'package:shared/data/data_sources/sync_remote_data_source.dart';
import 'package:shared/data/models/remote_sync_write.dart';

// * the file where the two vendors meet: PowerSync's CRUD queue on one side,
// * the generated Serverpod client on the other. Everything else sees the
// * SyncService interface
@lazySingleton
class PowerSyncConnector(
  final SyncRemoteDataSource _dataSource,
) extends PowerSyncBackendConnector {
  @override
  Future<PowerSyncCredentials?> fetchCredentials() async {
    if (syncBaseUrl.isEmpty) return null;
    return PowerSyncCredentials(
      endpoint: syncBaseUrl,
      token: await _dataSource.createSyncToken(),
    );
  }

  @override
  Future<void> uploadData(PowerSyncDatabase database) async {
    final transaction = await database.getNextCrudTransaction();
    if (transaction == null) return;

    await _dataSource.upload([
      for (final entry in transaction.crud)
        RemoteSyncWrite(
          table: entry.table,
          operation: entry.op.toJson().toLowerCase(),
          rowId: entry.id,
          data: entry.opData == null ? null : jsonEncode(entry.opData),
        ),
    ]);

    // * only once the server has taken them. Completing after a failure would
    // * drop the writes silently; leaving it uncompleted retries the same batch,
    // * which is the right behaviour for a server that is simply unreachable
    await transaction.complete();
  }
}
