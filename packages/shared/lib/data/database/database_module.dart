import 'package:core/security/database_key_store.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/database/sync_database.dart';

@module
abstract class DatabaseModule {
  // * opened before the first frame, because every screen reads through it and
  // * the alternative is a loading state on top of the whole app
  @preResolve
  @lazySingleton
  Future<SyncDatabase> syncDatabase(DatabaseKeyStore keyStore) => SyncDatabase.open(keyStore);

  @lazySingleton
  AppDatabase appDatabase(SyncDatabase syncDatabase) => AppDatabase(syncDatabase.connection);
}
