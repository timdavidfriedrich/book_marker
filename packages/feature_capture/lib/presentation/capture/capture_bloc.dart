import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/capture_span.dart';
import 'package:feature_capture/presentation/capture/capture_event.dart';
import 'package:feature_capture/presentation/capture/capture_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/captured_shot.dart';
import 'package:shared/domain/repositories/book_repository.dart';

@injectable
class CaptureBloc extends Bloc<CaptureEvent, CaptureState> {
  CaptureBloc(this._bookRepository) : super(const CaptureLoading()) {
    on<CaptureStarted>(_onStarted);
    on<CaptureBooksUpdated>(_onBooksUpdated);
    on<CaptureBookSelected>(_onBookSelected);
    on<CaptureSpanSelected>(_onSpanSelected);
    on<CaptureShotTaken>(_onShotTaken);
    on<CaptureShotDiscarded>(_onShotDiscarded);
    on<CaptureShotMoved>(_onShotMoved);
  }

  final BookRepository _bookRepository;
  StreamSubscription<AppResult<List<Book>>>? _subscription;
  String? _selectedBookId;
  CaptureSpan _span = CaptureSpan.onePage;
  List<CapturedShot> _shots = const [];

  Future<void> _onStarted(CaptureStarted event, Emitter<CaptureState> emit) async {
    await _subscription?.cancel();
    _subscription = _bookRepository.watchBooks().listen(
      (result) => add(CaptureBooksUpdated(result)),
    );
  }

  void _onBooksUpdated(CaptureBooksUpdated event, Emitter<CaptureState> emit) {
    switch (event.result) {
      case Failure(:final error):
        emit(CaptureFailure(error: error));
      case Success(:final data):
        if (data.isEmpty) {
          _selectedBookId = null;
          emit(CaptureEmpty(span: _span));
          return;
        }
        final hasSelection = data.any((book) => book.id == _selectedBookId);
        final selectedBookId = hasSelection ? _selectedBookId! : data.first.id;
        _selectedBookId = selectedBookId;
        emit(_ready(data, selectedBookId));
    }
  }

  void _onBookSelected(CaptureBookSelected event, Emitter<CaptureState> emit) {
    _selectedBookId = event.bookId;
    if (state case final CaptureReady current
        when current.books.any((book) => book.id == event.bookId)) {
      emit(_ready(current.books, event.bookId));
    }
  }

  void _onSpanSelected(CaptureSpanSelected event, Emitter<CaptureState> emit) {
    if (_span == event.span) return;
    _span = event.span;
    _shots = const [];
    switch (state) {
      case final CaptureReady current:
        emit(_ready(current.books, current.selectedBookId));
      case CaptureEmpty():
        emit(CaptureEmpty(span: _span));
      case CaptureLoading() || CaptureFailure():
        break;
    }
  }

  void _onShotTaken(CaptureShotTaken event, Emitter<CaptureState> emit) {
    _shots = [..._shots, event.shot];
    if (state case final CaptureReady current) emit(_ready(current.books, current.selectedBookId));
  }

  void _onShotDiscarded(CaptureShotDiscarded event, Emitter<CaptureState> emit) {
    if (event.index < 0 || event.index >= _shots.length) return;
    _shots = [..._shots]..removeAt(event.index);
    if (state case final CaptureReady current) emit(_ready(current.books, current.selectedBookId));
  }

  void _onShotMoved(CaptureShotMoved event, Emitter<CaptureState> emit) {
    if (event.fromIndex < 0 || event.fromIndex >= _shots.length) return;
    if (event.toIndex < 0 || event.toIndex >= _shots.length) return;
    if (event.fromIndex == event.toIndex) return;
    final shots = [..._shots];
    shots.insert(event.toIndex, shots.removeAt(event.fromIndex));
    _shots = shots;
    if (state case final CaptureReady current) emit(_ready(current.books, current.selectedBookId));
  }

  CaptureReady _ready(List<Book> books, String selectedBookId) {
    return CaptureReady(
      books: books,
      selectedBookId: selectedBookId,
      span: _span,
      shots: _shots,
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
