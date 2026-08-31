import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/quote_theme.dart';

sealed class QuoteDetailState {
  const QuoteDetailState();
}

class const QuoteDetailLoading() extends QuoteDetailState;

class const QuoteDetailLoaded({
  required final Quote quote,
  required final Book? book,
  required final List<QuoteTheme> themes,
  required final Set<String> selectedThemeIds,
}) extends QuoteDetailState;

class const QuoteDetailFailure({
  required final AppError error,
}) extends QuoteDetailState;

class const QuoteDetailDeleted() extends QuoteDetailState;
