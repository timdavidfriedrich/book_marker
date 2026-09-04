import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/recognize_captured_spread_use_case.dart';
import 'package:feature_capture/domain/recognized_spread.dart';
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
import 'package:shared/domain/entities/recognized_word.dart';
import 'package:shared/domain/entities/recognized_word_extensions.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/theme_repository.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
// * a word counts as marked when its centre sits inside a stored highlight
const _highlightTolerance = 0.002;

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
    on<MarkingWordCorrectionUndone>(_onWordCorrectionUndone);
    on<MarkingPageNumbersChanged>(_onPageNumbersChanged);
    on<MarkingNoteChanged>(_onNoteChanged);
    on<MarkingQuoteEdited>(_onQuoteEdited);
    on<MarkingVoiceNoteRecorded>(_onVoiceNoteRecorded);
    on<MarkingVoiceNoteCleared>(_onVoiceNoteCleared);
    on<MarkingThemesUpdated>(_onThemesUpdated);
    on<MarkingThemeMembershipUpdated>(_onThemeMembershipUpdated);
    on<MarkingThemeToggled>(_onThemeToggled);
    on<MarkingThemeCreateRequested>(_onThemeCreateRequested);
    on<MarkingFavoriteToggled>(_onFavoriteToggled);
    on<MarkingSaveRequested>(_onSaveRequested);
    _bookId = _arguments.bookId;
  }

  final RecognizeCapturedSpreadUseCase _recognizeCapturedSpreadUseCase;
  final SaveQuoteUseCase _saveQuoteUseCase;
  final BookRepository _bookRepository;
  final ThemeRepository _themeRepository;
  final MarkingArguments _arguments;
  StreamSubscription<AppResult<List<QuoteTheme>>>? _themeSubscription;
  StreamSubscription<AppResult<List<Book>>>? _bookSubscription;
  StreamSubscription<AppResult<Map<String, Set<String>>>>? _membershipSubscription;
  List<QuoteTheme> _themes = const [];
  List<Book> _books = const [];
  final Set<String> _selectedThemeIds = {};
  String? _bookId;
  List<RecognizedWord>? _wordsBeforeCorrection;
  Set<int>? _selectionBeforeCorrection;
  late final Quote? _editedQuote = _arguments.quote;

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
    if (_editedQuote != null) {
      await _membershipSubscription?.cancel();
      _membershipSubscription = _themeRepository.watchThemeMembership().listen(
        (result) => add(MarkingThemeMembershipUpdated(result)),
      );
    }
    var bookTitle = "";
    String? bookCoverImage;
    var bookAuthors = const <String>[];
    if (_bookId case final String bookId) {
      if (await _bookRepository.getBook(bookId) case Success(:final data)) {
        bookTitle = data.title;
        bookCoverImage = data.coverImage;
        bookAuthors = data.authors;
      }
    }
    // * a stored quote carries its recognised words, so re-marking never scans the pages again
    if (_editedQuote case final Quote quote when quote.words.isNotEmpty) {
      emit(
        _started(
          pages: [
            for (final page in quote.pages)
              SpreadPage(imagePath: page.photoPath, aspectRatio: page.imageAspectRatio),
          ],
          words: quote.words,
          selectedWordIndexes: Set<int>.from(quote.markedWordIndexes),
          detectedPageNumbers: const [],
          bookTitle: bookTitle,
          bookCoverImage: bookCoverImage,
          bookAuthors: bookAuthors,
        ),
      );
      return;
    }
    emit(switch (await _recognizeCapturedSpreadUseCase(_arguments.shots)) {
      Success(:final data) => _started(
        pages: data.pages,
        words: data.words,
        selectedWordIndexes: _restoredSelection(data.words),
        detectedPageNumbers: data.detectedPageNumbers,
        bookTitle: bookTitle,
        bookCoverImage: bookCoverImage,
        bookAuthors: bookAuthors,
      ),
      Failure(:final error) => MarkingFailure(error: error),
    });
  }

  MarkingReady _started({
    required List<SpreadPage> pages,
    required List<RecognizedWord> words,
    required Set<int> selectedWordIndexes,
    required List<int> detectedPageNumbers,
    required String bookTitle,
    required String? bookCoverImage,
    required List<String> bookAuthors,
  }) {
    final book = _selectedBook();
    return MarkingReady(
      pages: pages,
      words: words,
      bookId: _bookId,
      books: _books,
      bookTitle: book?.title ?? bookTitle,
      bookCoverImage: book?.coverImage ?? bookCoverImage,
      bookAuthors: book?.authors ?? bookAuthors,
      selectedWordIndexes: selectedWordIndexes,
      quoteOverride: _editedQuote?.quote,
      detectedPageNumbers: detectedPageNumbers,
      pageNumbers: _editedQuote?.pageNumbers ?? detectedPageNumbers,
      note: _editedQuote?.note,
      voiceNotePath: _editedQuote?.voiceNotePath,
      voiceNoteDurationMs: _editedQuote?.voiceNoteDurationMs,
      availableThemes: _themes,
      selectedThemeIds: Set<String>.from(_selectedThemeIds),
      isFavorite: _editedQuote?.isFavorite ?? false,
      isEditing: _editedQuote != null,
      isSaving: false,
      saveError: null,
    );
  }

  void _onBooksUpdated(MarkingBooksUpdated event, Emitter<MarkingState> emit) {
    if (event.result case Success(:final data)) {
      _books = data;
      if (_bookId == null && data.isNotEmpty) _bookId = data.first.id;
      if (state case final MarkingReady current) emit(_ready(current));
    }
  }

  void _onBookChanged(MarkingBookChanged event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      _bookId = event.bookId;
      emit(_ready(current));
    }
  }

  void _onThemeMembershipUpdated(
    MarkingThemeMembershipUpdated event,
    Emitter<MarkingState> emit,
  ) {
    if (_editedQuote case final Quote quote) {
      if (event.result case Success(:final data)) {
        _selectedThemeIds
          ..clear()
          ..addAll({
            for (final entry in data.entries)
              if (entry.value.contains(quote.id)) entry.key,
          });
        unawaited(_membershipSubscription?.cancel());
        _membershipSubscription = null;
        if (state case final MarkingReady current) emit(_ready(current));
      }
    }
  }

  Set<int> _restoredSelection(List<RecognizedWord> words) {
    if (_editedQuote case final Quote quote) {
      return {
        for (final (pageIndex, page) in quote.pages.indexed)
          for (final highlight in page.highlights)
            for (final (index, word) in words.indexed)
              if (word.pageIndex == pageIndex && _isMarked(word, highlight)) index,
      };
    }
    return const {};
  }

  bool _isMarked(RecognizedWord word, HighlightRegion highlight) {
    final centerX = word.left + word.width / 2;
    final centerY = word.top + word.height / 2;
    return centerX >= highlight.left - _highlightTolerance &&
        centerX <= highlight.left + highlight.width + _highlightTolerance &&
        centerY >= highlight.top - _highlightTolerance &&
        centerY <= highlight.top + highlight.height + _highlightTolerance;
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
        when event.startIndex >= 0 &&
            event.endIndex >= event.startIndex &&
            event.endIndex < current.words.length) {
      final source = current.words;
      final indexes = [
        for (var index = event.startIndex; index <= event.endIndex; index++) index,
      ];
      while (source[indexes.last].joinsWithNext && indexes.last + 1 < source.length) {
        indexes.add(indexes.last + 1);
      }
      final words = [
        ...source.sublist(0, event.startIndex),
        _corrected(source, indexes, text),
        ...source.sublist(indexes.last + 1),
      ];
      _wordsBeforeCorrection = source;
      _selectionBeforeCorrection = current.selectedWordIndexes;
      emit(
        _ready(
          current,
          words: words,
          selectedWordIndexes: _remapSelection(
            current.selectedWordIndexes,
            event.startIndex,
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

  void _onWordCorrectionUndone(MarkingWordCorrectionUndone event, Emitter<MarkingState> emit) {
    if (_wordsBeforeCorrection case final List<RecognizedWord> restored) {
      if (state case final MarkingReady current) {
        emit(
          _ready(current, words: restored, selectedWordIndexes: _selectionBeforeCorrection),
        );
      }
      _wordsBeforeCorrection = null;
      _selectionBeforeCorrection = null;
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
      if (_bookId case final String bookId) {
        emit(_ready(current, isSaving: true));
        final quote = _buildQuote(current, bookId);
        switch (await _saveQuoteUseCase(quote)) {
          case Success():
            for (final themeId in _selectedThemeIds) {
              await _themeRepository.addQuoteToTheme(themeId: themeId, quoteId: quote.id);
            }
            if (_editedQuote != null) {
              for (final theme in _themes) {
                if (_selectedThemeIds.contains(theme.id)) continue;
                await _themeRepository.removeQuoteFromTheme(themeId: theme.id, quoteId: quote.id);
              }
            }
            emit(MarkingSaved(isEditing: _editedQuote != null));
          case Failure(:final error):
            emit(_ready(current, saveError: error));
        }
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
      bookCoverImage: book == null ? current.bookCoverImage : book.coverImage,
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
      isEditing: current.isEditing,
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

  Quote _buildQuote(MarkingReady state, String bookId) {
    final orderedIndexes = state.selectedWordIndexes.toList()..sort();
    final trimmedNote = state.note?.trim();
    final override = state.quoteOverride?.trim();
    final quote = (override != null && override.isNotEmpty)
        ? override
        : state.words.joinMarked(orderedIndexes);
    return Quote(
      id: _editedQuote?.id ?? _uuid.v4(),
      bookId: bookId,
      pageNumbers: state.pageNumbers,
      quote: quote,
      note: (trimmedNote == null || trimmedNote.isEmpty) ? null : trimmedNote,
      voiceNotePath: state.voiceNotePath,
      voiceNoteDurationMs: state.voiceNoteDurationMs,
      pages: _quotePages(state, orderedIndexes),
      words: state.words,
      markedWordIndexes: orderedIndexes,
      isFavorite: state.isFavorite,
      createdAt: _editedQuote?.createdAt ?? DateTime.now().toUtc(),
    );
  }

  List<QuotePage> _quotePages(MarkingReady state, List<int> orderedIndexes) {
    return [
      for (final (index, page) in state.pages.indexed)
        QuotePage(
          photoPath: page.imagePath,
          imageAspectRatio: page.aspectRatio,
          highlights: state.words.markedRegionsOn(index, orderedIndexes),
        ),
    ];
  }

  @override
  Future<void> close() async {
    await _membershipSubscription?.cancel();
    await _themeSubscription?.cancel();
    await _bookSubscription?.cancel();
    return super.close();
  }
}
