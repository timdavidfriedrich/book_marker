import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:shared/data/database/converters.dart';
import 'package:shared/domain/entities/quote_page.dart';

part 'app_database.g.dart';

const _databaseName = "book_marker";
const _statusReading = "reading";
const _legacyQuotesTable = "bookmarks";
const _legacyQuoteThemesTable = "theme_marks";
const _legacyQuoteIdColumn = "bookmark_id";
const _legacyVoiceNotePathColumn = "voice_path";
const _legacyVoiceNoteDurationColumn = "voice_duration_ms";
// * the single photo of a legacy quote becomes the first page of its page list
const _legacySinglePageExpression =
    "json_array(json_object("
    "'photoPath', photo_path, "
    "'imageAspectRatio', image_aspect_ratio, "
    "'highlights', json(highlights)))";
const _legacyPageNumbersExpression =
    "case when page_number is null then json_array() else json_array(page_number) end";

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

@DataClassName("LocalQuote")
class Quotes extends Table {
  TextColumn get id => text()();

  TextColumn get bookId => text().references(Books, #id, onDelete: KeyAction.cascade)();

  TextColumn get pageNumbers => text().map(const IntListConverter())();

  TextColumn get quote => text()();

  TextColumn get note => text().nullable()();

  TextColumn get voiceNotePath => text().nullable()();

  IntColumn get voiceNoteDurationMs => integer().nullable()();

  TextColumn get pages => text().map(const QuotePageListConverter())();

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

@DataClassName("LocalThemeQuote")
class ThemeQuotes extends Table {
  TextColumn get themeId => text().references(Themes, #id, onDelete: KeyAction.cascade)();

  TextColumn get quoteId => text().references(Quotes, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {themeId, quoteId};
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

@DriftDatabase(tables: [Books, Quotes, Themes, ThemeQuotes, Shelves, ShelfBooks, SettingsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: _databaseName));

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 6) {
        await migrator.renameTable(quotes, _legacyQuotesTable);
        if (from >= 2) {
          await migrator.renameTable(themeQuotes, _legacyQuoteThemesTable);
          await migrator.renameColumn(themeQuotes, _legacyQuoteIdColumn, themeQuotes.quoteId);
        }
        if (from >= 3) {
          await migrator.renameColumn(quotes, _legacyVoiceNotePathColumn, quotes.voiceNotePath);
          await migrator.renameColumn(
            quotes,
            _legacyVoiceNoteDurationColumn,
            quotes.voiceNoteDurationMs,
          );
        }
      }
      if (from < 2) {
        await migrator.addColumn(books, books.status);
        await migrator.addColumn(quotes, quotes.note);
        await migrator.createTable(themes);
        await migrator.createTable(themeQuotes);
        await migrator.createTable(shelves);
        await migrator.createTable(shelfBooks);
      }
      if (from < 3) {
        await migrator.addColumn(quotes, quotes.voiceNotePath);
        await migrator.addColumn(quotes, quotes.voiceNoteDurationMs);
      }
      if (from < 4) {
        await migrator.addColumn(themes, themes.accent);
        await migrator.addColumn(shelves, shelves.accent);
      }
      if (from < 5) {
        await migrator.createTable(settingsTable);
      }
      if (from < 8) {
        await migrator.alterTable(
          TableMigration(
            quotes,
            newColumns: [if (from < 7) quotes.pages, quotes.pageNumbers],
            columnTransformer: {
              if (from < 7)
                quotes.pages: const CustomExpression<String>(_legacySinglePageExpression),
              quotes.pageNumbers: const CustomExpression<String>(_legacyPageNumbersExpression),
            },
          ),
        );
      }
    },
  );
}
