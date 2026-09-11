import 'package:core/security/database_key_store.dart';
import 'package:core/sync/attachment_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/quote_local_data_source.dart';
import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/database/attachment_paths.dart';
import 'package:shared/data/database/encrypted_attachment_storage.dart';
import 'package:shared/data/database/power_sync_attachment_service.dart';
import 'package:shared/data/database/sync_database.dart';

@module
abstract class DatabaseModule {
  // * opened before the first frame, because every screen reads through it and
  // * the alternative is a loading state on top of the whole app
  @preResolve
  @lazySingleton
  Future<SyncDatabase> syncDatabase(DatabaseKeyStore keyStore) => SyncDatabase.open(keyStore);

  @preResolve
  @lazySingleton
  Future<AttachmentPaths> attachmentPaths() => AttachmentPaths.resolve();

  // * preResolve so the name check runs before the first screen reads anything
  @preResolve
  @lazySingleton
  Future<AppDatabase> appDatabase(SyncDatabase syncDatabase) async {
    final database = AppDatabase(syncDatabase.connection);
    await verifyTablesExist(database, syncDatabase.connection);
    return database;
  }

  // * built even for a free account. The queue is the gate: while it is stopped
  // * files are still written locally and simply never leave the device
  @preResolve
  @lazySingleton
  Future<AttachmentService> attachmentService(
    SyncDatabase syncDatabase,
    EncryptedAttachmentStorage storage,
    AttachmentPaths paths,
    QuoteLocalDataSource quotes,
  ) => PowerSyncAttachmentService.open(
    syncDatabase: syncDatabase,
    storage: storage,
    paths: paths,
    quotes: quotes,
  );
}
