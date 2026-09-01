import 'package:core/error/app_result.dart';
import 'package:core/theme/accent_color.dart';
import 'package:core/theme/collection_symbol.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/shelf.dart';

sealed class ShelfDetailEvent {
  const ShelfDetailEvent();
}

class const ShelfDetailStarted() extends ShelfDetailEvent;

class const ShelfDetailShelvesUpdated(final AppResult<List<Shelf>> result) extends ShelfDetailEvent;

class const ShelfDetailMembershipUpdated(final AppResult<Map<String, Set<String>>> result)
    extends ShelfDetailEvent;

class const ShelfDetailBooksUpdated(final AppResult<List<Book>> result) extends ShelfDetailEvent;

class const ShelfDetailQuotesUpdated(final AppResult<List<Quote>> result) extends ShelfDetailEvent;

class const ShelfDetailBookToggled(final String bookId) extends ShelfDetailEvent;

class const ShelfDetailRenameRequested(final String name) extends ShelfDetailEvent;

class const ShelfDetailAccentChanged(final AccentColor accent) extends ShelfDetailEvent;

class const ShelfDetailSymbolChanged(final CollectionSymbol symbol) extends ShelfDetailEvent;

class const ShelfDetailDeleteRequested() extends ShelfDetailEvent;
