import 'package:core/config/build_config.dart';
import 'package:drift/drift.dart';
import 'package:drift_sqlite_async/drift_sqlite_async.dart';
import 'package:flutter/foundation.dart';
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
  // * PowerSync created the view, so its name is the one that exists. Drift
  // * would otherwise derive `app_config_cache_table` from the class name and
  // * query a table that is not there
  @override
  String get tableName => "app_config_cache";

  TextColumn get id => text()();

  IntColumn get version => integer()();

  TextColumn get fetchedAt => text()();

  TextColumn get payload => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName("LocalSettings")
class SettingsTable extends Table {
  @override
  String get tableName => "settings";

  TextColumn get id => text()();

  TextColumn get displayName => text().nullable()();

  TextColumn get localePreference => text().nullable()();

  TextColumn get themePreference => text().nullable()();

  TextColumn get contrastPreference => text().nullable()();

  IntColumn get backupPromptDismissed => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

// * Drift derives a table name from the class name, PowerSync creates the view
// * from the schema, and nothing checks that the two agree. When they did not,
// * every read threw "no such table", each repository turned that into a
// * Failure, and the app quietly fell back to defaults: settings stopped
// * persisting and a signed in account looked like an unreachable server.
Future<void> verifyTablesExist(AppDatabase database, SqliteConnection connection) async {
  final rows = await connection.getAll(
    "SELECT name FROM sqlite_master WHERE type IN ('table', 'view')",
  );
  final present = rows.map((row) => row['name'] as String).toSet();
  final missing = database.allTables
      .map((table) => table.actualTableName)
      .where((name) => !present.contains(name))
      .toList();
  if (missing.isEmpty) return;
  final message =
      'The database has no ${missing.join(", ")}. Drift and the PowerSync '
      'schema disagree about the name; see sync_schema.dart.';
  // * loud in development, where it is a bug being written, and survivable in
  // * release, where crashing on every launch would be worse than degraded
  if (isInDebugMode) throw StateError(message);
  debugPrint(message);
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
