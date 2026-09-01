import 'package:core/error/app_result.dart';
import 'package:core/theme/accent_color.dart';
import 'package:core/theme/collection_symbol.dart';
import 'package:shared/domain/entities/shelf.dart';

abstract class ShelfRepository {
  Stream<AppResult<List<Shelf>>> watchShelves();

  Stream<AppResult<Map<String, Set<String>>>> watchShelfMembership();

  Future<AppResult<Shelf>> createShelf(String name);

  Future<AppResult<()>> renameShelf(String id, String name);

  Future<AppResult<()>> setShelfAccent(String id, AccentColor accent);

  Future<AppResult<()>> setShelfSymbol(String id, CollectionSymbol symbol);

  Future<AppResult<()>> deleteShelf(String id);

  Future<AppResult<()>> addBookToShelf({required String shelfId, required String bookId});

  Future<AppResult<()>> removeBookFromShelf({required String shelfId, required String bookId});
}
