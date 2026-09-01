import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/database/app_database.dart';

abstract class BookLocalDataSource {
  Stream<List<LocalBook>> watchBooks();

  Future<List<LocalBook>> readBooks();

  Future<LocalBook?> readBook(String id);

  Future<void> upsertBook(LocalBook book);

  Future<void> touchBook(String id, DateTime lastUsedAt);

  Future<void> setStatus(String id, String status);

  Future<void> deleteBook(String id);
}

@Injectable(as: BookLocalDataSource)
class const BookLocalDataSourceImpl(
  final AppDatabase _database,
) implements BookLocalDataSource {
  @override
  Stream<List<LocalBook>> watchBooks() {
    final query = _database.select(_database.books)
      ..orderBy([(table) => OrderingTerm.desc(table.lastUsedAt)]);
    return query.watch();
  }

  @override
  Future<List<LocalBook>> readBooks() => _database.select(_database.books).get();

  @override
  Future<LocalBook?> readBook(String id) {
    final query = _database.select(_database.books)..where((table) => table.id.equals(id));
    return query.getSingleOrNull();
  }

  @override
  Future<void> upsertBook(LocalBook book) =>
      _database.into(_database.books).insertOnConflictUpdate(book);

  @override
  Future<void> touchBook(String id, DateTime lastUsedAt) {
    final statement = _database.update(_database.books)..where((table) => table.id.equals(id));
    return statement.write(BooksCompanion(lastUsedAt: Value(lastUsedAt)));
  }

  @override
  Future<void> setStatus(String id, String status) {
    final statement = _database.update(_database.books)..where((table) => table.id.equals(id));
    return statement.write(BooksCompanion(status: Value(status)));
  }

  @override
  Future<void> deleteBook(String id) =>
      (_database.delete(_database.books)..where((table) => table.id.equals(id))).go();
}
