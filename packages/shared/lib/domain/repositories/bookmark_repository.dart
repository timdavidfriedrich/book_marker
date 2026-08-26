import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/bookmark.dart';

abstract class BookmarkRepository {
  Stream<AppResult<List<Bookmark>>> watchBookmarks();

  Future<AppResult<Bookmark>> getBookmark(String id);

  Future<AppResult<()>> saveBookmark(Bookmark bookmark);

  Future<AppResult<()>> setFavorite(String id, {required bool isFavorite});
}
