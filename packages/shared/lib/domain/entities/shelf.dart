import 'package:core/theme/accent_color.dart';
import 'package:core/theme/collection_symbol.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'shelf.mapper.dart';

@MappableClass()
class const Shelf({
  required final String id,
  required final String name,
  required final DateTime createdAt,
  required final AccentColor accent,
  required final CollectionSymbol symbol,
}) with ShelfMappable;
