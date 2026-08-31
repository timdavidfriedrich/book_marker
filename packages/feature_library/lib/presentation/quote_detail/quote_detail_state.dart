import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote.dart';

sealed class QuoteDetailState {
  const QuoteDetailState();
}

class const QuoteDetailLoading() extends QuoteDetailState;

class const QuoteDetailLoaded({
  required final Quote quote,
  required final Book? book,
}) extends QuoteDetailState;

class const QuoteDetailFailure({
  required final AppError error,
}) extends QuoteDetailState;

class const QuoteDetailDeleted() extends QuoteDetailState;
