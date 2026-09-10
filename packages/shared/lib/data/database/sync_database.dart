import 'package:core/security/database_key_store.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:powersync/powersync.dart';
import 'package:shared/data/database/sync_schema.dart';
import 'package:sqlite_async/sqlite_async.dart';

// * a new file, not the old book_marker.sqlite. The schema is not a migration
// * of the previous one and the app is unreleased, so nothing is carried over
const _fileName = "commonplace.db";

// * the only file that constructs a PowerSyncDatabase. Everything above it sees
// * a SqliteConnection, a Drift database, or the SyncService interface, which
// * is what makes the sync engine replaceable.
class SyncDatabase(
  final PowerSyncDatabase _database,
) {
  static Future<SyncDatabase> open(DatabaseKeyStore keyStore) async {
    final directory = await getApplicationDocumentsDirectory();
    final database = PowerSyncDatabase(
      schema: buildSyncSchema(isSynced: false),
      path: p.join(directory.path, _fileName),
      // * the device-local key, never the master key: the database has to open
      // * before anyone has signed in, and it has to keep opening after they
      // * sign out
      encryption: EncryptionOptions(key: await keyStore.readOrCreate()),
    );
    await database.initialize();
    return SyncDatabase(database);
  }

  PowerSyncDatabase get database => _database;

  SqliteConnection get connection => _database;

  bool get isSynced => _isSynced;

  bool _isSynced = false;

  /// Swaps which half of each table pair owns the public view name. The rows
  /// are copied by the caller inside the same transaction, so the app sees one
  /// consistent library before and after and never learns anything moved.
  Future<void> useSchema({required bool isSynced}) async {
    if (_isSynced == isSynced) return;
    await _database.updateSchema(buildSyncSchema(isSynced: isSynced));
    _isSynced = isSynced;
  }
}
