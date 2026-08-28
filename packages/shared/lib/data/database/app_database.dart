import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:shared/data/database/converters.dart';
import 'package:shared/domain/entities/highlight_region.dart';

part 'app_database.g.dart';

const _databaseName = "book_marker";
const _statusReading = "reading";

@DataClassName("LocalBook")
class Books extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get authors => text().map(const StringListConverter())();

  TextColumn get isbn => text().nullable()();

  TextColumn get thumbnailUrl => text().nullable()();

  TextColumn get status => text().withDefault(const Constant(_statusReading))();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get lastUsedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName("LocalBookmark")
class Bookmarks extends Table {
  TextColumn get id => text()();

  TextColumn get bookId => text().references(Books, #id, onDelete: KeyAction.cascade)();

  IntColumn get pageNumber => integer().nullable()();

  TextColumn get quote => text()();

  TextColumn get note => text().nullable()();

  TextColumn get voicePath => text().nullable()();

  IntColumn get voiceDurationMs => integer().nullable()();

  TextColumn get photoPath => text()();

  RealColumn get imageAspectRatio => real()();

  TextColumn get highlights => text().map(const HighlightListConverter())();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName("LocalTheme")
class Themes extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get accent => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName("LocalThemeMark")
class ThemeMarks extends Table {
  TextColumn get themeId => text().references(Themes, #id, onDelete: KeyAction.cascade)();

  TextColumn get bookmarkId => text().references(Bookmarks, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {themeId, bookmarkId};
}

@DataClassName("LocalShelf")
class Shelves extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get accent => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName("LocalShelfBook")
class ShelfBooks extends Table {
  TextColumn get shelfId => text().references(Shelves, #id, onDelete: KeyAction.cascade)();

  TextColumn get bookId => text().references(Books, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {shelfId, bookId};
}

@DataClassName("LocalSettings")
class SettingsTable extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();

  TextColumn get displayName => text().nullable()();

  TextColumn get localePreference => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [Books, Bookmarks, Themes, ThemeMarks, Shelves, ShelfBooks, SettingsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: _databaseName));

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(books, books.status);
        await migrator.addColumn(bookmarks, bookmarks.note);
        await migrator.createTable(themes);
        await migrator.createTable(themeMarks);
        await migrator.createTable(shelves);
        await migrator.createTable(shelfBooks);
      }
      if (from < 3) {
        await migrator.addColumn(bookmarks, bookmarks.voicePath);
        await migrator.addColumn(bookmarks, bookmarks.voiceDurationMs);
      }
      if (from < 4) {
        await migrator.addColumn(themes, themes.accent);
        await migrator.addColumn(shelves, shelves.accent);
      }
      if (from < 5) {
        await migrator.createTable(settingsTable);
      }
    },
  );
}
