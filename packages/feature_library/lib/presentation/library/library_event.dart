import 'package:core/error/app_result.dart';
import 'package:feature_library/presentation/library/library_state.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/shelf.dart';

sealed class LibraryEvent {
  const LibraryEvent();
}

class const LibraryStarted() extends LibraryEvent;

class const LibraryQuotesUpdated(final AppResult<List<Quote>> result) extends LibraryEvent;

class const LibraryBooksUpdated(final AppResult<List<Book>> result) extends LibraryEvent;

class const LibraryViewChanged(final LibraryView view) extends LibraryEvent;

class const LibraryFilterChanged(final LibraryFilter filter) extends LibraryEvent;

class const LibraryQueryChanged(final String query) extends LibraryEvent;

class const LibrarySearchScopeChanged(final LibrarySearchScope scope) extends LibraryEvent;

class const LibraryShelvesUpdated(final AppResult<List<Shelf>> result) extends LibraryEvent;

class const LibraryShelfMembershipUpdated(final AppResult<Map<String, Set<String>>> result)
    extends LibraryEvent;

class const LibraryShelfCreateRequested(final String name) extends LibraryEvent;
