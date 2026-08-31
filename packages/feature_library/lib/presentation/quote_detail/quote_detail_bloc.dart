import 'package:core/error/app_result.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_event.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/quote_repository.dart';

@injectable
class QuoteDetailBloc extends Bloc<QuoteDetailEvent, QuoteDetailState> {
  QuoteDetailBloc(
    this._quoteRepository,
    this._bookRepository,
    @factoryParam this._quoteId,
  ) : super(const QuoteDetailLoading()) {
    on<QuoteDetailStarted>(_onStarted);
    on<QuoteDetailFavoriteToggled>(_onFavoriteToggled);
    on<QuoteDetailNoteChanged>(_onNoteChanged);
    on<QuoteDetailDeleteRequested>(_onDeleteRequested);
  }

  final QuoteRepository _quoteRepository;
  final BookRepository _bookRepository;
  final String _quoteId;

  Future<void> _onStarted(QuoteDetailStarted event, Emitter<QuoteDetailState> emit) async {
    switch (await _quoteRepository.getQuote(_quoteId)) {
      case Failure(:final error):
        emit(QuoteDetailFailure(error: error));
      case Success(:final data):
        emit(QuoteDetailLoaded(quote: data, book: await _resolveBook(data.bookId)));
    }
  }

  Future<void> _onFavoriteToggled(
    QuoteDetailFavoriteToggled event,
    Emitter<QuoteDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! QuoteDetailLoaded) return;
    final nextValue = !currentState.quote.isFavorite;
    if (await _quoteRepository.setFavorite(currentState.quote.id, isFavorite: nextValue)
        case Success()) {
      emit(
        QuoteDetailLoaded(
          quote: currentState.quote.copyWith(isFavorite: nextValue),
          book: currentState.book,
        ),
      );
    }
  }

  Future<void> _onNoteChanged(
    QuoteDetailNoteChanged event,
    Emitter<QuoteDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! QuoteDetailLoaded) return;
    final trimmed = event.note?.trim();
    final nextNote = (trimmed == null || trimmed.isEmpty) ? null : trimmed;
    if (await _quoteRepository.setNote(currentState.quote.id, nextNote) case Success()) {
      emit(
        QuoteDetailLoaded(
          quote: currentState.quote.copyWith(note: nextNote),
          book: currentState.book,
        ),
      );
    }
  }

  Future<void> _onDeleteRequested(
    QuoteDetailDeleteRequested event,
    Emitter<QuoteDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! QuoteDetailLoaded) return;
    if (await _quoteRepository.deleteQuote(currentState.quote.id) case Success()) {
      emit(const QuoteDetailDeleted());
    }
  }

  Future<Book?> _resolveBook(String bookId) async {
    return switch (await _bookRepository.getBook(bookId)) {
      Success(:final data) => data,
      Failure() => null,
    };
  }
}
