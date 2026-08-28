import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_themes/presentation/themes/themes_event.dart';
import 'package:feature_themes/presentation/themes/themes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/entities/mark_theme.dart';
import 'package:shared/domain/repositories/bookmark_repository.dart';
import 'package:shared/domain/repositories/theme_repository.dart';

@injectable
class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {
  ThemesBloc(this._themeRepository, this._bookmarkRepository) : super(const ThemesLoading()) {
    on<ThemesStarted>(_onStarted);
    on<ThemesThemesUpdated>(_onThemesUpdated);
    on<ThemesMembershipUpdated>(_onMembershipUpdated);
    on<ThemesBookmarksUpdated>(_onBookmarksUpdated);
    on<ThemesCreateRequested>(_onCreateRequested);
  }

  final ThemeRepository _themeRepository;
  final BookmarkRepository _bookmarkRepository;
  StreamSubscription<AppResult<List<MarkTheme>>>? _themeSubscription;
  StreamSubscription<AppResult<Map<String, Set<String>>>>? _membershipSubscription;
  StreamSubscription<AppResult<List<Bookmark>>>? _bookmarkSubscription;
  List<MarkTheme>? _themes;
  Map<String, Set<String>> _membership = const {};
  List<Bookmark> _bookmarks = const [];
  AppError? _error;

  Future<void> _onStarted(ThemesStarted event, Emitter<ThemesState> emit) async {
    await _themeSubscription?.cancel();
    await _membershipSubscription?.cancel();
    await _bookmarkSubscription?.cancel();
    _themeSubscription = _themeRepository.watchThemes().listen(
      (result) => add(ThemesThemesUpdated(result)),
    );
    _membershipSubscription = _themeRepository.watchThemeMembership().listen(
      (result) => add(ThemesMembershipUpdated(result)),
    );
    _bookmarkSubscription = _bookmarkRepository.watchBookmarks().listen(
      (result) => add(ThemesBookmarksUpdated(result)),
    );
  }

  void _onThemesUpdated(ThemesThemesUpdated event, Emitter<ThemesState> emit) {
    switch (event.result) {
      case Failure(:final error):
        _error = error;
      case Success(:final data):
        _error = null;
        _themes = data;
    }
    _emitState(emit);
  }

  void _onMembershipUpdated(ThemesMembershipUpdated event, Emitter<ThemesState> emit) {
    if (event.result case Success(:final data)) {
      _membership = data;
      _emitState(emit);
    }
  }

  void _onBookmarksUpdated(ThemesBookmarksUpdated event, Emitter<ThemesState> emit) {
    if (event.result case Success(:final data)) {
      _bookmarks = data;
      _emitState(emit);
    }
  }

  Future<void> _onCreateRequested(ThemesCreateRequested event, Emitter<ThemesState> emit) async {
    final name = event.name.trim();
    if (name.isEmpty) return;
    await _themeRepository.createTheme(name);
  }

  void _emitState(Emitter<ThemesState> emit) {
    if (_error case final AppError error) {
      emit(ThemesFailure(error: error));
      return;
    }
    final themes = _themes;
    if (themes == null) return;
    final bookIdByMark = {for (final mark in _bookmarks) mark.id: mark.bookId};
    final summaries = themes.map((theme) {
      final markIds = _membership[theme.id] ?? const <String>{};
      final bookIds = markIds.map((markId) => bookIdByMark[markId]).whereType<String>().toSet();
      return ThemeSummary(theme: theme, markCount: markIds.length, bookCount: bookIds.length);
    }).toList();
    final totalBooks = _bookmarks.map((mark) => mark.bookId).toSet().length;
    emit(
      ThemesLoaded(themes: summaries, totalMarks: _bookmarks.length, totalBooks: totalBooks),
    );
  }

  @override
  Future<void> close() async {
    await _themeSubscription?.cancel();
    await _membershipSubscription?.cancel();
    await _bookmarkSubscription?.cancel();
    return super.close();
  }
}
