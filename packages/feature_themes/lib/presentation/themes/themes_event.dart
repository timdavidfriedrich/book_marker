import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/entities/mark_theme.dart';

sealed class ThemesEvent {
  const ThemesEvent();
}

class const ThemesStarted() extends ThemesEvent;

class const ThemesThemesUpdated(final AppResult<List<MarkTheme>> result) extends ThemesEvent;

class const ThemesMembershipUpdated(final AppResult<Map<String, Set<String>>> result)
    extends ThemesEvent;

class const ThemesBookmarksUpdated(final AppResult<List<Bookmark>> result) extends ThemesEvent;

class const ThemesCreateRequested(final String name) extends ThemesEvent;
