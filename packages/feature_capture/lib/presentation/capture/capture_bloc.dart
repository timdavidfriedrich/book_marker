import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:feature_capture/presentation/capture/capture_event.dart';
import 'package:feature_capture/presentation/capture/capture_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/repositories/book_repository.dart';

@injectable
class CaptureBloc extends Bloc<CaptureEvent, CaptureState> {
  CaptureBloc(this._bookRepository) : super(const CaptureLoading()) {
    on<CaptureStarted>(_onStarted);
    on<CaptureBooksUpdated>(_onBooksUpdated);
    on<CaptureBookSelected>(_onBookSelected);
  }

  final BookRepository _bookRepository;
  StreamSubscription<AppResult<List<Book>>>? _subscription;
  String? _selectedBookId;

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
          emit(const CaptureEmpty());
          return;
        }
        final hasSelection = data.any((book) => book.id == _selectedBookId);
        final selectedBookId = hasSelection ? _selectedBookId! : data.first.id;
        _selectedBookId = selectedBookId;
        emit(CaptureReady(books: data, selectedBookId: selectedBookId));
    }
  }

  void _onBookSelected(CaptureBookSelected event, Emitter<CaptureState> emit) {
    _selectedBookId = event.bookId;
    final currentState = state;
    if (currentState is! CaptureReady) return;
    if (!currentState.books.any((book) => book.id == event.bookId)) return;
    emit(CaptureReady(books: currentState.books, selectedBookId: event.bookId));
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
