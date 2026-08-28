import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';

enum BookDetailFilter { all, starred, withVoice }

sealed class BookDetailState {
  const BookDetailState();
}

class const BookDetailLoading() extends BookDetailState;

class const BookDetailLoaded({
  required final Book book,
  required final List<Bookmark> marks,
  required final int totalCount,
  required final int starredCount,
  required final BookDetailFilter filter,
}) extends BookDetailState;

class const BookDetailFailure({
  required final AppError error,
}) extends BookDetailState;

class const BookDetailDeleted() extends BookDetailState;
