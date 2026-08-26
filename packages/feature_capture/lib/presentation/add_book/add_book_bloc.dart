import 'package:core/error/app_result.dart';
import 'package:feature_capture/presentation/add_book/add_book_event.dart';
import 'package:feature_capture/presentation/add_book/add_book_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/repositories/book_repository.dart';

@injectable
class AddBookBloc extends Bloc<AddBookEvent, AddBookState> {
  AddBookBloc(this._bookRepository) : super(const AddBookInitial()) {
    on<AddBookSearched>(_onSearched);
    on<AddBookSelected>(_onSelected);
  }

  final BookRepository _bookRepository;

  Future<void> _onSearched(AddBookSearched event, Emitter<AddBookState> emit) async {
    if (event.query.trim().isEmpty) {
      emit(const AddBookInitial());
      return;
    }
    emit(const AddBookLoading());
    emit(switch (await _bookRepository.searchBooks(event.query)) {
      Success(:final data) when data.isEmpty => const AddBookEmpty(),
      Success(:final data) => AddBookResults(books: data),
      Failure(:final error) => AddBookFailure(error: error),
    });
  }

  Future<void> _onSelected(AddBookSelected event, Emitter<AddBookState> emit) async {
    emit(switch (await _bookRepository.saveBook(event.book)) {
      Success() => AddBookSaved(bookId: event.book.id),
      Failure(:final error) => AddBookFailure(error: error),
    });
  }
}
