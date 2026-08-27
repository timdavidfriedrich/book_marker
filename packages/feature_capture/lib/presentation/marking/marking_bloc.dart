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
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

@injectable
class MarkingBloc extends Bloc<MarkingEvent, MarkingState> {
  MarkingBloc(
    this._textRecognitionRepository,
    this._saveBookmarkUseCase,
    this._bookRepository,
    @factoryParam this._arguments,
  ) : super(const MarkingProcessing()) {
    on<MarkingStarted>(_onStarted);
    on<MarkingLineToggled>(_onLineToggled);
    on<MarkingPageNumberChanged>(_onPageNumberChanged);
    on<MarkingStarToggled>(_onStarToggled);
    on<MarkingSaveRequested>(_onSaveRequested);
  }

  final TextRecognitionRepository _textRecognitionRepository;
  final SaveBookmarkUseCase _saveBookmarkUseCase;
  final BookRepository _bookRepository;
  final MarkingArguments _arguments;

  Future<void> _onStarted(MarkingStarted event, Emitter<MarkingState> emit) async {
    emit(const MarkingProcessing());
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
        selectedIndexes: const {},
        pageNumber: data.detectedPageNumber,
        isStarred: false,
        isSaving: false,
        saveError: null,
      ),
      Failure(:final error) => MarkingFailure(error: error),
    });
  }

  void _onLineToggled(MarkingLineToggled event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      final selectedIndexes = Set<int>.from(current.selectedIndexes);
      if (!selectedIndexes.add(event.index)) selectedIndexes.remove(event.index);
      emit(
        MarkingReady(
          page: current.page,
          imagePath: current.imagePath,
          bookTitle: current.bookTitle,
          bookAuthors: current.bookAuthors,
          selectedIndexes: selectedIndexes,
          pageNumber: current.pageNumber,
          isStarred: current.isStarred,
          isSaving: false,
          saveError: null,
        ),
      );
    }
  }

  void _onPageNumberChanged(MarkingPageNumberChanged event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      emit(
        MarkingReady(
          page: current.page,
          imagePath: current.imagePath,
          bookTitle: current.bookTitle,
          bookAuthors: current.bookAuthors,
          selectedIndexes: current.selectedIndexes,
          pageNumber: event.pageNumber,
          isStarred: current.isStarred,
          isSaving: false,
          saveError: null,
        ),
      );
    }
  }

  void _onStarToggled(MarkingStarToggled event, Emitter<MarkingState> emit) {
    if (state case final MarkingReady current) {
      emit(
        MarkingReady(
          page: current.page,
          imagePath: current.imagePath,
          bookTitle: current.bookTitle,
          bookAuthors: current.bookAuthors,
          selectedIndexes: current.selectedIndexes,
          pageNumber: current.pageNumber,
          isStarred: !current.isStarred,
          isSaving: false,
          saveError: null,
        ),
      );
    }
  }

  Future<void> _onSaveRequested(MarkingSaveRequested event, Emitter<MarkingState> emit) async {
    if (state case final MarkingReady current when current.selectedIndexes.isNotEmpty) {
      emit(
        MarkingReady(
          page: current.page,
          imagePath: current.imagePath,
          bookTitle: current.bookTitle,
          bookAuthors: current.bookAuthors,
          selectedIndexes: current.selectedIndexes,
          pageNumber: current.pageNumber,
          isStarred: current.isStarred,
          isSaving: true,
          saveError: null,
        ),
      );
      switch (await _saveBookmarkUseCase(_buildBookmark(current))) {
        case Success():
          emit(const MarkingSaved());
        case Failure(:final error):
          emit(
            MarkingReady(
              page: current.page,
              imagePath: current.imagePath,
              bookTitle: current.bookTitle,
              bookAuthors: current.bookAuthors,
              selectedIndexes: current.selectedIndexes,
              pageNumber: current.pageNumber,
              isStarred: current.isStarred,
              isSaving: false,
              saveError: error,
            ),
          );
      }
    }
  }

  Bookmark _buildBookmark(MarkingReady state) {
    final orderedIndexes = state.selectedIndexes.toList()..sort();
    final selectedLines = orderedIndexes.map((index) => state.page.lines[index]).toList();
    return Bookmark(
      id: _uuid.v4(),
      bookId: _arguments.bookId,
      pageNumber: state.pageNumber,
      quote: joinMarkedLines(selectedLines.map((line) => line.text)),
      photoPath: _arguments.imagePath,
      imageAspectRatio: state.page.aspectRatio,
      highlights: selectedLines
          .map(
            (line) => HighlightRegion(
              text: line.text,
              left: line.left,
              top: line.top,
              width: line.width,
              height: line.height,
            ),
          )
          .toList(),
      isFavorite: state.isStarred,
      createdAt: DateTime.now().toUtc(),
    );
  }
}
