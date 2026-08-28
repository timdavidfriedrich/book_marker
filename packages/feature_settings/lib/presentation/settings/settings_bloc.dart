import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:feature_settings/presentation/settings/settings_event.dart';
import 'package:feature_settings/presentation/settings/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/entities/mark_theme.dart';
import 'package:shared/domain/entities/user_settings.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/bookmark_repository.dart';
import 'package:shared/domain/repositories/settings_repository.dart';
import 'package:shared/domain/repositories/theme_repository.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(
    this._settingsRepository,
    this._bookRepository,
    this._bookmarkRepository,
    this._themeRepository,
  ) : super(const SettingsLoading()) {
    on<SettingsStarted>(_onStarted);
    on<SettingsSettingsUpdated>(_onSettingsUpdated);
    on<SettingsBooksUpdated>(_onBooksUpdated);
    on<SettingsBookmarksUpdated>(_onBookmarksUpdated);
    on<SettingsThemesUpdated>(_onThemesUpdated);
    on<SettingsNameChanged>(_onNameChanged);
    on<SettingsLocaleChanged>(_onLocaleChanged);
  }

  final SettingsRepository _settingsRepository;
  final BookRepository _bookRepository;
  final BookmarkRepository _bookmarkRepository;
  final ThemeRepository _themeRepository;
  StreamSubscription<AppResult<UserSettings>>? _settingsSubscription;
  StreamSubscription<AppResult<List<Book>>>? _bookSubscription;
  StreamSubscription<AppResult<List<Bookmark>>>? _bookmarkSubscription;
  StreamSubscription<AppResult<List<MarkTheme>>>? _themeSubscription;
  UserSettings _settings = const UserSettings(
    displayName: null,
    localePreference: LocalePreference.system,
  );
  int _bookCount = 0;
  int _markCount = 0;
  int _themeCount = 0;

  Future<void> _onStarted(SettingsStarted event, Emitter<SettingsState> emit) async {
    await _settingsSubscription?.cancel();
    await _bookSubscription?.cancel();
    await _bookmarkSubscription?.cancel();
    await _themeSubscription?.cancel();
    _settingsSubscription = _settingsRepository.watchSettings().listen(
      (result) => add(SettingsSettingsUpdated(result)),
    );
    _bookSubscription = _bookRepository.watchBooks().listen(
      (result) => add(SettingsBooksUpdated(result)),
    );
    _bookmarkSubscription = _bookmarkRepository.watchBookmarks().listen(
      (result) => add(SettingsBookmarksUpdated(result)),
    );
    _themeSubscription = _themeRepository.watchThemes().listen(
      (result) => add(SettingsThemesUpdated(result)),
    );
  }

  void _onSettingsUpdated(SettingsSettingsUpdated event, Emitter<SettingsState> emit) {
    if (event.result case Success(:final data)) {
      _settings = data;
      _emitState(emit);
    }
  }

  void _onBooksUpdated(SettingsBooksUpdated event, Emitter<SettingsState> emit) {
    if (event.result case Success(:final data)) {
      _bookCount = data.length;
      _emitState(emit);
    }
  }

  void _onBookmarksUpdated(SettingsBookmarksUpdated event, Emitter<SettingsState> emit) {
    if (event.result case Success(:final data)) {
      _markCount = data.length;
      _emitState(emit);
    }
  }

  void _onThemesUpdated(SettingsThemesUpdated event, Emitter<SettingsState> emit) {
    if (event.result case Success(:final data)) {
      _themeCount = data.length;
      _emitState(emit);
    }
  }

  Future<void> _onNameChanged(SettingsNameChanged event, Emitter<SettingsState> emit) async {
    final trimmed = event.name?.trim();
    await _settingsRepository.setDisplayName((trimmed == null || trimmed.isEmpty) ? null : trimmed);
  }

  Future<void> _onLocaleChanged(SettingsLocaleChanged event, Emitter<SettingsState> emit) async {
    await _settingsRepository.setLocalePreference(event.preference);
  }

  void _emitState(Emitter<SettingsState> emit) {
    emit(
      SettingsLoaded(
        displayName: _settings.displayName,
        localePreference: _settings.localePreference,
        bookCount: _bookCount,
        markCount: _markCount,
        themeCount: _themeCount,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _settingsSubscription?.cancel();
    await _bookSubscription?.cancel();
    await _bookmarkSubscription?.cancel();
    await _themeSubscription?.cancel();
    return super.close();
  }
}
