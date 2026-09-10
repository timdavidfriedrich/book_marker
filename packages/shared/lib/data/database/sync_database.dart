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

  /// Moves a library built without an account into the synced tables.
  ///
  /// The schema swap and the copy happen together: after it, the public view
  /// name belongs to the synced half, and every row that was local only is in
  /// it. The app queries the same table names before and after and never learns
  /// that anything moved.
  ///
  /// The copy is what puts the rows into the CRUD queue, which is how they
  /// reach the server. `owner_id` stays empty here; the server overwrites it
  /// from the session and sends the row back with the real value.
  Future<void> adoptLocalLibrary() async {
    if (_isSynced) return;
    await _database.updateSchema(buildSyncSchema(isSynced: true));
    _isSynced = true;
    await _database.writeTransaction((transaction) async {
      for (final entry in syncedTableColumns.entries) {
        await _copy(transaction, inactiveLocalName(entry.key), entry.key, entry.value);
        await transaction.execute('DELETE FROM ${inactiveLocalName(entry.key)}');
      }
    });
  }

  /// The reverse, for signing out.
  ///
  /// With [keepsRows] the rows are copied back before the swap, because
  /// afterwards the synced half is inactive and gets emptied. Without it
  /// everything goes, which is the "remove from this device" branch of the sign
  /// out dialog.
  ///
  /// The schema always ends up local only, so anything written afterwards stays
  /// on the device instead of queueing an upload for an account that is no
  /// longer signed in.
  Future<void> releaseToLocalLibrary({required bool keepsRows}) async {
    if (!_isSynced) return;
    if (keepsRows) {
      await _database.writeTransaction((transaction) async {
        for (final entry in syncedTableColumns.entries) {
          await _copy(transaction, entry.key, inactiveLocalName(entry.key), entry.value);
        }
      });
    }
    await _database.updateSchema(buildSyncSchema(isSynced: false));
    _isSynced = false;
    // * clearLocal follows keepsRows exactly. The default is true, which would
    // * wipe the local only tables as well, and those are precisely the rows
    // * just copied there to survive the sign out
    await _database.disconnectAndClear(clearLocal: !keepsRows);
  }

  Future<void> _copy(
    SqliteWriteContext transaction,
    String from,
    String to,
    List<String> columns,
  ) {
    final names = ["id", ...columns].join(", ");
    return transaction.execute("INSERT INTO $to ($names) SELECT $names FROM $from");
  }
}
