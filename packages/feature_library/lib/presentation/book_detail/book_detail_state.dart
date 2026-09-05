import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote.dart';

enum BookDetailFilter { all, favorites, withVoiceNote }

sealed class BookDetailState {
  const BookDetailState();
}

class const BookDetailLoading() extends BookDetailState;

class const BookDetailLoaded({
  required final Book book,
  required final List<Quote> quotes,
  required final int totalCount,
  required final int favoriteCount,
  required final int voiceNoteCount,
  required final BookDetailFilter filter,
}) extends BookDetailState;

class const BookDetailFailure({
  required final AppError error,
}) extends BookDetailState;

class const BookDetailDeleted() extends BookDetailState;
