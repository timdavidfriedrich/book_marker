import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/bookmark_repository.dart';

@injectable
class SaveBookmarkUseCase {
  SaveBookmarkUseCase(this._bookmarkRepository, this._bookRepository);

  final BookmarkRepository _bookmarkRepository;
  final BookRepository _bookRepository;

  Future<AppResult<()>> call(Bookmark bookmark) async {
    final saveResult = await _bookmarkRepository.saveBookmark(bookmark);
    if (saveResult case Failure(:final error)) return Failure(error);
    return _bookRepository.markBookUsed(bookmark.bookId);
  }
}
