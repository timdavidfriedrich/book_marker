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
  }

  final BookmarkRepository _bookmarkRepository;
  final BookRepository _bookRepository;
  StreamSubscription<AppResult<List<Bookmark>>>? _bookmarkSubscription;
  StreamSubscription<AppResult<List<Book>>>? _bookSubscription;
  List<Bookmark>? _bookmarks;
  Map<String, Book> _booksById = const {};
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
        _booksById = {for (final book in data) book.id: book};
    }
    _emitState(emit);
  }

  void _emitState(Emitter<LibraryState> emit) {
    if (_error case final AppError error) {
      emit(LibraryFailure(error: error));
      return;
    }
    final bookmarks = _bookmarks;
    if (bookmarks == null) return;
    if (bookmarks.isEmpty) {
      emit(const LibraryEmpty());
      return;
    }
    emit(LibraryLoaded(bookmarks: bookmarks, booksById: _booksById));
  }

  @override
  Future<void> close() async {
    await _bookmarkSubscription?.cancel();
    await _bookSubscription?.cancel();
    return super.close();
  }
}
