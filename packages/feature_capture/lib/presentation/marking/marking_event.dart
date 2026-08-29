import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/mark_theme.dart';

sealed class MarkingEvent {
  const MarkingEvent();
}

class const MarkingStarted() extends MarkingEvent;

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

class const MarkingPageNumberChanged(
  final int? pageNumber,
) extends MarkingEvent;

class const MarkingNoteChanged(
  final String? note,
) extends MarkingEvent;

class const MarkingQuoteEdited(
  final String quote,
) extends MarkingEvent;

class const MarkingVoiceRecorded(
  final String path,
  final int durationMs,
) extends MarkingEvent;

class const MarkingVoiceCleared() extends MarkingEvent;

class const MarkingThemesUpdated(
  final AppResult<List<MarkTheme>> result,
) extends MarkingEvent;

class const MarkingThemeToggled(
  final String themeId,
) extends MarkingEvent;

class const MarkingThemeCreateRequested(
  final String name,
) extends MarkingEvent;

class const MarkingStarToggled() extends MarkingEvent;

class const MarkingSaveRequested() extends MarkingEvent;
