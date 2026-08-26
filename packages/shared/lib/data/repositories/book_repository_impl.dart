import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
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
    } on DioException {
      return const Failure(ConnectionError());
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
      await _localDataSource.upsertBook(book.toLocalBook());
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
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
}
