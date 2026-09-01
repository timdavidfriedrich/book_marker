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
    on<LibraryQuoteFilterChanged>(_onQuoteFilterChanged);
    on<LibraryQueryChanged>(_onQueryChanged);
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
  LibraryQuoteFilter _quoteFilter = LibraryQuoteFilter.all;
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
    unawaited(_bookRepository.cacheBookCovers());
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

  void _onQuoteFilterChanged(LibraryQuoteFilterChanged event, Emitter<LibraryState> emit) {
    _quoteFilter = event.filter;
    _emitState(emit);
  }

  void _onQueryChanged(LibraryQueryChanged event, Emitter<LibraryState> emit) {
    _query = event.query;
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

    final query = _query.trim().toLowerCase();
    final booksById = {for (final book in books) book.id: book};

    final quotesByBook = <String, List<Quote>>{};
    for (final quote in quotes) {
      quotesByBook.putIfAbsent(quote.bookId, () => []).add(quote);
    }

    final summaries = <LibraryBookSummary>[];
    for (final book in books) {
      final bookQuotes = quotesByBook[book.id] ?? const <Quote>[];
      final sorted = [...bookQuotes]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      summaries.add(
        LibraryBookSummary(
          book: book,
          quoteCount: bookQuotes.length,
          favoriteCount: bookQuotes.where((quote) => quote.isFavorite).length,
          featuredQuote: sorted.isEmpty ? null : sorted.first,
        ),
      );
    }
    summaries.sort((a, b) => b.quoteCount.compareTo(a.quoteCount));

    final readingCount = summaries.where((it) => it.book.status == BookStatus.reading).length;
    final pausedCount = summaries.where((it) => it.book.status == BookStatus.paused).length;
    final finishedCount = summaries.where((it) => it.book.status == BookStatus.finished).length;

    final visibleSummaries = summaries
        .where(
          (summary) => switch (_filter) {
            LibraryFilter.all => true,
            LibraryFilter.reading => summary.book.status == BookStatus.reading,
            LibraryFilter.paused => summary.book.status == BookStatus.paused,
            LibraryFilter.finished => summary.book.status == BookStatus.finished,
          },
        )
        .where((summary) => query.isEmpty || _matchesBook(summary.book, query))
        .toList();

    final results = <LibraryQuoteResult>[];
    for (final quote in quotes) {
      final book = booksById[quote.bookId];
      if (book == null) continue;
      if (_quoteFilter == LibraryQuoteFilter.favorites && !quote.isFavorite) continue;
      if (query.isNotEmpty && !_matchesQuote(quote, book, query)) continue;
      results.add(LibraryQuoteResult(quote: quote, book: book));
    }
    // * favourites lead the quote list, the rest follow newest first
    results.sort((a, b) {
      if (a.quote.isFavorite != b.quote.isFavorite) return a.quote.isFavorite ? -1 : 1;
      return b.quote.createdAt.compareTo(a.quote.createdAt);
    });

    final shelfSummaries = <LibraryShelfSummary>[];
    for (final shelf in _shelves) {
      if (query.isNotEmpty && !shelf.name.toLowerCase().contains(query)) continue;
      final bookIds = _shelfMembership[shelf.id] ?? const <String>{};
      final shelfBooks = bookIds.map((id) => booksById[id]).whereType<Book>().toList();
      shelfSummaries.add(
        LibraryShelfSummary(
          shelf: shelf,
          bookCount: bookIds.length,
          quoteCount: quotes.where((quote) => bookIds.contains(quote.bookId)).length,
          previewBooks: shelfBooks.take(_shelfPreviewLimit).toList(),
        ),
      );
    }

    emit(
      LibraryLoaded(
        books: visibleSummaries,
        quotes: results,
        shelves: shelfSummaries,
        totalBooks: books.length,
        totalQuotes: quotes.length,
        totalFavorites: quotes.where((quote) => quote.isFavorite).length,
        readingCount: readingCount,
        pausedCount: pausedCount,
        finishedCount: finishedCount,
        view: _view,
        filter: _filter,
        quoteFilter: _quoteFilter,
        query: _query,
      ),
    );
  }

  bool _matchesBook(Book book, String query) {
    return "${book.title} ${book.authors.join(" ")}".toLowerCase().contains(query);
  }

  bool _matchesQuote(Quote quote, Book book, String query) {
    return "${quote.quote} ${book.title}".toLowerCase().contains(query);
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
