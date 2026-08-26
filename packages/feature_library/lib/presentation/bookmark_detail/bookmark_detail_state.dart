import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';

sealed class BookmarkDetailState {
  const BookmarkDetailState();
}

class const BookmarkDetailLoading() extends BookmarkDetailState;

class const BookmarkDetailLoaded({
  required final Bookmark bookmark,
  required final Book? book,
}) extends BookmarkDetailState;

class const BookmarkDetailFailure({
  required final AppError error,
}) extends BookmarkDetailState;
