import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/bookmark_local_data_source.dart';
import 'package:shared/data/data_sources/image_storage_data_source.dart';
import 'package:shared/data/mappers/bookmark_mappers.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/repositories/bookmark_repository.dart';

@Injectable(as: BookmarkRepository)
class const BookmarkRepositoryImpl(
  final BookmarkLocalDataSource _localDataSource,
  final ImageStorageDataSource _imageStorageDataSource,
) implements BookmarkRepository {
  @override
  Stream<AppResult<List<Bookmark>>> watchBookmarks() async* {
    try {
      yield* _localDataSource.watchBookmarks().map<AppResult<List<Bookmark>>>(
        (rows) => Success(rows.map((it) => it.toBookmark()).toList()),
      );
    } on Object {
      yield const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<Bookmark>> getBookmark(String id) async {
    try {
      final localBookmark = await _localDataSource.readBookmark(id);
      if (localBookmark == null) return const Failure(NotFoundError());
      return Success(localBookmark.toBookmark());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> saveBookmark(Bookmark bookmark) async {
    try {
      final storedPath = await _imageStorageDataSource.persistImage(
        bookmark.photoPath,
        bookmark.id,
      );
      final storedBookmark = bookmark.copyWith(photoPath: storedPath);
      await _localDataSource.insertBookmark(storedBookmark.toLocalBookmark());
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> setFavorite(String id, {required bool isFavorite}) async {
    try {
      await _localDataSource.setFavorite(id, isFavorite: isFavorite);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }
}
