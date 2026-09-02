import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/quote_theme.dart';

sealed class QuoteDetailEvent {
  const QuoteDetailEvent();
}

class const QuoteDetailStarted() extends QuoteDetailEvent;

class const QuoteDetailFavoriteToggled() extends QuoteDetailEvent;

class const QuoteDetailQuoteChanged(
  final String quote,
) extends QuoteDetailEvent;

class const QuoteDetailMarkingSyncRequested() extends QuoteDetailEvent;

class const QuoteDetailNoteChanged(
  final String? note,
) extends QuoteDetailEvent;

class const QuoteDetailPageNumbersChanged(
  final List<int> pageNumbers,
) extends QuoteDetailEvent;

class const QuoteDetailVoiceNoteRecorded(
  final String path,
  final int durationMs,
) extends QuoteDetailEvent;

class const QuoteDetailVoiceNoteCleared() extends QuoteDetailEvent;

class const QuoteDetailThemesUpdated(
  final AppResult<List<QuoteTheme>> result,
) extends QuoteDetailEvent;

class const QuoteDetailThemeMembershipUpdated(
  final AppResult<Map<String, Set<String>>> result,
) extends QuoteDetailEvent;

class const QuoteDetailThemeToggled(
  final String themeId,
) extends QuoteDetailEvent;

class const QuoteDetailThemeCreateRequested(
  final String name,
) extends QuoteDetailEvent;

class const QuoteDetailDeleteRequested() extends QuoteDetailEvent;
