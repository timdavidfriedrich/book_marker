import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_library/presentation/book_detail/book_detail_event.dart';
import 'package:feature_library/presentation/book_detail/book_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/bookmark_repository.dart';

@injectable
class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  BookDetailBloc(
    this._bookmarkRepository,
    this._bookRepository,
    @factoryParam this._bookId,
  ) : super(const BookDetailLoading()) {
    on<BookDetailStarted>(_onStarted);
    on<BookDetailBookmarksUpdated>(_onBookmarksUpdated);
    on<BookDetailFilterChanged>(_onFilterChanged);
  }

  final BookmarkRepository _bookmarkRepository;
  final BookRepository _bookRepository;
  final String _bookId;
  StreamSubscription<AppResult<List<Bookmark>>>? _subscription;
  Book? _book;
  List<Bookmark> _marks = const [];
  BookDetailFilter _filter = BookDetailFilter.all;
  AppError? _error;

  Future<void> _onStarted(BookDetailStarted event, Emitter<BookDetailState> emit) async {
    switch (await _bookRepository.getBook(_bookId)) {
      case Failure(:final error):
        _error = error;
        _emitState(emit);
        return;
      case Success(:final data):
        _book = data;
    }
    await _subscription?.cancel();
    _subscription = _bookmarkRepository.watchBookmarks().listen(
      (result) => add(BookDetailBookmarksUpdated(result)),
    );
  }

  void _onBookmarksUpdated(BookDetailBookmarksUpdated event, Emitter<BookDetailState> emit) {
    switch (event.result) {
      case Failure(:final error):
        _error = error;
      case Success(:final data):
        _error = null;
        _marks = data.where((mark) => mark.bookId == _bookId).toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }
    _emitState(emit);
  }

  void _onFilterChanged(BookDetailFilterChanged event, Emitter<BookDetailState> emit) {
    _filter = event.filter;
    _emitState(emit);
  }

  void _emitState(Emitter<BookDetailState> emit) {
    if (_error case final AppError error) {
      emit(BookDetailFailure(error: error));
      return;
    }
    final book = _book;
    if (book == null) return;
    final visible = switch (_filter) {
      BookDetailFilter.all => _marks,
      BookDetailFilter.starred => _marks.where((mark) => mark.isFavorite).toList(),
      BookDetailFilter.withVoice => const <Bookmark>[],
    };
    emit(
      BookDetailLoaded(
        book: book,
        marks: visible,
        totalCount: _marks.length,
        starredCount: _marks.where((mark) => mark.isFavorite).length,
        filter: _filter,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
