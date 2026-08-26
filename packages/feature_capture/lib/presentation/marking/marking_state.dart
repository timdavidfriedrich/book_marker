import 'package:core/error/app_error.dart';
import 'package:feature_capture/domain/recognized_page.dart';

sealed class MarkingState {
  const MarkingState();
}

class const MarkingProcessing() extends MarkingState;

class const MarkingReady({
  required final RecognizedPage page,
  required final String imagePath,
  required final Set<int> selectedIndexes,
  required final int? pageNumber,
  required final bool isSaving,
  required final AppError? saveError,
}) extends MarkingState;

class const MarkingFailure({
  required final AppError error,
}) extends MarkingState;

class const MarkingSaved() extends MarkingState;
