import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_capture/presentation/add_book/add_book_event.dart';
import 'package:feature_capture/presentation/add_book/add_book_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/repositories/book_repository.dart';

const _minCatalogueQueryLength = 3;
const _debounceDuration = Duration(milliseconds: 500);

@injectable
class AddBookBloc extends Bloc<AddBookEvent, AddBookState> {
  AddBookBloc(this._bookRepository)
    : super(
        const AddBookLoaded(
          query: "",
          libraryMatches: [],
          catalogueResults: [],
          isCatalogueLoading: false,
          catalogueError: null,
        ),
      ) {
    on<AddBookStarted>(_onStarted);
    on<AddBookBooksUpdated>(_onBooksUpdated);
    on<AddBookQueryChanged>(_onQueryChanged);
    on<AddBookCatalogueRequested>(_onCatalogueRequested);
    on<AddBookCatalogueSelected>(_onCatalogueSelected);
  }

  final BookRepository _bookRepository;
  StreamSubscription<AppResult<List<Book>>>? _subscription;
  Timer? _debounce;
  List<Book> _libraryBooks = const [];
  List<Book> _catalogue = const [];
  String _query = "";
  String _lastSearched = "";
  bool _isCatalogueLoading = false;

  Future<void> _onStarted(AddBookStarted event, Emitter<AddBookState> emit) async {
    await _subscription?.cancel();
    _subscription = _bookRepository.watchBooks().listen(
      (result) => add(AddBookBooksUpdated(result)),
    );
  }

  void _onBooksUpdated(AddBookBooksUpdated event, Emitter<AddBookState> emit) {
    if (event.result case Success(:final data)) {
      _libraryBooks = data;
      _emitState(emit);
    }
  }

  void _onQueryChanged(AddBookQueryChanged event, Emitter<AddBookState> emit) {
    _query = event.query;
    _debounce?.cancel();
    final trimmed = _query.trim();
    if (trimmed.length < _minCatalogueQueryLength) {
      _catalogue = const [];
      _isCatalogueLoading = false;
      _lastSearched = "";
      _emitState(emit);
      return;
    }
    _emitState(emit);
    _debounce = Timer(_debounceDuration, () => add(const AddBookCatalogueRequested()));
  }

  Future<void> _onCatalogueRequested(
    AddBookCatalogueRequested event,
    Emitter<AddBookState> emit,
  ) async {
    final trimmed = _query.trim();
    if (trimmed.length < _minCatalogueQueryLength) return;
    if (trimmed == _lastSearched) return;
    _lastSearched = trimmed;
    _isCatalogueLoading = true;
    _emitState(emit);
    final result = await _bookRepository.searchBooks(trimmed);
    if (_query.trim() != trimmed) return;
    _isCatalogueLoading = false;
    switch (result) {
      case Success(:final data):
        final ownedIds = _libraryBooks.map((book) => book.id).toSet();
        _catalogue = data.where((book) => !ownedIds.contains(book.id)).toList();
        _emitState(emit, catalogueError: null);
      case Failure(:final error):
        _lastSearched = "";
        _catalogue = const [];
        _emitState(emit, catalogueError: error);
    }
  }

  Future<void> _onCatalogueSelected(
    AddBookCatalogueSelected event,
    Emitter<AddBookState> emit,
  ) async {
    if (await _bookRepository.saveBook(event.book) case Success()) {
      emit(AddBookSaved(bookId: event.book.id));
    }
  }

  void _emitState(Emitter<AddBookState> emit, {AppError? catalogueError}) {
    final trimmed = _query.trim().toLowerCase();
    final matches = trimmed.isEmpty
        ? _libraryBooks
        : _libraryBooks.where((book) {
            final haystack = "${book.title} ${book.authors.join(" ")} ${book.isbn ?? ""}"
                .toLowerCase();
            return haystack.contains(trimmed);
          }).toList();
    emit(
      AddBookLoaded(
        query: _query,
        libraryMatches: matches,
        catalogueResults: _catalogue,
        isCatalogueLoading: _isCatalogueLoading,
        catalogueError: catalogueError,
      ),
    );
  }

  @override
  Future<void> close() async {
    _debounce?.cancel();
    await _subscription?.cancel();
    return super.close();
  }
}
