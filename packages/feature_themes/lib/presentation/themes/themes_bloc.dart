import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_themes/presentation/themes/themes_event.dart';
import 'package:feature_themes/presentation/themes/themes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/quote_theme.dart';
import 'package:shared/domain/repositories/quote_repository.dart';
import 'package:shared/domain/repositories/theme_repository.dart';

@injectable
class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {
  ThemesBloc(this._themeRepository, this._quoteRepository) : super(const ThemesLoading()) {
    on<ThemesStarted>(_onStarted);
    on<ThemesThemesUpdated>(_onThemesUpdated);
    on<ThemesMembershipUpdated>(_onMembershipUpdated);
    on<ThemesQuotesUpdated>(_onQuotesUpdated);
    on<ThemesCreateRequested>(_onCreateRequested);
  }

  final ThemeRepository _themeRepository;
  final QuoteRepository _quoteRepository;
  StreamSubscription<AppResult<List<QuoteTheme>>>? _themeSubscription;
  StreamSubscription<AppResult<Map<String, Set<String>>>>? _membershipSubscription;
  StreamSubscription<AppResult<List<Quote>>>? _quoteSubscription;
  List<QuoteTheme>? _themes;
  Map<String, Set<String>> _membership = const {};
  List<Quote> _quotes = const [];
  AppError? _error;

  Future<void> _onStarted(ThemesStarted event, Emitter<ThemesState> emit) async {
    await _themeSubscription?.cancel();
    await _membershipSubscription?.cancel();
    await _quoteSubscription?.cancel();
    _themeSubscription = _themeRepository.watchThemes().listen(
      (result) => add(ThemesThemesUpdated(result)),
    );
    _membershipSubscription = _themeRepository.watchThemeMembership().listen(
      (result) => add(ThemesMembershipUpdated(result)),
    );
    _quoteSubscription = _quoteRepository.watchQuotes().listen(
      (result) => add(ThemesQuotesUpdated(result)),
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

  void _onQuotesUpdated(ThemesQuotesUpdated event, Emitter<ThemesState> emit) {
    if (event.result case Success(:final data)) {
      _quotes = data;
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
    final bookIdByQuote = {for (final quote in _quotes) quote.id: quote.bookId};
    final summaries = themes.map((theme) {
      final quoteIds = _membership[theme.id] ?? const <String>{};
      final bookIds = quoteIds.map((quoteId) => bookIdByQuote[quoteId]).whereType<String>().toSet();
      return ThemeSummary(theme: theme, quoteCount: quoteIds.length, bookCount: bookIds.length);
    }).toList();
    final totalBooks = _quotes.map((quote) => quote.bookId).toSet().length;
    emit(
      ThemesLoaded(themes: summaries, totalQuotes: _quotes.length, totalBooks: totalBooks),
    );
  }

  @override
  Future<void> close() async {
    await _themeSubscription?.cancel();
    await _membershipSubscription?.cancel();
    await _quoteSubscription?.cancel();
    return super.close();
  }
}
