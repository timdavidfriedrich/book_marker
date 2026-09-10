import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/database/cipher_codec.dart';
import 'package:shared/data/database/row_defaults.dart';
import 'package:shared/data/database/timestamp_codec.dart';
import 'package:shared/data/models/local_shelf.dart';
import 'package:uuid/uuid.dart';

abstract class ShelfLocalDataSource {
  Stream<List<LocalShelf>> watchShelves();

  Future<List<LocalShelf>> loadShelves();

  Future<void> upsertShelf(LocalShelf shelf);

  Future<void> renameShelf(String id, String name);

  Future<void> setAccent(String id, String accent);

  Future<void> setSymbol(String id, String symbol);

  Future<void> deleteShelf(String id);

  Stream<List<LocalShelfBook>> watchShelfBooks();

  Future<void> addBook(String shelfId, String bookId);

  Future<void> removeBook(String shelfId, String bookId);

  Future<void> removeAllBooks(String shelfId);

  Future<void> removeBookEverywhere(String bookId);
}

@Injectable(as: ShelfLocalDataSource)
class const ShelfLocalDataSourceImpl(
  final AppDatabase _database,
  final CipherCodec _codec,
) implements ShelfLocalDataSource {
  @override
  Stream<List<LocalShelf>> watchShelves() {
    final query = _database.select(_database.shelves)
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]);
    return query.watch().asyncMap(_decodeAll);
  }

  @override
  Future<List<LocalShelf>> loadShelves() async =>
      _decodeAll(await _database.select(_database.shelves).get());

  @override
  Future<void> upsertShelf(LocalShelf shelf) async => _database.upsert(
    _database.shelves,
    ShelvesCompanion.insert(
      id: shelf.id,
      ownerId: unownedRow,
      accent: Value(shelf.accent),
      symbol: Value(shelf.symbol),
      createdAt: encodeTimestamp(shelf.createdAt),
      updatedAt: encodeTimestamp(DateTime.now()),
      keyVersion: currentKeyVersion,
      nameCipher: await _codec.encode(shelf.name),
    ),
  );

  @override
  Future<void> renameShelf(String id, String name) async =>
      _write(id, ShelvesCompanion(nameCipher: Value(await _codec.encode(name))));

  @override
  Future<void> setAccent(String id, String accent) =>
      _write(id, ShelvesCompanion(accent: Value(accent)));

  @override
  Future<void> setSymbol(String id, String symbol) =>
      _write(id, ShelvesCompanion(symbol: Value(symbol)));

  @override
  Future<void> deleteShelf(String id) =>
      (_database.delete(_database.shelves)..where((table) => table.id.equals(id))).go();

  @override
  Stream<List<LocalShelfBook>> watchShelfBooks() => _database
      .select(_database.shelfBooks)
      .watch()
      .map(
        (rows) => rows
            .map((row) => LocalShelfBook(id: row.id, shelfId: row.shelfId, bookId: row.bookId))
            .toList(),
      );

  @override
  Future<void> addBook(String shelfId, String bookId) async {
    // * the pair used to be the primary key. PowerSync needs a single column id
    // * instead, so a repeated add has to be caught here rather than by the
    // * database refusing it
    final existing = _database.select(_database.shelfBooks)
      ..where((table) => table.shelfId.equals(shelfId) & table.bookId.equals(bookId));
    if ((await existing.get()).isNotEmpty) return;
    await _database.upsert(
      _database.shelfBooks,
      ShelfBooksCompanion.insert(
        id: const Uuid().v4(),
        ownerId: unownedRow,
        shelfId: shelfId,
        bookId: bookId,
        updatedAt: encodeTimestamp(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> removeBook(String shelfId, String bookId) => (_database.delete(
    _database.shelfBooks,
  )..where((table) => table.shelfId.equals(shelfId) & table.bookId.equals(bookId))).go();

  // * there is no foreign key to cascade from any more: PowerSync tables are
  // * views over an opaque store, so the link rows have to be removed here or
  // * they outlive what they point at and sync as orphans
  @override
  Future<void> removeAllBooks(String shelfId) => (_database.delete(
    _database.shelfBooks,
  )..where((table) => table.shelfId.equals(shelfId))).go();

  @override
  Future<void> removeBookEverywhere(String bookId) =>
      (_database.delete(_database.shelfBooks)..where((table) => table.bookId.equals(bookId))).go();

  Future<void> _write(String id, ShelvesCompanion changes) {
    final statement = _database.update(_database.shelves)..where((table) => table.id.equals(id));
    return statement.write(
      changes.copyWith(updatedAt: Value(encodeTimestamp(DateTime.now()))),
    );
  }

  Future<List<LocalShelf>> _decodeAll(List<ShelfRow> rows) => Future.wait(rows.map(_decode));

  Future<LocalShelf> _decode(ShelfRow row) async {
    return LocalShelf(
      id: row.id,
      name: await _codec.decode(row.nameCipher),
      accent: row.accent,
      symbol: row.symbol,
      createdAt: decodeTimestamp(row.createdAt),
    );
  }
}
