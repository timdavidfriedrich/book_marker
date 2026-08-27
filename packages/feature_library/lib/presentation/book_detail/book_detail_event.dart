import 'package:core/error/app_result.dart';
import 'package:feature_library/presentation/book_detail/book_detail_state.dart';
import 'package:shared/domain/entities/bookmark.dart';

sealed class BookDetailEvent {
  const BookDetailEvent();
}

class const BookDetailStarted() extends BookDetailEvent;

class const BookDetailBookmarksUpdated(final AppResult<List<Bookmark>> result) extends BookDetailEvent;

class const BookDetailFilterChanged(final BookDetailFilter filter) extends BookDetailEvent;
