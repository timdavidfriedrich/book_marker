import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';

sealed class CaptureState {
  const CaptureState();
}

class const CaptureLoading() extends CaptureState;

class const CaptureEmpty() extends CaptureState;

class const CaptureReady({
  required final List<Book> books,
  required final String selectedBookId,
}) extends CaptureState;

class const CaptureFailure({
  required final AppError error,
}) extends CaptureState;
