import 'package:injectable/injectable.dart';
import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/database/sync_schema.dart';

abstract class AppConfigLocalDataSource {
  Stream<LocalAppConfigCache?> watchCache();

  Future<void> upsertCache(LocalAppConfigCache cache);
}

@Injectable(as: AppConfigLocalDataSource)
class const AppConfigLocalDataSourceImpl(
  final AppDatabase _database,
) implements AppConfigLocalDataSource {
  @override
  Stream<LocalAppConfigCache?> watchCache() {
    final query = _database.select(_database.appConfigCacheTable)
      ..where((table) => table.id.equals(appConfigCacheRowId));
    return query.watchSingleOrNull();
  }

  @override
  Future<void> upsertCache(LocalAppConfigCache cache) =>
      _database.upsert(_database.appConfigCacheTable, cache);
}
