import 'package:drift/drift.dart';
import 'package:drift_sqlite_async/drift_sqlite_async.dart';
import 'package:sqlite_async/sqlite_async.dart';

part 'app_database.g.dart';

// * PowerSync owns every table here. Drift only maps over the views it creates,
// * which is why the migration strategy is empty and the schema version never
// * moves: creating or altering anything from this side would fight the sync
// * engine for ownership of the same tables.
@DataClassName("BookRow")
class Books extends Table {
  TextColumn get id => text()();

  TextColumn get ownerId => text()();

  TextColumn get status => text()();

  TextColumn get createdAt => text()();

  TextColumn get lastUsedAt => text()();

  TextColumn get updatedAt => text()();

  IntColumn get keyVersion => integer()();

  TextColumn get titleCipher => text()();

  TextColumn get authorsCipher => text()();

  TextColumn get isbnCipher => text().nullable()();

  TextColumn get coverCipher => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName("QuoteRow")
class Quotes extends Table {
  TextColumn get id => text()();

  TextColumn get ownerId => text()();

  TextColumn get bookId => text()();

  IntColumn get isFavorite => integer()();

  TextColumn get createdAt => text()();

  TextColumn get updatedAt => text()();

  IntColumn get keyVersion => integer()();

  TextColumn get quoteCipher => text()();

  TextColumn get noteCipher => text().nullable()();

  TextColumn get pageNumbersCipher => text()();

  TextColumn get pagesCipher => text()();

  TextColumn get wordsCipher => text()();

  TextColumn get markedWordIndexesCipher => text()();

  TextColumn get voiceNoteCipher => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName("ShelfRow")
class Shelves extends Table {
  TextColumn get id => text()();

  TextColumn get ownerId => text()();

  TextColumn get accent => text().nullable()();

  TextColumn get symbol => text().nullable()();

  TextColumn get createdAt => text()();

  TextColumn get updatedAt => text()();

  IntColumn get keyVersion => integer()();

  TextColumn get nameCipher => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName("ThemeRow")
class Themes extends Table {
  TextColumn get id => text()();

  TextColumn get ownerId => text()();

  TextColumn get accent => text().nullable()();

  TextColumn get symbol => text().nullable()();

  TextColumn get createdAt => text()();

  TextColumn get updatedAt => text()();

  IntColumn get keyVersion => integer()();

  TextColumn get nameCipher => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

// * the join tables gained an id, because PowerSync cannot sync a composite
// * primary key. The pair stays unique through an index on the server side
@DataClassName("ShelfBookRow")
class ShelfBooks extends Table {
  TextColumn get id => text()();

  TextColumn get ownerId => text()();

  TextColumn get shelfId => text()();

  TextColumn get bookId => text()();

  TextColumn get updatedAt => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName("ThemeQuoteRow")
class ThemeQuotes extends Table {
  TextColumn get id => text()();

  TextColumn get ownerId => text()();

  TextColumn get themeId => text()();

  TextColumn get quoteId => text()();

  TextColumn get updatedAt => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName("LocalAppConfigCache")
class AppConfigCacheTable extends Table {
  TextColumn get id => text()();

  IntColumn get version => integer()();

  TextColumn get fetchedAt => text()();

  TextColumn get payload => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName("LocalSettings")
class SettingsTable extends Table {
  TextColumn get id => text()();

  TextColumn get displayName => text().nullable()();

  TextColumn get localePreference => text().nullable()();

  TextColumn get themePreference => text().nullable()();

  TextColumn get contrastPreference => text().nullable()();

  IntColumn get backupPromptDismissed => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Books,
    Quotes,
    Themes,
    ThemeQuotes,
    Shelves,
    ShelfBooks,
    SettingsTable,
    AppConfigCacheTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(SqliteConnection connection) : super(SqliteAsyncDriftConnection(connection));

  // * ON CONFLICT is not allowed on a view and every PowerSync table is one,
  // * so insertOnConflictUpdate fails at prepare time. INSERT OR REPLACE works:
  // * SQLite passes the conflict clause into the INSTEAD OF trigger, which is
  // * where the row is actually written.
  Future<void> upsert<T extends Table, D>(TableInfo<T, D> table, Insertable<D> row) =>
      into(table).insert(row, mode: InsertMode.insertOrReplace);

  @override
  int get schemaVersion => 1;

  // * both no-ops on purpose. PowerSync created these tables and owns their
  // * shape; the v1 to v12 chain this replaced is gone with the app unreleased
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {},
    onUpgrade: (migrator, from, to) async {},
  );
}
