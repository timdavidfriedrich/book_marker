import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/quote_theme.dart';

enum ThemeDetailFilter { all, favorites }

class const ThemeQuoteItem({
  required final Quote quote,
  required final Book book,
});

sealed class ThemeDetailState {
  const ThemeDetailState();
}

class const ThemeDetailLoading() extends ThemeDetailState;

class const ThemeDetailLoaded({
  required final QuoteTheme theme,
  required final List<ThemeQuoteItem> quotes,
  required final List<ThemeQuoteItem> allQuotes,
  required final Set<String> memberIds,
  required final int totalCount,
  required final int favoriteCount,
  required final ThemeDetailFilter filter,
}) extends ThemeDetailState;

class const ThemeDetailFailure({
  required final AppError error,
}) extends ThemeDetailState;

class const ThemeDetailDeleted() extends ThemeDetailState;
