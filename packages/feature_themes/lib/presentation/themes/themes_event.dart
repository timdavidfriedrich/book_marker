import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/quote_theme.dart';

sealed class ThemesEvent {
  const ThemesEvent();
}

class const ThemesStarted() extends ThemesEvent;

class const ThemesThemesUpdated(final AppResult<List<QuoteTheme>> result) extends ThemesEvent;

class const ThemesMembershipUpdated(final AppResult<Map<String, Set<String>>> result)
    extends ThemesEvent;

class const ThemesQuotesUpdated(final AppResult<List<Quote>> result) extends ThemesEvent;

class const ThemesCreateRequested(final String name) extends ThemesEvent;
