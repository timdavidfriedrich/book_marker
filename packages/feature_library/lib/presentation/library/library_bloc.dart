import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_library/presentation/library/library_event.dart';
import 'package:feature_library/presentation/library/library_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart' show Book, BookStatus;
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/entities/shelf.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/bookmark_repository.dart';
import 'package:shared/domain/repositories/shelf_repository.dart';

const _shelfPreviewLimit = 3;

@injectable
class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc(this._bookmarkRepository, this._bookRepository, this._shelfRepository)
    : super(const LibraryLoading()) {
    on<LibraryStarted>(_onStarted);
    on<LibraryBookmarksUpdated>(_onBookmarksUpdated);
    on<LibraryBooksUpdated>(_onBooksUpdated);
    on<LibraryViewChanged>(_onViewChanged);
    on<LibraryFilterChanged>(_onFilterChanged);
    on<LibraryQueryChanged>(_onQueryChanged);
    on<LibrarySearchScopeChanged>(_onSearchScopeChanged);
    on<LibraryShelvesUpdated>(_onShelvesUpdated);
    on<LibraryShelfMembershipUpdated>(_onShelfMembershipUpdated);
    on<LibraryShelfCreateRequested>(_onShelfCreateRequested);
  }

  final BookmarkRepository _bookmarkRepository;
  final BookRepository _bookRepository;
  final ShelfRepository _shelfRepository;
  StreamSubscription<AppResult<List<Bookmark>>>? _bookmarkSubscription;
  StreamSubscription<AppResult<List<Book>>>? _bookSubscription;
  StreamSubscription<AppResult<List<Shelf>>>? _shelfSubscription;
  StreamSubscription<AppResult<Map<String, Set<String>>>>? _shelfMembershipSubscription;
  List<Bookmark>? _bookmarks;
  List<Book>? _books;
  List<Shelf> _shelves = const [];
  Map<String, Set<String>> _shelfMembership = const {};
  LibraryView _view = LibraryView.books;
  LibraryFilter _filter = LibraryFilter.all;
  LibrarySearchScope _scope = LibrarySearchScope.allBooks;
  String _query = "";
  AppError? _error;

  Future<void> _onStarted(LibraryStarted event, Emitter<LibraryState> emit) async {
    await _bookmarkSubscription?.cancel();
    await _bookSubscription?.cancel();
    await _shelfSubscription?.cancel();
    await _shelfMembershipSubscription?.cancel();
    _bookmarkSubscription = _bookmarkRepository.watchBookmarks().listen(
      (result) => add(LibraryBookmarksUpdated(result)),
    );
    _bookSubscription = _bookRepository.watchBooks().listen(
      (result) => add(LibraryBooksUpdated(result)),
    );
    _shelfSubscription = _shelfRepository.watchShelves().listen(
      (result) => add(LibraryShelvesUpdated(result)),
    );
    _shelfMembershipSubscription = _shelfRepository.watchShelfMembership().listen(
      (result) => add(LibraryShelfMembershipUpdated(result)),
    );
  }

  void _onShelvesUpdated(LibraryShelvesUpdated event, Emitter<LibraryState> emit) {
    if (event.result case Success(:final data)) {
      _shelves = data;
      _emitState(emit);
    }
  }

  void _onShelfMembershipUpdated(LibraryShelfMembershipUpdated event, Emitter<LibraryState> emit) {
    if (event.result case Success(:final data)) {
      _shelfMembership = data;
      _emitState(emit);
    }
  }

  Future<void> _onShelfCreateRequested(
    LibraryShelfCreateRequested event,
    Emitter<LibraryState> emit,
  ) async {
    final name = event.name.trim();
    if (name.isEmpty) return;
    await _shelfRepository.createShelf(name);
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

    final readingCount = summaries.where((it) => it.book.status == BookStatus.reading).length;
    final finishedCount = summaries.where((it) => it.book.status == BookStatus.finished).length;
    final visibleSummaries = switch (_filter) {
      LibraryFilter.all => summaries,
      LibraryFilter.reading =>
        summaries.where((it) => it.book.status == BookStatus.reading).toList(),
      LibraryFilter.finished =>
        summaries.where((it) => it.book.status == BookStatus.finished).toList(),
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

    final shelfSummaries = _shelves.map((shelf) {
      final bookIds = _shelfMembership[shelf.id] ?? const <String>{};
      final shelfBooks = bookIds.map((id) => booksById[id]).whereType<Book>().toList();
      final markCount = bookmarks.where((mark) => bookIds.contains(mark.bookId)).length;
      return LibraryShelfSummary(
        shelf: shelf,
        bookCount: bookIds.length,
        markCount: markCount,
        previewBooks: shelfBooks.take(_shelfPreviewLimit).toList(),
      );
    }).toList();

    emit(
      LibraryLoaded(
        books: visibleSummaries,
        totalBooks: books.length,
        totalMarks: bookmarks.length,
        readingCount: readingCount,
        finishedCount: finishedCount,
        view: _view,
        filter: _filter,
        query: _query,
        searchScope: _scope,
        results: results,
        shelves: shelfSummaries,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _bookmarkSubscription?.cancel();
    await _bookSubscription?.cancel();
    await _shelfSubscription?.cancel();
    await _shelfMembershipSubscription?.cancel();
    return super.close();
  }
}
