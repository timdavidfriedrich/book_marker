import 'package:core/error/app_error.dart';
import 'package:feature_capture/domain/recognized_page.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote_theme.dart';

sealed class MarkingState {
  const MarkingState();
}

class const MarkingProcessing() extends MarkingState;

class const MarkingReady({
  required final RecognizedPage page,
  required final String imagePath,
  required final String bookId,
  required final List<Book> books,
  required final String bookTitle,
  required final String? bookThumbnailUrl,
  required final List<String> bookAuthors,
  required final Set<int> selectedWordIndexes,
  required final String? quoteOverride,
  required final int? pageNumber,
  required final String? note,
  required final String? voiceNotePath,
  required final int? voiceNoteDurationMs,
  required final List<QuoteTheme> availableThemes,
  required final Set<String> selectedThemeIds,
  required final bool isFavorite,
  required final bool isSaving,
  required final AppError? saveError,
}) extends MarkingState;

class const MarkingFailure({
  required final AppError error,
}) extends MarkingState;

class const MarkingSaved() extends MarkingState;
