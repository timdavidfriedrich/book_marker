import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/book_cover_data_source.dart';
import 'package:shared/data/data_sources/book_local_data_source.dart';
import 'package:shared/data/data_sources/book_remote_data_source.dart';
import 'package:shared/data/mappers/book_mappers.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

@Injectable(as: BookRepository)
class const BookRepositoryImpl(
  final BookLocalDataSource _localDataSource,
  final BookRemoteDataSource _remoteDataSource,
  final BookCoverDataSource _coverDataSource,
) implements BookRepository {
  @override
  Stream<AppResult<List<Book>>> watchBooks() async* {
    try {
      yield* _localDataSource.watchBooks().map<AppResult<List<Book>>>(
        (rows) => Success(rows.map((it) => it.toBook()).toList()),
      );
    } on Object {
      yield const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<List<Book>>> searchBooks(String query) async {
    try {
      final timestamp = DateTime.now().toUtc();
      final remoteBooks = await _remoteDataSource.searchBooks(query);
      return Success(
        remoteBooks.map((it) => it.toBook(id: _uuid.v4(), timestamp: timestamp)).toList(),
      );
    } on DioException catch (exception) {
      final response = exception.response;
      if (response != null) {
        return Failure(ApiError(_serverMessage(response)));
      }
      return const Failure(ConnectionError());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  String _serverMessage(Response<dynamic> response) {
    final data = response.data;
    if (data is Map && data["error"] is Map && (data["error"] as Map)["message"] is String) {
      return (data["error"] as Map)["message"] as String;
    }
    return "HTTP ${response.statusCode}";
  }

  @override
  Future<AppResult<Book>> getBook(String id) async {
    try {
      final localBook = await _localDataSource.readBook(id);
      if (localBook == null) return const Failure(NotFoundError());
      return Success(localBook.toBook());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> saveBook(Book book) async {
    try {
      await _localDataSource.upsertBook((await _withCover(book)).toLocalBook());
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> cacheBookCovers() async {
    try {
      for (final row in await _localDataSource.readBooks()) {
        final book = row.toBook();
        final cached = await _withCover(book);
        if (cached.coverPath != book.coverPath) {
          await _localDataSource.upsertBook(cached.toLocalBook());
        }
      }
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  // * a cover that failed to download stays absent instead of failing the whole write
  Future<Book> _withCover(Book book) async {
    if (book.thumbnailUrl case final url?) {
      if (await _hasCoverFile(book)) return book;
      try {
        return book.copyWith(
          coverPath: await _coverDataSource.downloadCover(url: url, bookId: book.id),
        );
      } on Object {
        return book;
      }
    }
    return book;
  }

  Future<bool> _hasCoverFile(Book book) async {
    if (book.coverPath case final path?) return _coverDataSource.hasCover(path);
    return false;
  }

  @override
  Future<AppResult<()>> markBookUsed(String id) async {
    try {
      await _localDataSource.touchBook(id, DateTime.now().toUtc());
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> setStatus(String id, BookStatus status) async {
    try {
      await _localDataSource.setStatus(id, status.value);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> deleteBook(String id) async {
    try {
      if (await _localDataSource.readBook(id) case final row?) {
        if (row.coverPath case final path?) await _coverDataSource.deleteCover(path);
      }
      await _localDataSource.deleteBook(id);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }
}
