import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/shelf.dart';

enum LibraryView { books, shelves }

enum LibraryFilter { all, reading, paused, finished }

enum LibrarySearchScope { allBooks, favorites, myNotes }

class const LibraryBookSummary({
  required final Book book,
  required final int quoteCount,
  required final int favoriteCount,
  required final Quote? featuredQuote,
});

class const LibraryQuoteResult({
  required final Quote quote,
  required final Book book,
});

class const LibraryShelfSummary({
  required final Shelf shelf,
  required final int bookCount,
  required final int quoteCount,
  required final List<Book> previewBooks,
});

sealed class LibraryState {
  const LibraryState();
}

class const LibraryLoading() extends LibraryState;

class const LibraryLoaded({
  required final List<LibraryBookSummary> books,
  required final int totalBooks,
  required final int totalQuotes,
  required final int readingCount,
  required final int pausedCount,
  required final int finishedCount,
  required final LibraryView view,
  required final LibraryFilter filter,
  required final String query,
  required final LibrarySearchScope searchScope,
  required final List<LibraryQuoteResult> results,
  required final List<LibraryShelfSummary> shelves,
}) extends LibraryState {
  bool get isSearching => query.trim().isNotEmpty || searchScope != LibrarySearchScope.allBooks;
}

class const LibraryFailure({
  required final AppError error,
}) extends LibraryState;
