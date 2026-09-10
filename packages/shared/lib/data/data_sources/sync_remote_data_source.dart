import 'package:book_marker_client/book_marker_client.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/models/remote_sync_write.dart';

// * the only place the generated sync types are used
abstract class SyncRemoteDataSource {
  Future<String> createSyncToken();

  Future<int> upload(List<RemoteSyncWrite> writes);
}

@Injectable(as: SyncRemoteDataSource)
class const SyncRemoteDataSourceImpl(
  final Client _client,
) implements SyncRemoteDataSource {
  @override
  Future<String> createSyncToken() => _client.powerSync.createToken();

  @override
  Future<int> upload(List<RemoteSyncWrite> writes) async {
    final result = await _client.sync.upload([
      for (final write in writes)
        SyncWrite(
          table: write.table,
          operation: write.operation,
          rowId: UuidValue.fromString(write.rowId),
          data: write.data,
        ),
    ]);
    return result.rejected;
  }
}
