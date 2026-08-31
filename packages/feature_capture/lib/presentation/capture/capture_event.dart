import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/capture_span.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/captured_shot.dart';

sealed class CaptureEvent {
  const CaptureEvent();
}

class const CaptureStarted() extends CaptureEvent;

class const CaptureBooksUpdated(
  final AppResult<List<Book>> result,
) extends CaptureEvent;

class const CaptureBookSelected(
  final String bookId,
) extends CaptureEvent;

class const CaptureSpanSelected(
  final CaptureSpan span,
) extends CaptureEvent;

class const CaptureShotTaken(
  final CapturedShot shot,
) extends CaptureEvent;

class const CaptureShotDiscarded(
  final int index,
) extends CaptureEvent;

class const CaptureShotMoved(
  final int fromIndex,
  final int toIndex,
) extends CaptureEvent;
