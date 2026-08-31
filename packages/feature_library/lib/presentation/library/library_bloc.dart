import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_library/presentation/library/library_event.dart';
import 'package:feature_library/presentation/library/library_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart' show Book, BookStatus;
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/shelf.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/quote_repository.dart';
import 'package:shared/domain/repositories/shelf_repository.dart';

const _shelfPreviewLimit = 3;

@injectable
class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc(this._quoteRepository, this._bookRepository, this._shelfRepository)
    : super(const LibraryLoading()) {
    on<LibraryStarted>(_onStarted);
    on<LibraryQuotesUpdated>(_onQuotesUpdated);
    on<LibraryBooksUpdated>(_onBooksUpdated);
    on<LibraryViewChanged>(_onViewChanged);
    on<LibraryFilterChanged>(_onFilterChanged);
    on<LibraryQueryChanged>(_onQueryChanged);
    on<LibrarySearchScopeChanged>(_onSearchScopeChanged);
    on<LibraryShelvesUpdated>(_onShelvesUpdated);
    on<LibraryShelfMembershipUpdated>(_onShelfMembershipUpdated);
    on<LibraryShelfCreateRequested>(_onShelfCreateRequested);
  }

  final QuoteRepository _quoteRepository;
  final BookRepository _bookRepository;
  final ShelfRepository _shelfRepository;
  StreamSubscription<AppResult<List<Quote>>>? _quoteSubscription;
  StreamSubscription<AppResult<List<Book>>>? _bookSubscription;
  StreamSubscription<AppResult<List<Shelf>>>? _shelfSubscription;
  StreamSubscription<AppResult<Map<String, Set<String>>>>? _shelfMembershipSubscription;
  List<Quote>? _quotes;
  List<Book>? _books;
  List<Shelf> _shelves = const [];
  Map<String, Set<String>> _shelfMembership = const {};
  LibraryView _view = LibraryView.books;
  LibraryFilter _filter = LibraryFilter.all;
  LibrarySearchScope _scope = LibrarySearchScope.allBooks;
  String _query = "";
  AppError? _error;

  Future<void> _onStarted(LibraryStarted event, Emitter<LibraryState> emit) async {
    await _quoteSubscription?.cancel();
    await _bookSubscription?.cancel();
    await _shelfSubscription?.cancel();
    await _shelfMembershipSubscription?.cancel();
    _quoteSubscription = _quoteRepository.watchQuotes().listen(
      (result) => add(LibraryQuotesUpdated(result)),
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

  void _onQuotesUpdated(LibraryQuotesUpdated event, Emitter<LibraryState> emit) {
    switch (event.result) {
      case Failure(:final error):
        _error = error;
      case Success(:final data):
        _error = null;
        _quotes = data;
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
    final quotes = _quotes;
    final books = _books;
    if (quotes == null || books == null) return;

    final quotesByBook = <String, List<Quote>>{};
    for (final quote in quotes) {
      quotesByBook.putIfAbsent(quote.bookId, () => []).add(quote);
    }

    final summaries = <LibraryBookSummary>[];
    for (final book in books) {
      final quotes = quotesByBook[book.id] ?? const [];
      final sorted = [...quotes]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      summaries.add(
        LibraryBookSummary(
          book: book,
          quoteCount: quotes.length,
          favoriteCount: quotes.where((quote) => quote.isFavorite).length,
          featuredQuote: sorted.isEmpty ? null : sorted.first,
        ),
      );
    }
    summaries.sort((a, b) => b.quoteCount.compareTo(a.quoteCount));

    final readingCount = summaries.where((it) => it.book.status == BookStatus.reading).length;
    final pausedCount = summaries.where((it) => it.book.status == BookStatus.paused).length;
    final finishedCount = summaries.where((it) => it.book.status == BookStatus.finished).length;
    final visibleSummaries = switch (_filter) {
      LibraryFilter.all => summaries,
      LibraryFilter.reading =>
        summaries.where((it) => it.book.status == BookStatus.reading).toList(),
      LibraryFilter.paused =>
        summaries.where((it) => it.book.status == BookStatus.paused).toList(),
      LibraryFilter.finished =>
        summaries.where((it) => it.book.status == BookStatus.finished).toList(),
    };

    final booksById = {for (final book in books) book.id: book};
    final query = _query.trim().toLowerCase();
    final results = <LibraryQuoteResult>[];
    if (query.isNotEmpty || _scope != LibrarySearchScope.allBooks) {
      for (final quote in quotes) {
        final book = booksById[quote.bookId];
        if (book == null) continue;
        final matchesScope = switch (_scope) {
          LibrarySearchScope.allBooks => true,
          LibrarySearchScope.favorites => quote.isFavorite,
          LibrarySearchScope.myNotes => false,
        };
        if (!matchesScope) continue;
        final haystack = "${quote.quote} ${book.title}".toLowerCase();
        if (haystack.contains(query)) {
          results.add(LibraryQuoteResult(quote: quote, book: book));
        }
      }
      results.sort((a, b) => b.quote.createdAt.compareTo(a.quote.createdAt));
    }

    final shelfSummaries = _shelves.map((shelf) {
      final bookIds = _shelfMembership[shelf.id] ?? const <String>{};
      final shelfBooks = bookIds.map((id) => booksById[id]).whereType<Book>().toList();
      final quoteCount = quotes.where((quote) => bookIds.contains(quote.bookId)).length;
      return LibraryShelfSummary(
        shelf: shelf,
        bookCount: bookIds.length,
        quoteCount: quoteCount,
        previewBooks: shelfBooks.take(_shelfPreviewLimit).toList(),
      );
    }).toList();

    emit(
      LibraryLoaded(
        books: visibleSummaries,
        totalBooks: books.length,
        totalQuotes: quotes.length,
        readingCount: readingCount,
        pausedCount: pausedCount,
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
    await _quoteSubscription?.cancel();
    await _bookSubscription?.cancel();
    await _shelfSubscription?.cancel();
    await _shelfMembershipSubscription?.cancel();
    return super.close();
  }
}
