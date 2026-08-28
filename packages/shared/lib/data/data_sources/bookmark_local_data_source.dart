import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/database/app_database.dart';

abstract class BookmarkLocalDataSource {
  Stream<List<LocalBookmark>> watchBookmarks();

  Future<LocalBookmark?> readBookmark(String id);

  Future<void> insertBookmark(LocalBookmark bookmark);

  Future<void> setFavorite(String id, {required bool isFavorite});

  Future<void> setNote(String id, String? note);

  Future<void> deleteBookmark(String id);
}

@Injectable(as: BookmarkLocalDataSource)
class const BookmarkLocalDataSourceImpl(
  final AppDatabase _database,
) implements BookmarkLocalDataSource {
  @override
  Stream<List<LocalBookmark>> watchBookmarks() {
    final query = _database.select(_database.bookmarks)
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]);
    return query.watch();
  }

  @override
  Future<LocalBookmark?> readBookmark(String id) {
    final query = _database.select(_database.bookmarks)..where((table) => table.id.equals(id));
    return query.getSingleOrNull();
  }

  @override
  Future<void> insertBookmark(LocalBookmark bookmark) =>
      _database.into(_database.bookmarks).insertOnConflictUpdate(bookmark);

  @override
  Future<void> setFavorite(String id, {required bool isFavorite}) {
    final statement = _database.update(_database.bookmarks)..where((table) => table.id.equals(id));
    return statement.write(BookmarksCompanion(isFavorite: Value(isFavorite)));
  }

  @override
  Future<void> setNote(String id, String? note) {
    final statement = _database.update(_database.bookmarks)..where((table) => table.id.equals(id));
    return statement.write(BookmarksCompanion(note: Value(note)));
  }

  @override
  Future<void> deleteBookmark(String id) =>
      (_database.delete(_database.bookmarks)..where((table) => table.id.equals(id))).go();
}
