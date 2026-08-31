import 'package:shared/data/database/app_database.dart';
import 'package:shared/domain/entities/quote.dart';

extension LocalQuoteMappers on LocalQuote {
  Quote toQuote() {
    return Quote(
      id: id,
      bookId: bookId,
      pageNumber: pageNumber,
      quote: quote,
      note: note,
      voiceNotePath: voiceNotePath,
      voiceNoteDurationMs: voiceNoteDurationMs,
      photoPath: photoPath,
      imageAspectRatio: imageAspectRatio,
      highlights: highlights,
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
      pageNumber: pageNumber,
      quote: quote,
      note: note,
      voiceNotePath: voiceNotePath,
      voiceNoteDurationMs: voiceNoteDurationMs,
      photoPath: photoPath,
      imageAspectRatio: imageAspectRatio,
      highlights: highlights,
      isFavorite: isFavorite,
      createdAt: createdAt,
    );
  }
}
