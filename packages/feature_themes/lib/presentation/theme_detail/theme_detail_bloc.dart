import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_themes/presentation/theme_detail/theme_detail_event.dart';
import 'package:feature_themes/presentation/theme_detail/theme_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/entities/mark_theme.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/bookmark_repository.dart';
import 'package:shared/domain/repositories/theme_repository.dart';

@injectable
class ThemeDetailBloc extends Bloc<ThemeDetailEvent, ThemeDetailState> {
  ThemeDetailBloc(
    this._themeRepository,
    this._bookmarkRepository,
    this._bookRepository,
    @factoryParam this._themeId,
  ) : super(const ThemeDetailLoading()) {
    on<ThemeDetailStarted>(_onStarted);
    on<ThemeDetailThemesUpdated>(_onThemesUpdated);
    on<ThemeDetailMembershipUpdated>(_onMembershipUpdated);
    on<ThemeDetailBookmarksUpdated>(_onBookmarksUpdated);
    on<ThemeDetailBooksUpdated>(_onBooksUpdated);
    on<ThemeDetailFilterChanged>(_onFilterChanged);
    on<ThemeDetailMarkToggled>(_onMarkToggled);
    on<ThemeDetailRenameRequested>(_onRenameRequested);
    on<ThemeDetailAccentChanged>(_onAccentChanged);
    on<ThemeDetailDeleteRequested>(_onDeleteRequested);
  }

  final ThemeRepository _themeRepository;
  final BookmarkRepository _bookmarkRepository;
  final BookRepository _bookRepository;
  final String _themeId;
  StreamSubscription<AppResult<List<MarkTheme>>>? _themeSubscription;
  StreamSubscription<AppResult<Map<String, Set<String>>>>? _membershipSubscription;
  StreamSubscription<AppResult<List<Bookmark>>>? _bookmarkSubscription;
  StreamSubscription<AppResult<List<Book>>>? _bookSubscription;
  MarkTheme? _theme;
  Set<String> _memberIds = const {};
  List<Bookmark> _bookmarks = const [];
  Map<String, Book> _booksById = const {};
  ThemeDetailFilter _filter = ThemeDetailFilter.all;
  AppError? _error;

  Future<void> _onStarted(ThemeDetailStarted event, Emitter<ThemeDetailState> emit) async {
    await _themeSubscription?.cancel();
    await _membershipSubscription?.cancel();
    await _bookmarkSubscription?.cancel();
    await _bookSubscription?.cancel();
    _themeSubscription = _themeRepository.watchThemes().listen(
      (result) => add(ThemeDetailThemesUpdated(result)),
    );
    _membershipSubscription = _themeRepository.watchThemeMembership().listen(
      (result) => add(ThemeDetailMembershipUpdated(result)),
    );
    _bookmarkSubscription = _bookmarkRepository.watchBookmarks().listen(
      (result) => add(ThemeDetailBookmarksUpdated(result)),
    );
    _bookSubscription = _bookRepository.watchBooks().listen(
      (result) => add(ThemeDetailBooksUpdated(result)),
    );
  }

  void _onThemesUpdated(ThemeDetailThemesUpdated event, Emitter<ThemeDetailState> emit) {
    switch (event.result) {
      case Failure(:final error):
        _error = error;
      case Success(:final data):
        _error = null;
        MarkTheme? found;
        for (final theme in data) {
          if (theme.id == _themeId) {
            found = theme;
            break;
          }
        }
        _theme = found;
    }
    _emitState(emit);
  }

  void _onMembershipUpdated(ThemeDetailMembershipUpdated event, Emitter<ThemeDetailState> emit) {
    if (event.result case Success(:final data)) {
      _memberIds = data[_themeId] ?? const {};
      _emitState(emit);
    }
  }

  void _onBookmarksUpdated(ThemeDetailBookmarksUpdated event, Emitter<ThemeDetailState> emit) {
    if (event.result case Success(:final data)) {
      _bookmarks = data;
      _emitState(emit);
    }
  }

  void _onBooksUpdated(ThemeDetailBooksUpdated event, Emitter<ThemeDetailState> emit) {
    if (event.result case Success(:final data)) {
      _booksById = {for (final book in data) book.id: book};
      _emitState(emit);
    }
  }

  void _onFilterChanged(ThemeDetailFilterChanged event, Emitter<ThemeDetailState> emit) {
    _filter = event.filter;
    _emitState(emit);
  }

  Future<void> _onMarkToggled(
    ThemeDetailMarkToggled event,
    Emitter<ThemeDetailState> emit,
  ) async {
    if (_memberIds.contains(event.bookmarkId)) {
      await _themeRepository.removeMarkFromTheme(themeId: _themeId, bookmarkId: event.bookmarkId);
    } else {
      await _themeRepository.addMarkToTheme(themeId: _themeId, bookmarkId: event.bookmarkId);
    }
  }

  Future<void> _onRenameRequested(
    ThemeDetailRenameRequested event,
    Emitter<ThemeDetailState> emit,
  ) async {
    final name = event.name.trim();
    if (name.isEmpty) return;
    await _themeRepository.renameTheme(_themeId, name);
  }

  Future<void> _onAccentChanged(
    ThemeDetailAccentChanged event,
    Emitter<ThemeDetailState> emit,
  ) async {
    await _themeRepository.setThemeAccent(_themeId, event.accent);
  }

  Future<void> _onDeleteRequested(
    ThemeDetailDeleteRequested event,
    Emitter<ThemeDetailState> emit,
  ) async {
    if (await _themeRepository.deleteTheme(_themeId) case Success()) {
      emit(const ThemeDetailDeleted());
    }
  }

  void _emitState(Emitter<ThemeDetailState> emit) {
    if (state is ThemeDetailDeleted) return;
    if (_error case final AppError error) {
      emit(ThemeDetailFailure(error: error));
      return;
    }
    final theme = _theme;
    if (theme == null) return;
    final allMarks = <ThemeMarkItem>[];
    for (final mark in _bookmarks) {
      final book = _booksById[mark.bookId];
      if (book != null) allMarks.add(ThemeMarkItem(mark: mark, book: book));
    }
    final memberItems = allMarks.where((item) => _memberIds.contains(item.mark.id)).toList();
    final visible = switch (_filter) {
      ThemeDetailFilter.all => memberItems,
      ThemeDetailFilter.starred => memberItems.where((item) => item.mark.isFavorite).toList(),
    };
    emit(
      ThemeDetailLoaded(
        theme: theme,
        marks: visible,
        allMarks: allMarks,
        memberIds: _memberIds,
        totalCount: memberItems.length,
        starredCount: memberItems.where((item) => item.mark.isFavorite).length,
        bookCount: memberItems.map((item) => item.book.id).toSet().length,
        filter: _filter,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _themeSubscription?.cancel();
    await _membershipSubscription?.cancel();
    await _bookmarkSubscription?.cancel();
    await _bookSubscription?.cancel();
    return super.close();
  }
}
