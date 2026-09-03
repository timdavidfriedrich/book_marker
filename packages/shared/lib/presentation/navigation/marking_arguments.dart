import 'package:shared/domain/entities/captured_shot.dart';
import 'package:shared/domain/entities/quote.dart';

class const MarkingArguments({
  required final List<CapturedShot> shots,
  // * left empty for a fresh capture, where the book is only picked while marking
  final String? bookId,
  // * set when an existing quote is re-marked instead of freshly captured
  final Quote? quote,
});
