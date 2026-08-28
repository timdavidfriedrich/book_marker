import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_library/presentation/shelf_detail/shelf_detail_event.dart';
import 'package:feature_library/presentation/shelf_detail/shelf_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/entities/shelf.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/bookmark_repository.dart';
import 'package:shared/domain/repositories/shelf_repository.dart';

@injectable
class ShelfDetailBloc extends Bloc<ShelfDetailEvent, ShelfDetailState> {
  ShelfDetailBloc(
    this._shelfRepository,
    this._bookRepository,
    this._bookmarkRepository,
    @factoryParam this._shelfId,
  ) : super(const ShelfDetailLoading()) {
    on<ShelfDetailStarted>(_onStarted);
    on<ShelfDetailShelvesUpdated>(_onShelvesUpdated);
    on<ShelfDetailMembershipUpdated>(_onMembershipUpdated);
    on<ShelfDetailBooksUpdated>(_onBooksUpdated);
    on<ShelfDetailBookmarksUpdated>(_onBookmarksUpdated);
    on<ShelfDetailBookToggled>(_onBookToggled);
    on<ShelfDetailRenameRequested>(_onRenameRequested);
    on<ShelfDetailAccentChanged>(_onAccentChanged);
    on<ShelfDetailDeleteRequested>(_onDeleteRequested);
  }

  final ShelfRepository _shelfRepository;
  final BookRepository _bookRepository;
  final BookmarkRepository _bookmarkRepository;
  final String _shelfId;
  StreamSubscription<AppResult<List<Shelf>>>? _shelfSubscription;
  StreamSubscription<AppResult<Map<String, Set<String>>>>? _membershipSubscription;
  StreamSubscription<AppResult<List<Book>>>? _bookSubscription;
  StreamSubscription<AppResult<List<Bookmark>>>? _bookmarkSubscription;
  Shelf? _shelf;
  Set<String> _memberIds = const {};
  List<Book> _books = const [];
  List<Bookmark> _bookmarks = const [];
  AppError? _error;

  Future<void> _onStarted(ShelfDetailStarted event, Emitter<ShelfDetailState> emit) async {
    await _shelfSubscription?.cancel();
    await _membershipSubscription?.cancel();
    await _bookSubscription?.cancel();
    await _bookmarkSubscription?.cancel();
    _shelfSubscription = _shelfRepository.watchShelves().listen(
      (result) => add(ShelfDetailShelvesUpdated(result)),
    );
    _membershipSubscription = _shelfRepository.watchShelfMembership().listen(
      (result) => add(ShelfDetailMembershipUpdated(result)),
    );
    _bookSubscription = _bookRepository.watchBooks().listen(
      (result) => add(ShelfDetailBooksUpdated(result)),
    );
    _bookmarkSubscription = _bookmarkRepository.watchBookmarks().listen(
      (result) => add(ShelfDetailBookmarksUpdated(result)),
    );
  }

  void _onShelvesUpdated(ShelfDetailShelvesUpdated event, Emitter<ShelfDetailState> emit) {
    switch (event.result) {
      case Failure(:final error):
        _error = error;
      case Success(:final data):
        _error = null;
        Shelf? found;
        for (final shelf in data) {
          if (shelf.id == _shelfId) {
            found = shelf;
            break;
          }
        }
        _shelf = found;
    }
    _emitState(emit);
  }

  void _onMembershipUpdated(ShelfDetailMembershipUpdated event, Emitter<ShelfDetailState> emit) {
    if (event.result case Success(:final data)) {
      _memberIds = data[_shelfId] ?? const {};
      _emitState(emit);
    }
  }

  void _onBooksUpdated(ShelfDetailBooksUpdated event, Emitter<ShelfDetailState> emit) {
    if (event.result case Success(:final data)) {
      _books = data;
      _emitState(emit);
    }
  }

  void _onBookmarksUpdated(ShelfDetailBookmarksUpdated event, Emitter<ShelfDetailState> emit) {
    if (event.result case Success(:final data)) {
      _bookmarks = data;
      _emitState(emit);
    }
  }

  Future<void> _onBookToggled(
    ShelfDetailBookToggled event,
    Emitter<ShelfDetailState> emit,
  ) async {
    if (_memberIds.contains(event.bookId)) {
      await _shelfRepository.removeBookFromShelf(shelfId: _shelfId, bookId: event.bookId);
    } else {
      await _shelfRepository.addBookToShelf(shelfId: _shelfId, bookId: event.bookId);
    }
  }

  Future<void> _onRenameRequested(
    ShelfDetailRenameRequested event,
    Emitter<ShelfDetailState> emit,
  ) async {
    final name = event.name.trim();
    if (name.isEmpty) return;
    await _shelfRepository.renameShelf(_shelfId, name);
  }

  Future<void> _onAccentChanged(
    ShelfDetailAccentChanged event,
    Emitter<ShelfDetailState> emit,
  ) async {
    await _shelfRepository.setShelfAccent(_shelfId, event.accent);
  }

  Future<void> _onDeleteRequested(
    ShelfDetailDeleteRequested event,
    Emitter<ShelfDetailState> emit,
  ) async {
    if (await _shelfRepository.deleteShelf(_shelfId) case Success()) {
      emit(const ShelfDetailDeleted());
    }
  }

  void _emitState(Emitter<ShelfDetailState> emit) {
    if (state is ShelfDetailDeleted) return;
    if (_error case final AppError error) {
      emit(ShelfDetailFailure(error: error));
      return;
    }
    final shelf = _shelf;
    if (shelf == null) return;
    final markCountByBook = <String, int>{};
    for (final mark in _bookmarks) {
      markCountByBook.update(mark.bookId, (value) => value + 1, ifAbsent: () => 1);
    }
    final allItems = _books
        .map((book) => ShelfBookItem(book: book, markCount: markCountByBook[book.id] ?? 0))
        .toList();
    final memberItems = allItems.where((item) => _memberIds.contains(item.book.id)).toList();
    emit(
      ShelfDetailLoaded(
        shelf: shelf,
        books: memberItems,
        allBooks: allItems,
        memberIds: _memberIds,
        bookCount: memberItems.length,
        markCount: memberItems.fold(0, (total, item) => total + item.markCount),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _shelfSubscription?.cancel();
    await _membershipSubscription?.cancel();
    await _bookSubscription?.cancel();
    await _bookmarkSubscription?.cancel();
    return super.close();
  }
}
