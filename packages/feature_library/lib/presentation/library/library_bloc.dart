import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_library/presentation/library/library_event.dart';
import 'package:feature_library/presentation/library/library_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/bookmark_repository.dart';

@injectable
class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc(this._bookmarkRepository, this._bookRepository) : super(const LibraryLoading()) {
    on<LibraryStarted>(_onStarted);
    on<LibraryBookmarksUpdated>(_onBookmarksUpdated);
    on<LibraryBooksUpdated>(_onBooksUpdated);
    on<LibraryViewChanged>(_onViewChanged);
    on<LibraryFilterChanged>(_onFilterChanged);
    on<LibraryQueryChanged>(_onQueryChanged);
    on<LibrarySearchScopeChanged>(_onSearchScopeChanged);
  }

  final BookmarkRepository _bookmarkRepository;
  final BookRepository _bookRepository;
  StreamSubscription<AppResult<List<Bookmark>>>? _bookmarkSubscription;
  StreamSubscription<AppResult<List<Book>>>? _bookSubscription;
  List<Bookmark>? _bookmarks;
  List<Book>? _books;
  LibraryView _view = LibraryView.books;
  LibraryFilter _filter = LibraryFilter.all;
  LibrarySearchScope _scope = LibrarySearchScope.allBooks;
  String _query = "";
  AppError? _error;

  Future<void> _onStarted(LibraryStarted event, Emitter<LibraryState> emit) async {
    await _bookmarkSubscription?.cancel();
    await _bookSubscription?.cancel();
    _bookmarkSubscription = _bookmarkRepository.watchBookmarks().listen(
      (result) => add(LibraryBookmarksUpdated(result)),
    );
    _bookSubscription = _bookRepository.watchBooks().listen(
      (result) => add(LibraryBooksUpdated(result)),
    );
  }

  void _onBookmarksUpdated(LibraryBookmarksUpdated event, Emitter<LibraryState> emit) {
    switch (event.result) {
      case Failure(:final error):
        _error = error;
      case Success(:final data):
        _error = null;
        _bookmarks = data;
    }
    _emitState(emit);
  }

  void _onBooksUpdated(LibraryBooksUpdated event, Emitter<LibraryState> emit) {
    switch (event.result) {
      case Failure(:final error):
        _error = error;
      case Success(:final data):
        _error = null;
        _books = data;
    }
    _emitState(emit);
  }

  void _onViewChanged(LibraryViewChanged event, Emitter<LibraryState> emit) {
    _view = event.view;
    _emitState(emit);
  }

  void _onFilterChanged(LibraryFilterChanged event, Emitter<LibraryState> emit) {
    _filter = event.filter;
    _emitState(emit);
  }

  void _onQueryChanged(LibraryQueryChanged event, Emitter<LibraryState> emit) {
    _query = event.query;
    _emitState(emit);
  }

  void _onSearchScopeChanged(LibrarySearchScopeChanged event, Emitter<LibraryState> emit) {
    _scope = event.scope;
    _emitState(emit);
  }

  void _emitState(Emitter<LibraryState> emit) {
    if (_error case final AppError error) {
      emit(LibraryFailure(error: error));
      return;
    }
    final bookmarks = _bookmarks;
    final books = _books;
    if (bookmarks == null || books == null) return;

    final marksByBook = <String, List<Bookmark>>{};
    for (final mark in bookmarks) {
      marksByBook.putIfAbsent(mark.bookId, () => []).add(mark);
    }

    final summaries = <LibraryBookSummary>[];
    for (final book in books) {
      final marks = marksByBook[book.id] ?? const [];
      final sorted = [...marks]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      summaries.add(
        LibraryBookSummary(
          book: book,
          markCount: marks.length,
          starredCount: marks.where((mark) => mark.isFavorite).length,
          featuredMark: sorted.isEmpty ? null : sorted.first,
        ),
      );
    }
    summaries.sort((a, b) => b.markCount.compareTo(a.markCount));

    final visibleSummaries = switch (_filter) {
      LibraryFilter.all => summaries,
      LibraryFilter.reading => summaries,
      LibraryFilter.finished => const <LibraryBookSummary>[],
    };

    final booksById = {for (final book in books) book.id: book};
    final query = _query.trim().toLowerCase();
    final results = <LibraryMarkResult>[];
    if (query.isNotEmpty || _scope != LibrarySearchScope.allBooks) {
      for (final mark in bookmarks) {
        final book = booksById[mark.bookId];
        if (book == null) continue;
        final matchesScope = switch (_scope) {
          LibrarySearchScope.allBooks => true,
          LibrarySearchScope.starred => mark.isFavorite,
          LibrarySearchScope.myNotes => false,
        };
        if (!matchesScope) continue;
        final haystack = "${mark.quote} ${book.title}".toLowerCase();
        if (haystack.contains(query)) {
          results.add(LibraryMarkResult(mark: mark, book: book));
        }
      }
      results.sort((a, b) => b.mark.createdAt.compareTo(a.mark.createdAt));
    }

    emit(
      LibraryLoaded(
        books: visibleSummaries,
        totalBooks: books.length,
        totalMarks: bookmarks.length,
        readingCount: books.length,
        finishedCount: 0,
        view: _view,
        filter: _filter,
        query: _query,
        searchScope: _scope,
        results: results,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _bookmarkSubscription?.cancel();
    await _bookSubscription?.cancel();
    return super.close();
  }
}
