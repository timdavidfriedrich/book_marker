import 'package:shared/domain/entities/captured_shot.dart';
import 'package:shared/domain/entities/quote.dart';

class const MarkingArguments({
  required final List<CapturedShot> shots,
  required final String bookId,
  // * set when an existing quote is re-marked instead of freshly captured
  final Quote? quote,
});
