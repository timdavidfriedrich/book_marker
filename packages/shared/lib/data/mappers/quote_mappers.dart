import 'package:shared/data/database/app_database.dart';
import 'package:shared/domain/entities/quote.dart';

extension LocalQuoteMappers on LocalQuote {
  Quote toQuote() {
    return Quote(
      id: id,
      bookId: bookId,
      pageNumbers: pageNumbers,
      quote: quote,
      note: note,
      voiceNotePath: voiceNotePath,
      voiceNoteDurationMs: voiceNoteDurationMs,
      pages: pages,
      words: words,
      markedWordIndexes: markedWordIndexes,
      isFavorite: isFavorite,
      createdAt: createdAt,
    );
  }
}

extension QuoteMappers on Quote {
  LocalQuote toLocalQuote() {
    return LocalQuote(
      id: id,
      bookId: bookId,
      pageNumbers: pageNumbers,
      quote: quote,
      note: note,
      voiceNotePath: voiceNotePath,
      voiceNoteDurationMs: voiceNoteDurationMs,
      pages: pages,
      words: words,
      markedWordIndexes: markedWordIndexes,
      isFavorite: isFavorite,
      createdAt: createdAt,
    );
  }
}
