import 'package:core/error/app_result.dart';
import 'package:core/theme/accent_color.dart';
import 'package:feature_themes/presentation/theme_detail/theme_detail_state.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/entities/mark_theme.dart';

sealed class ThemeDetailEvent {
  const ThemeDetailEvent();
}

class const ThemeDetailStarted() extends ThemeDetailEvent;

class const ThemeDetailThemesUpdated(final AppResult<List<MarkTheme>> result)
    extends ThemeDetailEvent;

class const ThemeDetailMembershipUpdated(final AppResult<Map<String, Set<String>>> result)
    extends ThemeDetailEvent;

class const ThemeDetailBookmarksUpdated(final AppResult<List<Bookmark>> result)
    extends ThemeDetailEvent;

class const ThemeDetailBooksUpdated(final AppResult<List<Book>> result) extends ThemeDetailEvent;

class const ThemeDetailFilterChanged(final ThemeDetailFilter filter) extends ThemeDetailEvent;

class const ThemeDetailMarkToggled(final String bookmarkId) extends ThemeDetailEvent;

class const ThemeDetailRenameRequested(final String name) extends ThemeDetailEvent;

class const ThemeDetailAccentChanged(final AccentColor? accent) extends ThemeDetailEvent;

class const ThemeDetailDeleteRequested() extends ThemeDetailEvent;
