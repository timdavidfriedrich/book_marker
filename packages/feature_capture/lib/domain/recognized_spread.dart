import 'package:shared/domain/entities/recognized_word.dart';

class const SpreadPage({
  required final String imagePath,
  required final double aspectRatio,
});

class const RecognizedSpread({
  required final List<SpreadPage> pages,
  required final List<RecognizedWord> words,
  required final List<int> detectedPageNumbers,
});
