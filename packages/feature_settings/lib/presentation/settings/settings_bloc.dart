import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:feature_settings/presentation/settings/settings_event.dart';
import 'package:feature_settings/presentation/settings/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/quote_theme.dart';
import 'package:shared/domain/entities/user_settings.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/quote_repository.dart';
import 'package:shared/domain/repositories/settings_repository.dart';
import 'package:shared/domain/repositories/theme_repository.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(
    this._settingsRepository,
    this._bookRepository,
    this._quoteRepository,
    this._themeRepository,
  ) : super(const SettingsLoading()) {
    on<SettingsStarted>(_onStarted);
    on<SettingsSettingsUpdated>(_onSettingsUpdated);
    on<SettingsBooksUpdated>(_onBooksUpdated);
    on<SettingsQuotesUpdated>(_onQuotesUpdated);
    on<SettingsThemesUpdated>(_onThemesUpdated);
    on<SettingsNameChanged>(_onNameChanged);
    on<SettingsLocaleChanged>(_onLocaleChanged);
    on<SettingsThemeChanged>(_onThemeChanged);
    on<SettingsContrastChanged>(_onContrastChanged);
  }

  final SettingsRepository _settingsRepository;
  final BookRepository _bookRepository;
  final QuoteRepository _quoteRepository;
  final ThemeRepository _themeRepository;
  StreamSubscription<AppResult<UserSettings>>? _settingsSubscription;
  StreamSubscription<AppResult<List<Book>>>? _bookSubscription;
  StreamSubscription<AppResult<List<Quote>>>? _quoteSubscription;
  StreamSubscription<AppResult<List<QuoteTheme>>>? _themeSubscription;
  UserSettings _settings = defaultUserSettings;
  int _bookCount = 0;
  int _quoteCount = 0;
  int _themeCount = 0;

  Future<void> _onStarted(SettingsStarted event, Emitter<SettingsState> emit) async {
    await _settingsSubscription?.cancel();
    await _bookSubscription?.cancel();
    await _quoteSubscription?.cancel();
    await _themeSubscription?.cancel();
    _settingsSubscription = _settingsRepository.watchSettings().listen(
      (result) => add(SettingsSettingsUpdated(result)),
    );
    _bookSubscription = _bookRepository.watchBooks().listen(
      (result) => add(SettingsBooksUpdated(result)),
    );
    _quoteSubscription = _quoteRepository.watchQuotes().listen(
      (result) => add(SettingsQuotesUpdated(result)),
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

  void _onQuotesUpdated(SettingsQuotesUpdated event, Emitter<SettingsState> emit) {
    if (event.result case Success(:final data)) {
      _quoteCount = data.length;
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

  Future<void> _onThemeChanged(SettingsThemeChanged event, Emitter<SettingsState> emit) async {
    await _settingsRepository.setThemePreference(event.preference);
  }

  Future<void> _onContrastChanged(
    SettingsContrastChanged event,
    Emitter<SettingsState> emit,
  ) async {
    await _settingsRepository.setContrastPreference(event.preference);
  }

  void _emitState(Emitter<SettingsState> emit) {
    emit(
      SettingsLoaded(
        displayName: _settings.displayName,
        localePreference: _settings.localePreference,
        themePreference: _settings.themePreference,
        contrastPreference: _settings.contrastPreference,
        bookCount: _bookCount,
        quoteCount: _quoteCount,
        themeCount: _themeCount,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _settingsSubscription?.cancel();
    await _bookSubscription?.cancel();
    await _quoteSubscription?.cancel();
    await _themeSubscription?.cancel();
    return super.close();
  }
}
