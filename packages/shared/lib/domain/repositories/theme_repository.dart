import 'package:core/error/app_result.dart';
import 'package:core/theme/accent_color.dart';
import 'package:shared/domain/entities/mark_theme.dart';

abstract class ThemeRepository {
  Stream<AppResult<List<MarkTheme>>> watchThemes();

  Stream<AppResult<Map<String, Set<String>>>> watchThemeMembership();

  Future<AppResult<MarkTheme>> createTheme(String name);

  Future<AppResult<()>> renameTheme(String id, String name);

  Future<AppResult<()>> setThemeAccent(String id, AccentColor? accent);

  Future<AppResult<()>> deleteTheme(String id);

  Future<AppResult<()>> addMarkToTheme({required String themeId, required String bookmarkId});

  Future<AppResult<()>> removeMarkFromTheme({required String themeId, required String bookmarkId});
}
