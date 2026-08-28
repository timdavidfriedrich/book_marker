import 'package:core/error/app_result.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_event.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/bookmark_repository.dart';

@injectable
class BookmarkDetailBloc extends Bloc<BookmarkDetailEvent, BookmarkDetailState> {
  BookmarkDetailBloc(
    this._bookmarkRepository,
    this._bookRepository,
    @factoryParam this._bookmarkId,
  ) : super(const BookmarkDetailLoading()) {
    on<BookmarkDetailStarted>(_onStarted);
    on<BookmarkDetailFavoriteToggled>(_onFavoriteToggled);
    on<BookmarkDetailNoteChanged>(_onNoteChanged);
    on<BookmarkDetailDeleteRequested>(_onDeleteRequested);
  }

  final BookmarkRepository _bookmarkRepository;
  final BookRepository _bookRepository;
  final String _bookmarkId;

  Future<void> _onStarted(BookmarkDetailStarted event, Emitter<BookmarkDetailState> emit) async {
    switch (await _bookmarkRepository.getBookmark(_bookmarkId)) {
      case Failure(:final error):
        emit(BookmarkDetailFailure(error: error));
      case Success(:final data):
        emit(BookmarkDetailLoaded(bookmark: data, book: await _resolveBook(data.bookId)));
    }
  }

  Future<void> _onFavoriteToggled(
    BookmarkDetailFavoriteToggled event,
    Emitter<BookmarkDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! BookmarkDetailLoaded) return;
    final nextValue = !currentState.bookmark.isFavorite;
    if (await _bookmarkRepository.setFavorite(currentState.bookmark.id, isFavorite: nextValue)
        case Success()) {
      emit(
        BookmarkDetailLoaded(
          bookmark: currentState.bookmark.copyWith(isFavorite: nextValue),
          book: currentState.book,
        ),
      );
    }
  }

  Future<void> _onNoteChanged(
    BookmarkDetailNoteChanged event,
    Emitter<BookmarkDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! BookmarkDetailLoaded) return;
    final trimmed = event.note?.trim();
    final nextNote = (trimmed == null || trimmed.isEmpty) ? null : trimmed;
    if (await _bookmarkRepository.setNote(currentState.bookmark.id, nextNote) case Success()) {
      emit(
        BookmarkDetailLoaded(
          bookmark: currentState.bookmark.copyWith(note: nextNote),
          book: currentState.book,
        ),
      );
    }
  }

  Future<void> _onDeleteRequested(
    BookmarkDetailDeleteRequested event,
    Emitter<BookmarkDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! BookmarkDetailLoaded) return;
    if (await _bookmarkRepository.deleteBookmark(currentState.bookmark.id) case Success()) {
      emit(const BookmarkDetailDeleted());
    }
  }

  Future<Book?> _resolveBook(String bookId) async {
    return switch (await _bookRepository.getBook(bookId)) {
      Success(:final data) => data,
      Failure() => null,
    };
  }
}
