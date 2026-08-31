import 'package:core/error/app_result.dart';
import 'package:feature_library/presentation/book_detail/book_detail_state.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote.dart';

sealed class BookDetailEvent {
  const BookDetailEvent();
}

class const BookDetailStarted() extends BookDetailEvent;

class const BookDetailQuotesUpdated(final AppResult<List<Quote>> result) extends BookDetailEvent;

class const BookDetailFilterChanged(final BookDetailFilter filter) extends BookDetailEvent;

class const BookDetailStatusChanged(final BookStatus status) extends BookDetailEvent;

class const BookDetailDeleteRequested() extends BookDetailEvent;
