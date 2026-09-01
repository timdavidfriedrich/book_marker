import 'package:core/theme/mark_defaults.dart';
import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/mappers/accent_mappers.dart';
import 'package:shared/data/mappers/collection_symbol_mappers.dart';
import 'package:shared/domain/entities/shelf.dart';

extension LocalShelfMappers on LocalShelf {
  Shelf toShelf() {
    return Shelf(
      id: id,
      name: name,
      createdAt: createdAt,
      accent: accent?.toAccentColor() ?? MarkDefaults.accentForKey(id),
      symbol: symbol?.toCollectionSymbol() ?? MarkDefaults.symbolForKey(id),
    );
  }
}

extension ShelfMappers on Shelf {
  LocalShelf toLocalShelf() {
    return LocalShelf(
      id: id,
      name: name,
      createdAt: createdAt,
      accent: accent.value,
      symbol: symbol.value,
    );
  }
}
