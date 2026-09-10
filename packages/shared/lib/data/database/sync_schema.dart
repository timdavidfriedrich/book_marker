import 'package:powersync/powersync.dart';

const _books = "books";
const _quotes = "quotes";
const _shelves = "shelves";
const _themes = "themes";
const _shelfBooks = "shelf_books";
const _themeQuotes = "theme_quotes";
const _entitlements = "entitlements";

const settingsTableName = "settings";
const appConfigCacheTableName = "app_config_cache";
const settingsRowId = "settings";
const appConfigCacheRowId = "config";

// * every table is declared twice, once synced and once local only, and the
// * inactive half is parked under a prefixed name. Swapping which half owns the
// * public name is how a library built without an account is adopted into one:
// * the rows are copied across inside a single transaction and the views change
// * underneath the app, which never learns that anything moved.
Schema buildSyncSchema({required bool isSynced}) {
  String synced(String table) => isSynced ? table : "inactive_synced_$table";
  String local(String table) => isSynced ? "inactive_local_$table" : table;

  return Schema([
    for (final name in [synced(_books), local(_books)])
      _table(name, _bookColumns, isLocalOnly: name == local(_books)),
    for (final name in [synced(_quotes), local(_quotes)])
      _table(
        name,
        _quoteColumns,
        isLocalOnly: name == local(_quotes),
        indexes: [
          const Index("book", [IndexedColumn("book_id")]),
        ],
      ),
    for (final name in [synced(_shelves), local(_shelves)])
      _table(name, _collectionColumns, isLocalOnly: name == local(_shelves)),
    for (final name in [synced(_themes), local(_themes)])
      _table(name, _collectionColumns, isLocalOnly: name == local(_themes)),
    for (final name in [synced(_shelfBooks), local(_shelfBooks)])
      _table(
        name,
        _shelfBookColumns,
        isLocalOnly: name == local(_shelfBooks),
        indexes: [
          const Index("shelf", [IndexedColumn("shelf_id")]),
        ],
      ),
    for (final name in [synced(_themeQuotes), local(_themeQuotes)])
      _table(
        name,
        _themeQuoteColumns,
        isLocalOnly: name == local(_themeQuotes),
        indexes: [
          const Index("theme", [IndexedColumn("theme_id")]),
        ],
      ),
    // * server owned and read only here. It has no local only twin: without an
    // * account there is no entitlement to hold
    const Table(_entitlements, _entitlementColumns),
    // * never leaves the device in either mode
    const Table.localOnly(settingsTableName, _settingsColumns),
    const Table.localOnly(appConfigCacheTableName, _appConfigCacheColumns),
  ]);
}

Table _table(
  String name,
  List<Column> columns, {
  required bool isLocalOnly,
  List<Index> indexes = const [],
}) {
  return isLocalOnly
      ? Table.localOnly(name, columns, indexes: indexes)
      : Table(name, columns, indexes: indexes);
}

// * owner_id is carried even in local only mode, where it stays empty. Keeping
// * the two shapes identical is what lets the adoption copy be a plain INSERT
// * SELECT rather than a column-by-column rewrite.
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

const _collectionColumns = <Column>[
  Column.text("owner_id"),
  Column.text("accent"),
  Column.text("symbol"),
  Column.text("created_at"),
  Column.text("updated_at"),
  Column.integer("key_version"),
  Column.text("name_cipher"),
];

const _shelfBookColumns = <Column>[
  Column.text("owner_id"),
  Column.text("shelf_id"),
  Column.text("book_id"),
  Column.text("updated_at"),
];

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
];

const _appConfigCacheColumns = <Column>[
  Column.integer("version"),
  Column.text("fetched_at"),
  Column.text("payload"),
];
