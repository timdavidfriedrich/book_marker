import 'package:core/error/app_result.dart';
import 'package:feature_library/presentation/library/library_state.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';

sealed class LibraryEvent {
  const LibraryEvent();
}

class const LibraryStarted() extends LibraryEvent;

class const LibraryBookmarksUpdated(final AppResult<List<Bookmark>> result) extends LibraryEvent;

class const LibraryBooksUpdated(final AppResult<List<Book>> result) extends LibraryEvent;

class const LibraryViewChanged(final LibraryView view) extends LibraryEvent;

class const LibraryFilterChanged(final LibraryFilter filter) extends LibraryEvent;

class const LibraryQueryChanged(final String query) extends LibraryEvent;

class const LibrarySearchScopeChanged(final LibrarySearchScope scope) extends LibraryEvent;
