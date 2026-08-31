class const RecognizedPage({
  required final List<RecognizedLine> lines,
  required final List<RecognizedWord> words,
  required final int? detectedPageNumber,
  required final double aspectRatio,
});

class const RecognizedLine({
  required final String text,
  required final double left,
  required final double top,
  required final double width,
  required final double height,
});

class const RecognizedWord({
  required final String text,
  required final double left,
  required final double top,
  required final double width,
  required final double height,
  required final int lineIndex,
  required final int pageIndex,
  required final double? confidence,
  required final bool isUncertain,
  required final bool joinsWithNext,
  final List<String> suggestions = const [],
});
