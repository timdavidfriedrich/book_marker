import 'package:injectable/injectable.dart';
import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/database/sync_schema.dart';

abstract class SettingsLocalDataSource {
  Stream<LocalSettings?> watchSettings();

  Future<LocalSettings?> readSettings();

  Future<void> upsertSettings(LocalSettings settings);
}

@Injectable(as: SettingsLocalDataSource)
class const SettingsLocalDataSourceImpl(
  final AppDatabase _database,
) implements SettingsLocalDataSource {
  @override
  Stream<LocalSettings?> watchSettings() {
    final query = _database.select(_database.settingsTable)
      ..where((table) => table.id.equals(settingsRowId));
    return query.watchSingleOrNull();
  }

  @override
  Future<LocalSettings?> readSettings() {
    final query = _database.select(_database.settingsTable)
      ..where((table) => table.id.equals(settingsRowId));
    return query.getSingleOrNull();
  }

  @override
  Future<void> upsertSettings(LocalSettings settings) =>
      _database.upsert(_database.settingsTable, settings);
}
