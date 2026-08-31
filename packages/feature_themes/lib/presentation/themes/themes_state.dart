import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/quote_theme.dart';

class const ThemeSummary({
  required final QuoteTheme theme,
  required final int quoteCount,
  required final int bookCount,
});

sealed class ThemesState {
  const ThemesState();
}

class const ThemesLoading() extends ThemesState;

class const ThemesLoaded({
  required final List<ThemeSummary> themes,
  required final int totalQuotes,
  required final int totalBooks,
}) extends ThemesState;

class const ThemesFailure({
  required final AppError error,
}) extends ThemesState;
