import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';

sealed class LibraryState {
  const LibraryState();
}

class const LibraryLoading() extends LibraryState;

class const LibraryEmpty() extends LibraryState;

class const LibraryLoaded({
  required final List<Bookmark> bookmarks,
  required final Map<String, Book> booksById,
}) extends LibraryState;

class const LibraryFailure({
  required final AppError error,
}) extends LibraryState;
