import 'package:core/error/app_error.dart';
import 'package:feature_capture/domain/recognized_page.dart';
import 'package:shared/domain/entities/mark_theme.dart';

sealed class MarkingState {
  const MarkingState();
}

class const MarkingProcessing() extends MarkingState;

class const MarkingReady({
  required final RecognizedPage page,
  required final String imagePath,
  required final String bookTitle,
  required final List<String> bookAuthors,
  required final Set<int> selectedWordIndexes,
  required final String? quoteOverride,
  required final int? pageNumber,
  required final String? note,
  required final String? voicePath,
  required final int? voiceDurationMs,
  required final List<MarkTheme> availableThemes,
  required final Set<String> selectedThemeIds,
  required final bool isStarred,
  required final bool isSaving,
  required final AppError? saveError,
}) extends MarkingState;

class const MarkingFailure({
  required final AppError error,
}) extends MarkingState;

class const MarkingSaved() extends MarkingState;
