import 'package:shared/domain/entities/book.dart';

sealed class AddBookEvent {
  const AddBookEvent();
}

class const AddBookSearched(
  final String query,
) extends AddBookEvent;

class const AddBookSelected(
  final Book book,
) extends AddBookEvent;
