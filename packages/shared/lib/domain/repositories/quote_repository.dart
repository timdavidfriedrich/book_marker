import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/quote.dart';

abstract class QuoteRepository {
  Stream<AppResult<List<Quote>>> watchQuotes();

  Future<AppResult<Quote>> getQuote(String id);

  Future<AppResult<()>> saveQuote(Quote quote);

  Future<AppResult<()>> setFavorite(String id, {required bool isFavorite});

  Future<AppResult<()>> setNote(String id, String? note);

  Future<AppResult<()>> deleteQuote(String id);
}
