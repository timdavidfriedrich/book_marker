import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/database/app_database.dart';

abstract class ShelfLocalDataSource {
  Stream<List<LocalShelf>> watchShelves();

  Future<void> upsertShelf(LocalShelf shelf);

  Future<void> renameShelf(String id, String name);

  Future<void> setAccent(String id, String? accent);

  Future<void> deleteShelf(String id);

  Stream<List<LocalShelfBook>> watchShelfBooks();

  Future<void> addBook(String shelfId, String bookId);

  Future<void> removeBook(String shelfId, String bookId);
}

@Injectable(as: ShelfLocalDataSource)
class const ShelfLocalDataSourceImpl(
  final AppDatabase _database,
) implements ShelfLocalDataSource {
  @override
  Stream<List<LocalShelf>> watchShelves() {
    final query = _database.select(_database.shelves)
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]);
    return query.watch();
  }

  @override
  Future<void> upsertShelf(LocalShelf shelf) =>
      _database.into(_database.shelves).insertOnConflictUpdate(shelf);

  @override
  Future<void> renameShelf(String id, String name) {
    final statement = _database.update(_database.shelves)..where((table) => table.id.equals(id));
    return statement.write(ShelvesCompanion(name: Value(name)));
  }

  @override
  Future<void> setAccent(String id, String? accent) {
    final statement = _database.update(_database.shelves)..where((table) => table.id.equals(id));
    return statement.write(ShelvesCompanion(accent: Value(accent)));
  }

  @override
  Future<void> deleteShelf(String id) =>
      (_database.delete(_database.shelves)..where((table) => table.id.equals(id))).go();

  @override
  Stream<List<LocalShelfBook>> watchShelfBooks() => _database.select(_database.shelfBooks).watch();

  @override
  Future<void> addBook(String shelfId, String bookId) => _database
      .into(_database.shelfBooks)
      .insertOnConflictUpdate(LocalShelfBook(shelfId: shelfId, bookId: bookId));

  @override
  Future<void> removeBook(String shelfId, String bookId) => (_database.delete(
    _database.shelfBooks,
  )..where((table) => table.shelfId.equals(shelfId) & table.bookId.equals(bookId))).go();
}
