import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/book.dart';

sealed class AddBookEvent {
  const AddBookEvent();
}

class const AddBookStarted() extends AddBookEvent;

class const AddBookBooksUpdated(final AppResult<List<Book>> result) extends AddBookEvent;

class const AddBookQueryChanged(final String query) extends AddBookEvent;

class const AddBookCatalogueRequested() extends AddBookEvent;

class const AddBookCatalogueSelected(final Book book) extends AddBookEvent;
