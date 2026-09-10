import 'package:powersync/powersync.dart';

const _books = "books";
const _quotes = "quotes";
const _shelves = "shelves";
const _themes = "themes";
const _shelfBooks = "shelf_books";
const _themeQuotes = "theme_quotes";
const _entitlements = "entitlements";

// * the six tables that exist twice, once synced and once local only, with the
// * columns each pair shares. Adoption copies between them by name, so the two
// * halves must stay identical
const syncedTableColumns = <String, List<String>>{
  _books: _bookColumnNames,
  _quotes: _quoteColumnNames,
  _shelves: _collectionColumnNames,
  _themes: _collectionColumnNames,
  _shelfBooks: _shelfBookColumnNames,
  _themeQuotes: _themeQuoteColumnNames,
};

String inactiveSyncedName(String table) => "inactive_synced_$table";

String inactiveLocalName(String table) => "inactive_local_$table";

const settingsTableName = "settings";
const appConfigCacheTableName = "app_config_cache";
const settingsRowId = "settings";
const appConfigCacheRowId = "config";

// * every table is declared twice, once synced and once local only. The two
// * physical tables always keep their own names; only the VIEW name flips, so
// * exactly one of them answers to `books` at a time and no data ever has to
// * move between storage. Swapping which half owns the public name is how a
// * library built without an account is adopted into one.
Schema buildSyncSchema({required bool isSynced}) {
  String syncedView(String table) => isSynced ? table : inactiveSyncedName(table);
  String localView(String table) => isSynced ? inactiveLocalName(table) : table;

  return Schema([
    Table(_books, _bookColumns, viewName: syncedView(_books)),
    Table.localOnly(_localName(_books), _bookColumns, viewName: localView(_books)),
    Table(
      _quotes,
      _quoteColumns,
      viewName: syncedView(_quotes),
      indexes: const [
        Index("book", [IndexedColumn("book_id")]),
      ],
    ),
    Table.localOnly(_localName(_quotes), _quoteColumns, viewName: localView(_quotes)),
    Table(_shelves, _collectionColumns, viewName: syncedView(_shelves)),
    Table.localOnly(_localName(_shelves), _collectionColumns, viewName: localView(_shelves)),
    Table(_themes, _collectionColumns, viewName: syncedView(_themes)),
    Table.localOnly(_localName(_themes), _collectionColumns, viewName: localView(_themes)),
    Table(
      _shelfBooks,
      _shelfBookColumns,
      viewName: syncedView(_shelfBooks),
      indexes: const [
        Index("shelf", [IndexedColumn("shelf_id")]),
      ],
    ),
    Table.localOnly(
      _localName(_shelfBooks),
      _shelfBookColumns,
      viewName: localView(_shelfBooks),
    ),
    Table(
      _themeQuotes,
      _themeQuoteColumns,
      viewName: syncedView(_themeQuotes),
      indexes: const [
        Index("theme", [IndexedColumn("theme_id")]),
      ],
    ),
    Table.localOnly(
      _localName(_themeQuotes),
      _themeQuoteColumns,
      viewName: localView(_themeQuotes),
    ),
    // * server owned and read only here. It has no local only twin: without an
    // * account there is no entitlement to hold
    const Table(_entitlements, _entitlementColumns),
    // * never leaves the device in either mode
    const Table.localOnly(settingsTableName, _settingsColumns),
    const Table.localOnly(appConfigCacheTableName, _appConfigCacheColumns),
  ]);
}

String _localName(String table) => "local_$table";

const _bookColumnNames = [
  "owner_id",
  "status",
  "created_at",
  "last_used_at",
  "updated_at",
  "key_version",
  "title_cipher",
  "authors_cipher",
  "isbn_cipher",
  "cover_cipher",
];

const _bookColumns = <Column>[
  Column.text("owner_id"),
  Column.text("status"),
  Column.text("created_at"),
  Column.text("last_used_at"),
  Column.text("updated_at"),
  Column.integer("key_version"),
  Column.text("title_cipher"),
  Column.text("authors_cipher"),
  Column.text("isbn_cipher"),
  Column.text("cover_cipher"),
];

const _quoteColumnNames = [
  "owner_id",
  "book_id",
  "is_favorite",
  "created_at",
  "updated_at",
  "key_version",
  "quote_cipher",
  "note_cipher",
  "page_numbers_cipher",
  "pages_cipher",
  "words_cipher",
  "marked_word_indexes_cipher",
  "voice_note_cipher",
];

const _quoteColumns = <Column>[
  Column.text("owner_id"),
  Column.text("book_id"),
  Column.integer("is_favorite"),
  Column.text("created_at"),
  Column.text("updated_at"),
  Column.integer("key_version"),
  Column.text("quote_cipher"),
  Column.text("note_cipher"),
  Column.text("page_numbers_cipher"),
  Column.text("pages_cipher"),
  Column.text("words_cipher"),
  Column.text("marked_word_indexes_cipher"),
  Column.text("voice_note_cipher"),
];

const _collectionColumnNames = [
  "owner_id",
  "accent",
  "symbol",
  "created_at",
  "updated_at",
  "key_version",
  "name_cipher",
];

const _collectionColumns = <Column>[
  Column.text("owner_id"),
  Column.text("accent"),
  Column.text("symbol"),
  Column.text("created_at"),
  Column.text("updated_at"),
  Column.integer("key_version"),
  Column.text("name_cipher"),
];

const _shelfBookColumnNames = ["owner_id", "shelf_id", "book_id", "updated_at"];

const _shelfBookColumns = <Column>[
  Column.text("owner_id"),
  Column.text("shelf_id"),
  Column.text("book_id"),
  Column.text("updated_at"),
];

const _themeQuoteColumnNames = ["owner_id", "theme_id", "quote_id", "updated_at"];

const _themeQuoteColumns = <Column>[
  Column.text("owner_id"),
  Column.text("theme_id"),
  Column.text("quote_id"),
  Column.text("updated_at"),
];

const _entitlementColumns = <Column>[
  Column.text("owner_id"),
  Column.text("plan"),
  Column.text("status"),
  Column.text("blocked_reason"),
  Column.text("blocked_at"),
  Column.integer("used_day"),
  Column.integer("used_week"),
  Column.integer("used_month"),
  Column.text("updated_at"),
  Column.text("backup_verifier"),
  Column.text("backup_initialized_at"),
  Column.text("store"),
  Column.text("product_id"),
  Column.text("purchase_token"),
  Column.text("purchased_at"),
  Column.text("refunded_at"),
];

const _settingsColumns = <Column>[
  Column.text("display_name"),
  Column.text("locale_preference"),
  Column.text("theme_preference"),
  Column.text("contrast_preference"),
  Column.integer("backup_prompt_dismissed"),
];

const _appConfigCacheColumns = <Column>[
  Column.integer("version"),
  Column.text("fetched_at"),
  Column.text("payload"),
];
