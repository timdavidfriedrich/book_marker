import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/quote_page.dart';
import 'package:shared/domain/entities/recognized_word.dart';

part 'quote.mapper.dart';

@MappableClass()
class const Quote({
  required final String id,
  required final String bookId,
  required final List<int> pageNumbers,
  required final String quote,
  required final String? note,
  required final String? voiceNotePath,
  required final int? voiceNoteDurationMs,
  required final List<QuotePage> pages,
  required final bool isFavorite,
  required final DateTime createdAt,
  // * the recognised words let the quote be re-marked without scanning the pages again
  final List<RecognizedWord> words = const [],
  final List<int> markedWordIndexes = const [],
}) with QuoteMappable;
