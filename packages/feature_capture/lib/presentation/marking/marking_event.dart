import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote_theme.dart';

sealed class MarkingEvent {
  const MarkingEvent();
}

class const MarkingStarted() extends MarkingEvent;

class const MarkingBooksUpdated(
  final AppResult<List<Book>> result,
) extends MarkingEvent;

class const MarkingBookChanged(
  final String bookId,
) extends MarkingEvent;

class const MarkingWordsSelected(
  final Set<int> wordIndexes,
) extends MarkingEvent;

class const MarkingWordCorrected(
  final int wordIndex,
  final String text,
) extends MarkingEvent;

class const MarkingWordsMerged(
  final int wordIndex,
) extends MarkingEvent;

class const MarkingPageNumbersChanged(
  final List<int> pageNumbers,
) extends MarkingEvent;

class const MarkingNoteChanged(
  final String? note,
) extends MarkingEvent;

class const MarkingQuoteEdited(
  final String quote,
) extends MarkingEvent;

class const MarkingVoiceNoteRecorded(
  final String path,
  final int durationMs,
) extends MarkingEvent;

class const MarkingVoiceNoteCleared() extends MarkingEvent;

class const MarkingThemesUpdated(
  final AppResult<List<QuoteTheme>> result,
) extends MarkingEvent;

class const MarkingThemeMembershipUpdated(
  final AppResult<Map<String, Set<String>>> result,
) extends MarkingEvent;

class const MarkingThemeToggled(
  final String themeId,
) extends MarkingEvent;

class const MarkingThemeCreateRequested(
  final String name,
) extends MarkingEvent;

class const MarkingFavoriteToggled() extends MarkingEvent;

class const MarkingSaveRequested() extends MarkingEvent;
