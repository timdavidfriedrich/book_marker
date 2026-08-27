import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';

enum LibraryView { books, shelves }

enum LibraryFilter { all, reading, finished }

enum LibrarySearchScope { allBooks, starred, myNotes }

class const LibraryBookSummary({
  required final Book book,
  required final int markCount,
  required final int starredCount,
  required final Bookmark? featuredMark,
});

class const LibraryMarkResult({
  required final Bookmark mark,
  required final Book book,
});

sealed class LibraryState {
  const LibraryState();
}

class const LibraryLoading() extends LibraryState;

class const LibraryLoaded({
  required final List<LibraryBookSummary> books,
  required final int totalBooks,
  required final int totalMarks,
  required final int readingCount,
  required final int finishedCount,
  required final LibraryView view,
  required final LibraryFilter filter,
  required final String query,
  required final LibrarySearchScope searchScope,
  required final List<LibraryMarkResult> results,
}) extends LibraryState {
  bool get isSearching =>
      query.trim().isNotEmpty || searchScope != LibrarySearchScope.allBooks;
}

class const LibraryFailure({
  required final AppError error,
}) extends LibraryState;
