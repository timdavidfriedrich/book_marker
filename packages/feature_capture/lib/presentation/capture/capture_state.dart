import 'package:core/error/app_error.dart';
import 'package:feature_capture/domain/capture_span.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/captured_shot.dart';

sealed class CaptureState {
  const CaptureState();
}

class const CaptureLoading() extends CaptureState;

class const CaptureEmpty({
  required final CaptureSpan span,
}) extends CaptureState;

class const CaptureReady({
  required final List<Book> books,
  required final String selectedBookId,
  required final CaptureSpan span,
  required final List<CapturedShot> shots,
}) extends CaptureState;

class const CaptureFailure({
  required final AppError error,
}) extends CaptureState;
