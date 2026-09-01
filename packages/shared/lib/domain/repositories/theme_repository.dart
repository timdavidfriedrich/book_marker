import 'package:core/error/app_result.dart';
import 'package:core/theme/accent_color.dart';
import 'package:core/theme/collection_symbol.dart';
import 'package:shared/domain/entities/quote_theme.dart';

abstract class ThemeRepository {
  Stream<AppResult<List<QuoteTheme>>> watchThemes();

  Stream<AppResult<Map<String, Set<String>>>> watchThemeMembership();

  Future<AppResult<QuoteTheme>> createTheme(String name);

  Future<AppResult<()>> renameTheme(String id, String name);

  Future<AppResult<()>> setThemeAccent(String id, AccentColor accent);

  Future<AppResult<()>> setThemeSymbol(String id, CollectionSymbol symbol);

  Future<AppResult<()>> deleteTheme(String id);

  Future<AppResult<()>> addQuoteToTheme({required String themeId, required String quoteId});

  Future<AppResult<()>> removeQuoteFromTheme({required String themeId, required String quoteId});
}
