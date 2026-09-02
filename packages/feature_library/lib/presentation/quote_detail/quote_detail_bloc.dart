import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_event.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/quote_theme.dart';
import 'package:shared/domain/entities/recognized_word_extensions.dart';
import 'package:shared/domain/entities/voice_note.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/quote_repository.dart';
import 'package:shared/domain/repositories/theme_repository.dart';

const _markingSyncDelay = Duration(milliseconds: 500);

@injectable
class QuoteDetailBloc extends Bloc<QuoteDetailEvent, QuoteDetailState> {
  QuoteDetailBloc(
    this._quoteRepository,
    this._bookRepository,
    this._themeRepository,
    @factoryParam this._quoteId,
  ) : super(const QuoteDetailLoading()) {
    on<QuoteDetailStarted>(_onStarted);
    on<QuoteDetailFavoriteToggled>(_onFavoriteToggled);
    on<QuoteDetailQuoteChanged>(_onQuoteChanged);
    on<QuoteDetailMarkingSyncRequested>(_onMarkingSyncRequested);
    on<QuoteDetailNoteChanged>(_onNoteChanged);
    on<QuoteDetailPageNumbersChanged>(_onPageNumbersChanged);
    on<QuoteDetailVoiceNoteRecorded>(_onVoiceNoteRecorded);
    on<QuoteDetailVoiceNoteCleared>(_onVoiceNoteCleared);
    on<QuoteDetailThemesUpdated>(_onThemesUpdated);
    on<QuoteDetailThemeMembershipUpdated>(_onThemeMembershipUpdated);
    on<QuoteDetailThemeToggled>(_onThemeToggled);
    on<QuoteDetailThemeCreateRequested>(_onThemeCreateRequested);
    on<QuoteDetailDeleteRequested>(_onDeleteRequested);
  }

  final QuoteRepository _quoteRepository;
  final BookRepository _bookRepository;
  final ThemeRepository _themeRepository;
  final String _quoteId;
  StreamSubscription<AppResult<List<QuoteTheme>>>? _themeSubscription;
  StreamSubscription<AppResult<Map<String, Set<String>>>>? _membershipSubscription;
  Timer? _markingSyncTimer;
  Quote? _quote;
  Book? _book;
  List<QuoteTheme> _themes = const [];
  Set<String> _selectedThemeIds = const {};
  AppError? _error;

  Future<void> _onStarted(QuoteDetailStarted event, Emitter<QuoteDetailState> emit) async {
    switch (await _quoteRepository.getQuote(_quoteId)) {
      case Failure(:final error):
        _error = error;
        _emitState(emit);
        return;
      case Success(:final data):
        _quote = data;
        _book = await _resolveBook(data.bookId);
    }
    _emitState(emit);
    await _themeSubscription?.cancel();
    _themeSubscription = _themeRepository.watchThemes().listen(
      (result) => add(QuoteDetailThemesUpdated(result)),
    );
    await _membershipSubscription?.cancel();
    _membershipSubscription = _themeRepository.watchThemeMembership().listen(
      (result) => add(QuoteDetailThemeMembershipUpdated(result)),
    );
  }

  Future<void> _onFavoriteToggled(
    QuoteDetailFavoriteToggled event,
    Emitter<QuoteDetailState> emit,
  ) async {
    final quote = _quote;
    if (quote == null) return;
    final nextValue = !quote.isFavorite;
    if (await _quoteRepository.setFavorite(quote.id, isFavorite: nextValue) case Success()) {
      _quote = quote.copyWith(isFavorite: nextValue);
      _emitState(emit);
    }
  }

  Future<void> _onQuoteChanged(
    QuoteDetailQuoteChanged event,
    Emitter<QuoteDetailState> emit,
  ) async {
    final quote = _quote;
    if (quote == null) return;
    final trimmed = event.quote.trim();
    // * an empty field is a step on the way to the next wording, never a quote worth storing
    if (trimmed.isEmpty || trimmed == quote.quote) return;
    if (await _quoteRepository.setQuote(quote.id, trimmed) case Success()) {
      _quote = quote.copyWith(quote: trimmed);
      _emitState(emit);
      // * the marked words follow once the typing settles, they cost a full row to rewrite
      _markingSyncTimer?.cancel();
      _markingSyncTimer = Timer(
        _markingSyncDelay,
        () => add(const QuoteDetailMarkingSyncRequested()),
      );
    }
  }

  Future<void> _onMarkingSyncRequested(
    QuoteDetailMarkingSyncRequested event,
    Emitter<QuoteDetailState> emit,
  ) async {
    final quote = _quote;
    if (quote == null) return;
    // * a rewrite that no longer lines up with the page keeps the marks it was taken from
    final words = quote.words.applyMarkedText(quote.quote, quote.markedWordIndexes);
    if (words == null) return;
    final updated = quote.copyWith(
      words: words,
      pages: [
        for (final (index, page) in quote.pages.indexed)
          page.copyWith(highlights: words.markedRegionsOn(index, quote.markedWordIndexes)),
      ],
    );
    if (await _quoteRepository.saveQuote(updated) case Success()) {
      _quote = updated;
      _emitState(emit);
    }
  }

  Future<void> _onNoteChanged(
    QuoteDetailNoteChanged event,
    Emitter<QuoteDetailState> emit,
  ) async {
    final quote = _quote;
    if (quote == null) return;
    final trimmed = event.note?.trim();
    final nextNote = (trimmed == null || trimmed.isEmpty) ? null : trimmed;
    if (await _quoteRepository.setNote(quote.id, nextNote) case Success()) {
      _quote = quote.copyWith(note: nextNote);
      _emitState(emit);
    }
  }

  Future<void> _onPageNumbersChanged(
    QuoteDetailPageNumbersChanged event,
    Emitter<QuoteDetailState> emit,
  ) async {
    final quote = _quote;
    if (quote == null) return;
    if (await _quoteRepository.setPageNumbers(quote.id, event.pageNumbers) case Success()) {
      _quote = quote.copyWith(pageNumbers: event.pageNumbers);
      _emitState(emit);
    }
  }

  Future<void> _onVoiceNoteRecorded(
    QuoteDetailVoiceNoteRecorded event,
    Emitter<QuoteDetailState> emit,
  ) async {
    final quote = _quote;
    if (quote == null) return;
    final voiceNote = VoiceNote(path: event.path, durationMs: event.durationMs);
    if (await _quoteRepository.setVoiceNote(quote.id, voiceNote) case Success()) {
      _quote = quote.copyWith(
        voiceNotePath: voiceNote.path,
        voiceNoteDurationMs: voiceNote.durationMs,
      );
      _emitState(emit);
    }
  }

  Future<void> _onVoiceNoteCleared(
    QuoteDetailVoiceNoteCleared event,
    Emitter<QuoteDetailState> emit,
  ) async {
    final quote = _quote;
    if (quote == null) return;
    if (await _quoteRepository.setVoiceNote(quote.id, null) case Success()) {
      _quote = quote.copyWith(voiceNotePath: null, voiceNoteDurationMs: null);
      _emitState(emit);
    }
  }

  void _onThemesUpdated(QuoteDetailThemesUpdated event, Emitter<QuoteDetailState> emit) {
    if (event.result case Success(:final data)) {
      _themes = data;
      _emitState(emit);
    }
  }

  void _onThemeMembershipUpdated(
    QuoteDetailThemeMembershipUpdated event,
    Emitter<QuoteDetailState> emit,
  ) {
    if (event.result case Success(:final data)) {
      _selectedThemeIds = {
        for (final entry in data.entries)
          if (entry.value.contains(_quoteId)) entry.key,
      };
      _emitState(emit);
    }
  }

  Future<void> _onThemeToggled(
    QuoteDetailThemeToggled event,
    Emitter<QuoteDetailState> emit,
  ) async {
    if (_selectedThemeIds.contains(event.themeId)) {
      await _themeRepository.removeQuoteFromTheme(themeId: event.themeId, quoteId: _quoteId);
      return;
    }
    await _themeRepository.addQuoteToTheme(themeId: event.themeId, quoteId: _quoteId);
  }

  Future<void> _onThemeCreateRequested(
    QuoteDetailThemeCreateRequested event,
    Emitter<QuoteDetailState> emit,
  ) async {
    final name = event.name.trim();
    if (name.isEmpty) return;
    if (await _themeRepository.createTheme(name) case Success(:final data)) {
      await _themeRepository.addQuoteToTheme(themeId: data.id, quoteId: _quoteId);
    }
  }

  Future<void> _onDeleteRequested(
    QuoteDetailDeleteRequested event,
    Emitter<QuoteDetailState> emit,
  ) async {
    final quote = _quote;
    if (quote == null) return;
    if (await _quoteRepository.deleteQuote(quote.id) case Success()) {
      emit(const QuoteDetailDeleted());
    }
  }

  Future<Book?> _resolveBook(String bookId) async {
    return switch (await _bookRepository.getBook(bookId)) {
      Success(:final data) => data,
      Failure() => null,
    };
  }

  void _emitState(Emitter<QuoteDetailState> emit) {
    if (state is QuoteDetailDeleted) return;
    if (_error case final AppError error) {
      emit(QuoteDetailFailure(error: error));
      return;
    }
    final quote = _quote;
    if (quote == null) return;
    emit(
      QuoteDetailLoaded(
        quote: quote,
        book: _book,
        themes: _themes,
        selectedThemeIds: _selectedThemeIds,
      ),
    );
  }

  @override
  Future<void> close() async {
    _markingSyncTimer?.cancel();
    await _themeSubscription?.cancel();
    await _membershipSubscription?.cancel();
    return super.close();
  }
}
