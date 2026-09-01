import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/book.dart';

abstract class BookRepository {
  Stream<AppResult<List<Book>>> watchBooks();

  Future<AppResult<List<Book>>> searchBooks(String query);

  Future<AppResult<Book>> getBook(String id);

  Future<AppResult<()>> saveBook(Book book);

  Future<AppResult<()>> cacheBookCovers();

  Future<AppResult<()>> markBookUsed(String id);

  Future<AppResult<()>> setStatus(String id, BookStatus status);

  Future<AppResult<()>> deleteBook(String id);
}
