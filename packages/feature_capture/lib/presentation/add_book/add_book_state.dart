import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';

sealed class AddBookState {
  const AddBookState();
}

class const AddBookInitial() extends AddBookState;

class const AddBookLoading() extends AddBookState;

class const AddBookResults({
  required final List<Book> books,
}) extends AddBookState;

class const AddBookEmpty() extends AddBookState;

class const AddBookFailure({
  required final AppError error,
}) extends AddBookState;

class const AddBookSaved({
  required final String bookId,
}) extends AddBookState;
