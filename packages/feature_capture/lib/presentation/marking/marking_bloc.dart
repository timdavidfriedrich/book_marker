import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/save_bookmark_use_case.dart';
import 'package:feature_capture/domain/text_recognition_repository.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/entities/highlight_region.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
const _quoteSeparator = " ";

@injectable
class MarkingBloc extends Bloc<MarkingEvent, MarkingState> {
  MarkingBloc(
    this._textRecognitionRepository,
    this._saveBookmarkUseCase,
    @factoryParam this._arguments,
  ) : super(const MarkingProcessing()) {
    on<MarkingStarted>(_onStarted);
    on<MarkingLineToggled>(_onLineToggled);
    on<MarkingPageNumberChanged>(_onPageNumberChanged);
    on<MarkingSaveRequested>(_onSaveRequested);
  }

  final TextRecognitionRepository _textRecognitionRepository;
  final SaveBookmarkUseCase _saveBookmarkUseCase;
  final MarkingArguments _arguments;

  Future<void> _onStarted(MarkingStarted event, Emitter<MarkingState> emit) async {
    emit(const MarkingProcessing());
    emit(switch (await _textRecognitionRepository.recognizePage(_arguments.imagePath)) {
      Success(:final data) => MarkingReady(
        page: data,
        imagePath: _arguments.imagePath,
        selectedIndexes: const {},
        pageNumber: data.detectedPageNumber,
        isSaving: false,
        saveError: null,
      ),
      Failure(:final error) => MarkingFailure(error: error),
    });
  }

  void _onLineToggled(MarkingLineToggled event, Emitter<MarkingState> emit) {
    final currentState = state;
    if (currentState is! MarkingReady) return;
    final selectedIndexes = Set<int>.from(currentState.selectedIndexes);
    if (!selectedIndexes.add(event.index)) selectedIndexes.remove(event.index);
    emit(
      MarkingReady(
        page: currentState.page,
        imagePath: currentState.imagePath,
        selectedIndexes: selectedIndexes,
        pageNumber: currentState.pageNumber,
        isSaving: false,
        saveError: null,
      ),
    );
  }

  void _onPageNumberChanged(MarkingPageNumberChanged event, Emitter<MarkingState> emit) {
    final currentState = state;
    if (currentState is! MarkingReady) return;
    emit(
      MarkingReady(
        page: currentState.page,
        imagePath: currentState.imagePath,
        selectedIndexes: currentState.selectedIndexes,
        pageNumber: event.pageNumber,
        isSaving: false,
        saveError: null,
      ),
    );
  }

  Future<void> _onSaveRequested(MarkingSaveRequested event, Emitter<MarkingState> emit) async {
    final currentState = state;
    if (currentState is! MarkingReady || currentState.selectedIndexes.isEmpty) return;
    emit(
      MarkingReady(
        page: currentState.page,
        imagePath: currentState.imagePath,
        selectedIndexes: currentState.selectedIndexes,
        pageNumber: currentState.pageNumber,
        isSaving: true,
        saveError: null,
      ),
    );

    switch (await _saveBookmarkUseCase(_buildBookmark(currentState))) {
      case Success():
        emit(const MarkingSaved());
      case Failure(:final error):
        emit(
          MarkingReady(
            page: currentState.page,
            imagePath: currentState.imagePath,
            selectedIndexes: currentState.selectedIndexes,
            pageNumber: currentState.pageNumber,
            isSaving: false,
            saveError: error,
          ),
        );
    }
  }

  Bookmark _buildBookmark(MarkingReady state) {
    final orderedIndexes = state.selectedIndexes.toList()..sort();
    final selectedLines = orderedIndexes.map((index) => state.page.lines[index]).toList();
    return Bookmark(
      id: _uuid.v4(),
      bookId: _arguments.bookId,
      pageNumber: state.pageNumber,
      quote: selectedLines.map((line) => line.text).join(_quoteSeparator),
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
      isFavorite: false,
      createdAt: DateTime.now().toUtc(),
    );
  }
}
