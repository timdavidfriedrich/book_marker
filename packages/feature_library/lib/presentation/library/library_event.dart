import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';

sealed class LibraryEvent {
  const LibraryEvent();
}

class const LibraryStarted() extends LibraryEvent;

class const LibraryBookmarksUpdated(
  final AppResult<List<Bookmark>> result,
) extends LibraryEvent;

class const LibraryBooksUpdated(
  final AppResult<List<Book>> result,
) extends LibraryEvent;
