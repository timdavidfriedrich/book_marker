import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/database/cipher_codec.dart';
import 'package:shared/data/database/row_defaults.dart';
import 'package:shared/data/database/timestamp_codec.dart';
import 'package:shared/data/models/local_theme.dart';
import 'package:uuid/uuid.dart';

abstract class ThemeLocalDataSource {
  Stream<List<LocalTheme>> watchThemes();

  Future<List<LocalTheme>> loadThemes();

  Future<void> upsertTheme(LocalTheme theme);

  Future<void> renameTheme(String id, String name);

  Future<void> setAccent(String id, String accent);

  Future<void> setSymbol(String id, String symbol);

  Future<void> deleteTheme(String id);

  Stream<List<LocalThemeQuote>> watchThemeQuotes();

  Future<void> addQuote(String themeId, String quoteId);

  Future<void> removeQuote(String themeId, String quoteId);

  Future<void> removeAllQuotes(String themeId);

  Future<void> removeQuoteEverywhere(String quoteId);
}

@Injectable(as: ThemeLocalDataSource)
class const ThemeLocalDataSourceImpl(
  final AppDatabase _database,
  final CipherCodec _codec,
) implements ThemeLocalDataSource {
  @override
  Stream<List<LocalTheme>> watchThemes() {
    final query = _database.select(_database.themes)
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]);
    return query.watch().asyncMap(_decodeAll);
  }

  @override
  Future<List<LocalTheme>> loadThemes() async =>
      _decodeAll(await _database.select(_database.themes).get());

  @override
  Future<void> upsertTheme(LocalTheme theme) async => _database.upsert(
    _database.themes,
    ThemesCompanion.insert(
      id: theme.id,
      ownerId: unownedRow,
      accent: Value(theme.accent),
      symbol: Value(theme.symbol),
      createdAt: encodeTimestamp(theme.createdAt),
      updatedAt: encodeTimestamp(DateTime.now()),
      keyVersion: currentKeyVersion,
      nameCipher: await _codec.encode(theme.name),
    ),
  );

  @override
  Future<void> renameTheme(String id, String name) async =>
      _write(id, ThemesCompanion(nameCipher: Value(await _codec.encode(name))));

  @override
  Future<void> setAccent(String id, String accent) =>
      _write(id, ThemesCompanion(accent: Value(accent)));

  @override
  Future<void> setSymbol(String id, String symbol) =>
      _write(id, ThemesCompanion(symbol: Value(symbol)));

  @override
  Future<void> deleteTheme(String id) =>
      (_database.delete(_database.themes)..where((table) => table.id.equals(id))).go();

  @override
  Stream<List<LocalThemeQuote>> watchThemeQuotes() => _database
      .select(_database.themeQuotes)
      .watch()
      .map(
        (rows) => rows
            .map((row) => LocalThemeQuote(id: row.id, themeId: row.themeId, quoteId: row.quoteId))
            .toList(),
      );

  @override
  Future<void> addQuote(String themeId, String quoteId) async {
    // * the pair used to be the primary key. PowerSync needs a single column id
    // * instead, so a repeated add has to be caught here rather than by the
    // * database refusing it
    final existing = _database.select(_database.themeQuotes)
      ..where((table) => table.themeId.equals(themeId) & table.quoteId.equals(quoteId));
    if ((await existing.get()).isNotEmpty) return;
    await _database.upsert(
      _database.themeQuotes,
      ThemeQuotesCompanion.insert(
        id: const Uuid().v4(),
        ownerId: unownedRow,
        themeId: themeId,
        quoteId: quoteId,
        updatedAt: encodeTimestamp(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> removeQuote(String themeId, String quoteId) => (_database.delete(
    _database.themeQuotes,
  )..where((table) => table.themeId.equals(themeId) & table.quoteId.equals(quoteId))).go();

  // * there is no foreign key to cascade from any more: PowerSync tables are
  // * views over an opaque store, so the link rows have to be removed here or
  // * they outlive what they point at and sync as orphans
  @override
  Future<void> removeAllQuotes(String themeId) => (_database.delete(
    _database.themeQuotes,
  )..where((table) => table.themeId.equals(themeId))).go();

  @override
  Future<void> removeQuoteEverywhere(String quoteId) => (_database.delete(
    _database.themeQuotes,
  )..where((table) => table.quoteId.equals(quoteId))).go();

  Future<void> _write(String id, ThemesCompanion changes) {
    final statement = _database.update(_database.themes)..where((table) => table.id.equals(id));
    return statement.write(
      changes.copyWith(updatedAt: Value(encodeTimestamp(DateTime.now()))),
    );
  }

  Future<List<LocalTheme>> _decodeAll(List<ThemeRow> rows) => Future.wait(rows.map(_decode));

  Future<LocalTheme> _decode(ThemeRow row) async {
    return LocalTheme(
      id: row.id,
      name: await _codec.decode(row.nameCipher),
      accent: row.accent,
      symbol: row.symbol,
      createdAt: decodeTimestamp(row.createdAt),
    );
  }
}
