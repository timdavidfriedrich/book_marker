import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/mark_text.dart';
import 'package:feature_capture/domain/recognize_captured_spread_use_case.dart';
import 'package:feature_capture/domain/recognized_page.dart';
import 'package:feature_capture/domain/save_quote_use_case.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/highlight_region.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/quote_page.dart';
import 'package:shared/domain/entities/quote_theme.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/theme_repository.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

@injectable
class MarkingBloc extends Bloc<MarkingEvent, MarkingState> {
  MarkingBloc(
    this._recognizeCapturedSpreadUseCase,
    this._saveQuoteUseCase,
    this._bookRepository,
    this._themeRepository,
    @factoryParam this._arguments,
  ) : super(const MarkingProcessing()) {
    on<MarkingStarted>(_onStarted);
    on<MarkingBooksUpdated>(_onBooksUpdated);
    on<MarkingBookChanged>(_onBookChanged);
    on<MarkingWordsSelected>(_onWordsSelected);
    on<MarkingWordCorrected>(_onWordCorrected);
    on<MarkingWordsMerged>(_onWordsMerged);
    on<MarkingPageNumbersChanged>(_onPageNumbersChanged);
    on<MarkingNoteChanged>(_onNoteChanged);
    on<MarkingQuoteEdited>(_onQuoteEdited);
    on<MarkingVoiceNoteRecorded>(_onVoiceNoteRecorded);
    on<MarkingVoiceNoteCleared>(_onVoiceNoteCleared);
    on<MarkingThemesUpdated>(_onThemesUpdated);
    on<MarkingThemeToggled>(_onThemeToggled);
    on<MarkingThemeCreateRequested>(_onThemeCreateRequested);
    on<MarkingFavoriteToggled>(_onFavoriteToggled);
    on<MarkingSaveRequested>(_onSaveRequested);
  }

  final RecognizeCapturedSpreadUseCase _recognizeCapturedSpreadUseCase;
  final SaveQuoteUseCase _saveQuoteUseCase;
  final BookRepository _bookRepository;
  final ThemeRepository _themeRepository;
  final MarkingArguments _arguments;
  StreamSubscription<AppResult<List<QuoteTheme>>>? _themeSubscription;
  StreamSubscription<AppResult<List<Book>>>? _bookSubscription;
  List<QuoteTheme> _themes = const [];
  List<Book> _books = const [];
  final Set<String> _selectedThemeIds = {};
  late String _bookId = _arguments.bookId;

  Future<void> _onStarted(MarkingStarted event, Emitter<MarkingState> emit) async {
    emit(const MarkingProcessing());
    await _themeSubscription?.cancel();
    _themeSubscription = _themeRepository.watchThemes().listen(
      (result) => add(MarkingThemesUpdated(result)),
    );
    await _bookSubscription?.cancel();
    _bookSubscription = _bookRepository.watchBooks().listen(
      (result) => add(MarkingBooksUpdated(result)),
    );
    var bookTitle = "";
    String? bookThumbnailUrl;
    var bookAuthors = const <String>[];
    if (await _bookRepository.getBook(_bookId) case Success(:final data)) {
      bookTitle = data.title;
      bookThumbnailUrl = data.thumbnailUrl;
      bookAuthors = data.authors;
    }
    emit(switch (await _recognizeCapturedSpreadUseCase(_arguments.shots)) {
      Success(:final data) => MarkingReady(
        pages: data.pages,
        words: data.words,
        bookId: _bookId,
        books: _books,
        bookTitle: bookTitle,
        bookThumbnailUrl: bookThumbnailUrl,
        bookAuthors: bookAuthors,
        selectedWordIndexes: const {},
        quoteOverride: null,
        detectedPageNumbers: data.detectedPageNumbers,
        pageNumbers: data.detectedPageNumbers,
        note: null,
        voiceNotePath: null,
        voiceNoteDurationMs: null,
        availableThemes: _themes,
        selectedThemeIds: Set<String>.from(_selectedThemeIds),
        isFavorite: false,
        isSaving: false,
        saveError: null,
      ),
      Failure(:final error) => MarkingFailure(error: error),
    });
  }

  void _onBooksUpdated(MarkingBooksUpdated event, Emitter<MarkingState> emit) {
    if (event.result case Success(:final data)) {
      _books = data;
      if (state case final MarkingReady current) emit(_ready(current));
    }
  }

  void _onBookChanged(MarkingBookChanged event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      _bookId = event.bookId;
      emit(_ready(current));
    }
  }

  void _onThemesUpdated(MarkingThemesUpdated event, Emitter<MarkingState> emit) {
    if (event.result case Success(:final data)) {
      _themes = data;
      if (state case final MarkingReady current) emit(_ready(current));
    }
  }

  void _onThemeToggled(MarkingThemeToggled event, Emitter<MarkingState> emit) {
    if (!_selectedThemeIds.add(event.themeId)) _selectedThemeIds.remove(event.themeId);
    if (state case final MarkingReady current) emit(_ready(current));
  }

  Future<void> _onThemeCreateRequested(
    MarkingThemeCreateRequested event,
    Emitter<MarkingState> emit,
  ) async {
    final name = event.name.trim();
    if (name.isEmpty) return;
    if (await _themeRepository.createTheme(name) case Success(:final data)) {
      _selectedThemeIds.add(data.id);
      if (state case final MarkingReady current) emit(_ready(current));
    }
  }

  void _onWordsSelected(MarkingWordsSelected event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      emit(
        _ready(
          current,
          selectedWordIndexes: _withJoinedNeighbours(event.wordIndexes, current.words),
          keepQuote: false,
        ),
      );
    }
  }

  Set<int> _withJoinedNeighbours(Set<int> indexes, List<RecognizedWord> words) {
    final expanded = <int>{};
    for (final index in indexes) {
      if (index < 0 || index >= words.length) continue;
      expanded.add(index);
      if (words[index].joinsWithNext && index + 1 < words.length) expanded.add(index + 1);
      if (index > 0 && words[index - 1].joinsWithNext) expanded.add(index - 1);
    }
    return expanded;
  }

  void _onWordCorrected(MarkingWordCorrected event, Emitter<MarkingState> emit) {
    final text = event.text.trim();
    if (text.isEmpty) return;
    if (state case final MarkingReady current
        when event.wordIndex >= 0 && event.wordIndex < current.words.length) {
      final source = current.words;
      final indexes = <int>[event.wordIndex];
      while (source[indexes.last].joinsWithNext && indexes.last + 1 < source.length) {
        indexes.add(indexes.last + 1);
      }
      final words = [
        ...source.sublist(0, event.wordIndex),
        _corrected(source, indexes, text),
        ...source.sublist(indexes.last + 1),
      ];
      emit(
        _ready(
          current,
          words: words,
          selectedWordIndexes: _remapSelection(
            current.selectedWordIndexes,
            event.wordIndex,
            indexes.length - 1,
          ),
        ),
      );
    }
  }

  RecognizedWord _corrected(List<RecognizedWord> words, List<int> indexes, String text) {
    final first = words[indexes.first];
    var left = first.left;
    var top = first.top;
    var right = first.left + first.width;
    var bottom = first.top + first.height;
    for (final index in indexes) {
      final word = words[index];
      left = left < word.left ? left : word.left;
      top = top < word.top ? top : word.top;
      right = right > word.left + word.width ? right : word.left + word.width;
      bottom = bottom > word.top + word.height ? bottom : word.top + word.height;
    }
    return RecognizedWord(
      text: text,
      left: left,
      top: top,
      width: right - left,
      height: bottom - top,
      lineIndex: first.lineIndex,
      pageIndex: first.pageIndex,
      confidence: first.confidence,
      isUncertain: false,
      joinsWithNext: false,
    );
  }

  void _onWordsMerged(MarkingWordsMerged event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current
        when event.wordIndex >= 0 && event.wordIndex + 1 < current.words.length) {
      final words = applyJoins(current.words, {event.wordIndex});
      emit(
        _ready(
          current,
          words: words,
          selectedWordIndexes: _remapSelection(
            current.selectedWordIndexes,
            event.wordIndex,
            current.words.length - words.length,
          ),
        ),
      );
    }
  }

  Set<int> _remapSelection(Set<int> selection, int keptIndex, int removed) {
    if (removed <= 0) return selection;
    return {
      for (final index in selection)
        if (index <= keptIndex)
          index
        else if (index <= keptIndex + removed)
          keptIndex
        else
          index - removed,
    };
  }

  void _onPageNumbersChanged(MarkingPageNumbersChanged event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      emit(_ready(current, pageNumbers: event.pageNumbers));
    }
  }

  void _onNoteChanged(MarkingNoteChanged event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      emit(_ready(current, note: event.note, keepNote: false));
    }
  }

  void _onQuoteEdited(MarkingQuoteEdited event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      emit(_ready(current, quoteOverride: event.quote, keepQuote: false));
    }
  }

  void _onVoiceNoteRecorded(MarkingVoiceNoteRecorded event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      emit(
        _ready(
          current,
          voiceNotePath: event.path,
          voiceNoteDurationMs: event.durationMs,
          keepVoiceNote: false,
        ),
      );
    }
  }

  void _onVoiceNoteCleared(MarkingVoiceNoteCleared event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      emit(_ready(current, keepVoiceNote: false));
    }
  }

  void _onFavoriteToggled(MarkingFavoriteToggled event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      emit(_ready(current, isFavorite: !current.isFavorite));
    }
  }

  Future<void> _onSaveRequested(MarkingSaveRequested event, Emitter<MarkingState> emit) async {
    if (state case final MarkingReady current when current.selectedWordIndexes.isNotEmpty) {
      emit(_ready(current, isSaving: true));
      final quote = _buildQuote(current);
      switch (await _saveQuoteUseCase(quote)) {
        case Success():
          for (final themeId in _selectedThemeIds) {
            await _themeRepository.addQuoteToTheme(themeId: themeId, quoteId: quote.id);
          }
          emit(const MarkingSaved());
        case Failure(:final error):
          emit(_ready(current, saveError: error));
      }
    }
  }

  MarkingReady _ready(
    MarkingReady current, {
    List<RecognizedWord>? words,
    Set<int>? selectedWordIndexes,
    String? quoteOverride,
    bool keepQuote = true,
    List<int>? pageNumbers,
    String? note,
    bool keepNote = true,
    String? voiceNotePath,
    int? voiceNoteDurationMs,
    bool keepVoiceNote = true,
    bool? isFavorite,
    bool isSaving = false,
    AppError? saveError,
  }) {
    final book = _selectedBook();
    return MarkingReady(
      pages: current.pages,
      words: words ?? current.words,
      bookId: _bookId,
      books: _books,
      bookTitle: book?.title ?? current.bookTitle,
      bookThumbnailUrl: book == null ? current.bookThumbnailUrl : book.thumbnailUrl,
      bookAuthors: book?.authors ?? current.bookAuthors,
      selectedWordIndexes: selectedWordIndexes ?? current.selectedWordIndexes,
      quoteOverride: keepQuote ? current.quoteOverride : quoteOverride,
      detectedPageNumbers: current.detectedPageNumbers,
      pageNumbers: pageNumbers ?? current.pageNumbers,
      note: keepNote ? current.note : note,
      voiceNotePath: keepVoiceNote ? current.voiceNotePath : voiceNotePath,
      voiceNoteDurationMs: keepVoiceNote ? current.voiceNoteDurationMs : voiceNoteDurationMs,
      availableThemes: _themes,
      selectedThemeIds: Set<String>.from(_selectedThemeIds),
      isFavorite: isFavorite ?? current.isFavorite,
      isSaving: isSaving,
      saveError: saveError,
    );
  }

  Book? _selectedBook() {
    for (final book in _books) {
      if (book.id == _bookId) return book;
    }
    return null;
  }

  Quote _buildQuote(MarkingReady state) {
    final orderedIndexes = state.selectedWordIndexes.toList()..sort();
    final trimmedNote = state.note?.trim();
    final override = state.quoteOverride?.trim();
    final quote = (override != null && override.isNotEmpty)
        ? override
        : joinMarkedWords(state.words, orderedIndexes);
    return Quote(
      id: _uuid.v4(),
      bookId: _bookId,
      pageNumbers: state.pageNumbers,
      quote: quote,
      note: (trimmedNote == null || trimmedNote.isEmpty) ? null : trimmedNote,
      voiceNotePath: state.voiceNotePath,
      voiceNoteDurationMs: state.voiceNoteDurationMs,
      pages: _quotePages(state, orderedIndexes),
      isFavorite: state.isFavorite,
      createdAt: DateTime.now().toUtc(),
    );
  }

  List<QuotePage> _quotePages(MarkingReady state, List<int> orderedIndexes) {
    final selected = [for (final index in orderedIndexes) state.words[index]];
    final pages = <QuotePage>[];
    for (final (index, page) in state.pages.indexed) {
      final highlights = [
        for (final word in selected)
          if (word.pageIndex == index)
            HighlightRegion(
              text: word.text,
              left: word.left,
              top: word.top,
              width: word.width,
              height: word.height,
            ),
      ];
      if (highlights.isEmpty) continue;
      pages.add(
        QuotePage(
          photoPath: page.imagePath,
          imageAspectRatio: page.aspectRatio,
          highlights: highlights,
        ),
      );
    }
    return pages;
  }

  @override
  Future<void> close() async {
    await _themeSubscription?.cancel();
    await _bookSubscription?.cancel();
    return super.close();
  }
}
