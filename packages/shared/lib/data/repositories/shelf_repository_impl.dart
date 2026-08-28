import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:core/theme/accent_color.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/shelf_local_data_source.dart';
import 'package:shared/data/mappers/accent_mappers.dart';
import 'package:shared/data/mappers/shelf_mappers.dart';
import 'package:shared/domain/entities/shelf.dart';
import 'package:shared/domain/repositories/shelf_repository.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

@Injectable(as: ShelfRepository)
class const ShelfRepositoryImpl(
  final ShelfLocalDataSource _localDataSource,
) implements ShelfRepository {
  @override
  Stream<AppResult<List<Shelf>>> watchShelves() async* {
    try {
      yield* _localDataSource.watchShelves().map<AppResult<List<Shelf>>>(
        (rows) => Success(rows.map((it) => it.toShelf()).toList()),
      );
    } on Object {
      yield const Failure(UnexpectedError());
    }
  }

  @override
  Stream<AppResult<Map<String, Set<String>>>> watchShelfMembership() async* {
    try {
      yield* _localDataSource.watchShelfBooks().map<AppResult<Map<String, Set<String>>>>((rows) {
        final membership = <String, Set<String>>{};
        for (final row in rows) {
          membership.putIfAbsent(row.shelfId, () => <String>{}).add(row.bookId);
        }
        return Success(membership);
      });
    } on Object {
      yield const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<Shelf>> createShelf(String name) async {
    try {
      final shelf = Shelf(id: _uuid.v4(), name: name, createdAt: DateTime.now().toUtc());
      await _localDataSource.upsertShelf(shelf.toLocalShelf());
      return Success(shelf);
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> renameShelf(String id, String name) async {
    try {
      await _localDataSource.renameShelf(id, name);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> setShelfAccent(String id, AccentColor? accent) async {
    try {
      await _localDataSource.setAccent(id, accent?.value);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> deleteShelf(String id) async {
    try {
      await _localDataSource.deleteShelf(id);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> addBookToShelf({required String shelfId, required String bookId}) async {
    try {
      await _localDataSource.addBook(shelfId, bookId);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> removeBookFromShelf({
    required String shelfId,
    required String bookId,
  }) async {
    try {
      await _localDataSource.removeBook(shelfId, bookId);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }
}
