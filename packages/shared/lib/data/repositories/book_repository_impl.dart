import 'package:core/config/build_config.dart';
import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/book_cover_data_source.dart';
import 'package:shared/data/data_sources/book_local_data_source.dart';
import 'package:shared/data/data_sources/google_books_data_source.dart';
import 'package:shared/data/data_sources/open_library_data_source.dart';
import 'package:shared/data/mappers/book_mappers.dart';
import 'package:shared/data/models/remote_google_book.dart';
import 'package:shared/data/models/remote_open_library_book.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/repositories/book_repository.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
const _tooManyRequests = 429;
const _forbidden = 403;
const _notFound = 404;
const _firstServerErrorCode = 500;
const _quotaReasons = ["quota", "ratelimit"];
const _missingKeyMessage =
    "GOOGLE_BOOKS_API_KEY is missing, searching Open Library instead. "
    "Launch with --dart-define-from-file=dart_defines.json to use Google Books.";

extension _RemoteGoogleBookListMappers on List<RemoteGoogleBook> {
  List<Book> toBooks(DateTime timestamp) => [
    for (final remoteBook in this)
      if (remoteBook.volumeInfo?.title case final String title when title.isNotEmpty)
        remoteBook.toBook(id: _uuid.v4(), timestamp: timestamp),
  ];
}

extension _RemoteOpenLibraryBookListMappers on List<RemoteOpenLibraryBook> {
  List<Book> toBooks(DateTime timestamp) => [
    for (final remoteBook in this)
      if (remoteBook.title case final String title when title.isNotEmpty)
        remoteBook.toBook(id: _uuid.v4(), timestamp: timestamp),
  ];
}

// * the catalogue answers a spent quota with either status, and the reason only shows in the body
AppError _toAppError(DioException exception) {
  final response = exception.response;
  if (response == null) return const ConnectionError();
  final status = response.statusCode ?? 0;
  if (status == _tooManyRequests || (status == _forbidden && _isQuotaFailure(response))) {
    return const RateLimitError();
  }
  if (status >= _firstServerErrorCode) return const ServiceUnavailableError();
  if (status == _notFound) return const NotFoundError();
  return ApiError(_serverMessage(response));
}

bool _isQuotaFailure(Response<dynamic> response) {
  final data = response.data;
  if (data is! Map) return false;
  final error = data["error"];
  if (error is! Map) return false;
  final errors = error["errors"];
  if (errors is! List) return false;
  return errors.any(
    (it) =>
        it is Map &&
        _quotaReasons.any(
          (reason) => (it["reason"] as String?)?.toLowerCase().contains(reason) ?? false,
        ),
  );
}

String _serverMessage(Response<dynamic> response) {
  final data = response.data;
  if (data is Map && data["error"] is Map && (data["error"] as Map)["message"] is String) {
    return (data["error"] as Map)["message"] as String;
  }
  return "HTTP ${response.statusCode}";
}

@Injectable(as: BookRepository)
class const BookRepositoryImpl(
  final BookLocalDataSource _localDataSource,
  final GoogleBooksDataSource _googleBooksDataSource,
  final OpenLibraryDataSource _openLibraryDataSource,
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
    final trimmed = query.trim();
    final timestamp = DateTime.now().toUtc();
    // * without a key Google bills the call to its shared anonymous project, whose daily quota is
    // * permanently spent, so the request could only ever come back as a rate limit failure
    if (googleBooksApiKey.isEmpty) {
      if (isInDebugMode) debugPrint(_missingKeyMessage);
      return _searchOpenLibrary(trimmed, timestamp);
    }
    try {
      final remoteBooks = await _googleBooksDataSource.searchBooks(trimmed);
      final books = remoteBooks.toBooks(timestamp);
      if (books.isNotEmpty) return Success(books);
    } on DioException catch (exception) {
      // * the fallback is only ever additive, so a catalogue outage still has to reach the user
      final fallback = await _searchOpenLibrary(trimmed, timestamp);
      if (fallback case Success(data: final books) when books.isNotEmpty) return fallback;
      return Failure(_toAppError(exception));
    } on Object {
      return const Failure(UnexpectedError());
    }
    return _searchOpenLibrary(trimmed, timestamp);
  }

  Future<AppResult<List<Book>>> _searchOpenLibrary(String query, DateTime timestamp) async {
    try {
      final remoteBooks = await _openLibraryDataSource.searchBooks(query);
      return Success(remoteBooks.toBooks(timestamp));
    } on DioException catch (exception) {
      return Failure(_toAppError(exception));
    } on Object {
      return const Failure(UnexpectedError());
    }
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
