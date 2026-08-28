import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/shelf.dart';

class const ShelfBookItem({
  required final Book book,
  required final int markCount,
});

sealed class ShelfDetailState {
  const ShelfDetailState();
}

class const ShelfDetailLoading() extends ShelfDetailState;

class const ShelfDetailLoaded({
  required final Shelf shelf,
  required final List<ShelfBookItem> books,
  required final List<ShelfBookItem> allBooks,
  required final Set<String> memberIds,
  required final int bookCount,
  required final int markCount,
}) extends ShelfDetailState;

class const ShelfDetailFailure({
  required final AppError error,
}) extends ShelfDetailState;

class const ShelfDetailDeleted() extends ShelfDetailState;
