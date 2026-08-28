import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/database/app_database.dart';

abstract class ThemeLocalDataSource {
  Stream<List<LocalTheme>> watchThemes();

  Future<void> upsertTheme(LocalTheme theme);

  Future<void> renameTheme(String id, String name);

  Future<void> setAccent(String id, String? accent);

  Future<void> deleteTheme(String id);

  Stream<List<LocalThemeMark>> watchThemeMarks();

  Future<void> addMark(String themeId, String bookmarkId);

  Future<void> removeMark(String themeId, String bookmarkId);
}

@Injectable(as: ThemeLocalDataSource)
class const ThemeLocalDataSourceImpl(
  final AppDatabase _database,
) implements ThemeLocalDataSource {
  @override
  Stream<List<LocalTheme>> watchThemes() {
    final query = _database.select(_database.themes)
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]);
    return query.watch();
  }

  @override
  Future<void> upsertTheme(LocalTheme theme) =>
      _database.into(_database.themes).insertOnConflictUpdate(theme);

  @override
  Future<void> renameTheme(String id, String name) {
    final statement = _database.update(_database.themes)..where((table) => table.id.equals(id));
    return statement.write(ThemesCompanion(name: Value(name)));
  }

  @override
  Future<void> setAccent(String id, String? accent) {
    final statement = _database.update(_database.themes)..where((table) => table.id.equals(id));
    return statement.write(ThemesCompanion(accent: Value(accent)));
  }

  @override
  Future<void> deleteTheme(String id) =>
      (_database.delete(_database.themes)..where((table) => table.id.equals(id))).go();

  @override
  Stream<List<LocalThemeMark>> watchThemeMarks() => _database.select(_database.themeMarks).watch();

  @override
  Future<void> addMark(String themeId, String bookmarkId) => _database
      .into(_database.themeMarks)
      .insertOnConflictUpdate(LocalThemeMark(themeId: themeId, bookmarkId: bookmarkId));

  @override
  Future<void> removeMark(String themeId, String bookmarkId) =>
      (_database.delete(_database.themeMarks)
            ..where((table) => table.themeId.equals(themeId) & table.bookmarkId.equals(bookmarkId)))
          .go();
}
