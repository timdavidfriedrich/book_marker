import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';

sealed class AddBookState {
  const AddBookState();
}

class const AddBookLoaded({
  required final String query,
  required final List<Book> libraryMatches,
  required final List<Book> catalogueResults,
  required final bool isCatalogueLoading,
  required final AppError? catalogueError,
}) extends AddBookState;

class const AddBookSaved({
  required final String bookId,
}) extends AddBookState;
