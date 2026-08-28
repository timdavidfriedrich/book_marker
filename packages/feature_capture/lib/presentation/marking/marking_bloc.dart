import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/mark_text.dart';
import 'package:feature_capture/domain/save_bookmark_use_case.dart';
import 'package:feature_capture/domain/text_recognition_repository.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/entities/highlight_region.dart';
import 'package:shared/domain/entities/mark_theme.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/domain/repositories/theme_repository.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

@injectable
class MarkingBloc extends Bloc<MarkingEvent, MarkingState> {
  MarkingBloc(
    this._textRecognitionRepository,
    this._saveBookmarkUseCase,
    this._bookRepository,
    this._themeRepository,
    @factoryParam this._arguments,
  ) : super(const MarkingProcessing()) {
    on<MarkingStarted>(_onStarted);
    on<MarkingWordsSelected>(_onWordsSelected);
    on<MarkingPageNumberChanged>(_onPageNumberChanged);
    on<MarkingNoteChanged>(_onNoteChanged);
    on<MarkingQuoteEdited>(_onQuoteEdited);
    on<MarkingVoiceRecorded>(_onVoiceRecorded);
    on<MarkingVoiceCleared>(_onVoiceCleared);
    on<MarkingThemesUpdated>(_onThemesUpdated);
    on<MarkingThemeToggled>(_onThemeToggled);
    on<MarkingThemeCreateRequested>(_onThemeCreateRequested);
    on<MarkingStarToggled>(_onStarToggled);
    on<MarkingSaveRequested>(_onSaveRequested);
  }

  final TextRecognitionRepository _textRecognitionRepository;
  final SaveBookmarkUseCase _saveBookmarkUseCase;
  final BookRepository _bookRepository;
  final ThemeRepository _themeRepository;
  final MarkingArguments _arguments;
  StreamSubscription<AppResult<List<MarkTheme>>>? _themeSubscription;
  List<MarkTheme> _themes = const [];
  final Set<String> _selectedThemeIds = {};

  Future<void> _onStarted(MarkingStarted event, Emitter<MarkingState> emit) async {
    emit(const MarkingProcessing());
    await _themeSubscription?.cancel();
    _themeSubscription = _themeRepository.watchThemes().listen(
      (result) => add(MarkingThemesUpdated(result)),
    );
    var bookTitle = "";
    var bookAuthors = const <String>[];
    if (await _bookRepository.getBook(_arguments.bookId) case Success(:final data)) {
      bookTitle = data.title;
      bookAuthors = data.authors;
    }
    emit(switch (await _textRecognitionRepository.recognizePage(_arguments.imagePath)) {
      Success(:final data) => MarkingReady(
        page: data,
        imagePath: _arguments.imagePath,
        bookTitle: bookTitle,
        bookAuthors: bookAuthors,
        selectedWordIndexes: const {},
        quoteOverride: null,
        pageNumber: data.detectedPageNumber,
        note: null,
        voicePath: null,
        voiceDurationMs: null,
        availableThemes: _themes,
        selectedThemeIds: Set<String>.from(_selectedThemeIds),
        isStarred: false,
        isSaving: false,
        saveError: null,
      ),
      Failure(:final error) => MarkingFailure(error: error),
    });
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
      emit(_ready(current, selectedWordIndexes: event.wordIndexes, keepQuote: false));
    }
  }

  void _onPageNumberChanged(MarkingPageNumberChanged event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      emit(_ready(current, pageNumber: event.pageNumber, keepPageNumber: false));
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

  void _onVoiceRecorded(MarkingVoiceRecorded event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      emit(_ready(current, voicePath: event.path, voiceDurationMs: event.durationMs, keepVoice: false));
    }
  }

  void _onVoiceCleared(MarkingVoiceCleared event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      emit(_ready(current, keepVoice: false));
    }
  }

  void _onStarToggled(MarkingStarToggled event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      emit(_ready(current, isStarred: !current.isStarred));
    }
  }

  Future<void> _onSaveRequested(MarkingSaveRequested event, Emitter<MarkingState> emit) async {
    if (state case final MarkingReady current when current.selectedWordIndexes.isNotEmpty) {
      emit(_ready(current, isSaving: true));
      final bookmark = _buildBookmark(current);
      switch (await _saveBookmarkUseCase(bookmark)) {
        case Success():
          for (final themeId in _selectedThemeIds) {
            await _themeRepository.addMarkToTheme(themeId: themeId, bookmarkId: bookmark.id);
          }
          emit(const MarkingSaved());
        case Failure(:final error):
          emit(_ready(current, saveError: error));
      }
    }
  }

  MarkingReady _ready(
    MarkingReady current, {
    Set<int>? selectedWordIndexes,
    String? quoteOverride,
    bool keepQuote = true,
    int? pageNumber,
    bool keepPageNumber = true,
    String? note,
    bool keepNote = true,
    String? voicePath,
    int? voiceDurationMs,
    bool keepVoice = true,
    bool? isStarred,
    bool isSaving = false,
    AppError? saveError,
  }) {
    return MarkingReady(
      page: current.page,
      imagePath: current.imagePath,
      bookTitle: current.bookTitle,
      bookAuthors: current.bookAuthors,
      selectedWordIndexes: selectedWordIndexes ?? current.selectedWordIndexes,
      quoteOverride: keepQuote ? current.quoteOverride : quoteOverride,
      pageNumber: keepPageNumber ? current.pageNumber : pageNumber,
      note: keepNote ? current.note : note,
      voicePath: keepVoice ? current.voicePath : voicePath,
      voiceDurationMs: keepVoice ? current.voiceDurationMs : voiceDurationMs,
      availableThemes: _themes,
      selectedThemeIds: Set<String>.from(_selectedThemeIds),
      isStarred: isStarred ?? current.isStarred,
      isSaving: isSaving,
      saveError: saveError,
    );
  }

  Bookmark _buildBookmark(MarkingReady state) {
    final orderedIndexes = state.selectedWordIndexes.toList()..sort();
    final selectedWords = orderedIndexes.map((index) => state.page.words[index]).toList();
    final trimmedNote = state.note?.trim();
    final override = state.quoteOverride?.trim();
    final quote = (override != null && override.isNotEmpty)
        ? override
        : joinMarkedLines(selectedWords.map((word) => word.text));
    return Bookmark(
      id: _uuid.v4(),
      bookId: _arguments.bookId,
      pageNumber: state.pageNumber,
      quote: quote,
      note: (trimmedNote == null || trimmedNote.isEmpty) ? null : trimmedNote,
      voicePath: state.voicePath,
      voiceDurationMs: state.voiceDurationMs,
      photoPath: _arguments.imagePath,
      imageAspectRatio: state.page.aspectRatio,
      highlights: selectedWords
          .map(
            (word) => HighlightRegion(
              text: word.text,
              left: word.left,
              top: word.top,
              width: word.width,
              height: word.height,
            ),
          )
          .toList(),
      isFavorite: state.isStarred,
      createdAt: DateTime.now().toUtc(),
    );
  }

  @override
  Future<void> close() async {
    await _themeSubscription?.cancel();
    return super.close();
  }
}
