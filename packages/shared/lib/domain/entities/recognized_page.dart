import 'package:shared/domain/entities/recognized_word.dart';

// * words and lines carry the geometry the marking UI is built on, and the
// * cloud path has none: it returns a transcription and nothing else. `text` is
// * therefore the only field both paths always fill
class const RecognizedPage({
  required final List<RecognizedLine> lines,
  required final List<RecognizedWord> words,
  required final int? detectedPageNumber,
  required final double aspectRatio,
  required final String text,
});

class const RecognizedLine({
  required final String text,
  required final double left,
  required final double top,
  required final double width,
  required final double height,
});
