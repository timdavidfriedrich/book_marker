import 'package:shared/domain/entities/quote_page.dart';
import 'package:shared/domain/entities/recognized_word.dart';

class const LocalQuote({
  required final String id,
  required final String bookId,
  required final List<int> pageNumbers,
  required final String quote,
  required final String? note,
  required final String? voiceNotePath,
  required final int? voiceNoteDurationMs,
  required final List<QuotePage> pages,
  required final List<RecognizedWord> words,
  required final List<int> markedWordIndexes,
  required final bool isFavorite,
  required final DateTime createdAt,
});
