import 'package:dart_mappable/dart_mappable.dart';

part 'recognized_word.mapper.dart';

@MappableClass()
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
}) with RecognizedWordMappable;
