import 'package:core/theme/collection_symbol.dart';

extension CollectionSymbolValueMappers on String {
  CollectionSymbol? toCollectionSymbol() => CollectionSymbol.values.asNameMap()[this];
}

extension CollectionSymbolMappers on CollectionSymbol {
  String get value => name;
}
