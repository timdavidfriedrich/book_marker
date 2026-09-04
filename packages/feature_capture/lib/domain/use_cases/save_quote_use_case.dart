import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/quote_repository.dart';

@injectable
class SaveQuoteUseCase {
  SaveQuoteUseCase(this._quoteRepository, this._bookRepository);

  final QuoteRepository _quoteRepository;
  final BookRepository _bookRepository;

  Future<AppResult<()>> call(Quote quote) async {
    final saveResult = await _quoteRepository.saveQuote(quote);
    if (saveResult case Failure(:final error)) return Failure(error);
    return _bookRepository.markBookUsed(quote.bookId);
  }
}
