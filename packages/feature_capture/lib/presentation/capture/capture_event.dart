import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/book.dart';

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
