import 'package:core/theme/mark_defaults.dart';
import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/mappers/accent_mappers.dart';
import 'package:shared/data/mappers/collection_symbol_mappers.dart';
import 'package:shared/domain/entities/quote_theme.dart';

extension LocalThemeMappers on LocalTheme {
  QuoteTheme toQuoteTheme() {
    return QuoteTheme(
      id: id,
      name: name,
      createdAt: createdAt,
      accent: accent?.toAccentColor() ?? MarkDefaults.accentForKey(id),
      symbol: symbol?.toCollectionSymbol() ?? MarkDefaults.symbolForKey(id),
    );
  }
}

extension QuoteThemeMappers on QuoteTheme {
  LocalTheme toLocalTheme() {
    return LocalTheme(
      id: id,
      name: name,
      createdAt: createdAt,
      accent: accent.value,
      symbol: symbol.value,
    );
  }
}
