import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/entities/mark_theme.dart';

enum ThemeDetailFilter { all, starred }

class const ThemeMarkItem({
  required final Bookmark mark,
  required final Book book,
});

sealed class ThemeDetailState {
  const ThemeDetailState();
}

class const ThemeDetailLoading() extends ThemeDetailState;

class const ThemeDetailLoaded({
  required final MarkTheme theme,
  required final List<ThemeMarkItem> marks,
  required final List<ThemeMarkItem> allMarks,
  required final Set<String> memberIds,
  required final int totalCount,
  required final int starredCount,
  required final int bookCount,
  required final ThemeDetailFilter filter,
}) extends ThemeDetailState;

class const ThemeDetailFailure({
  required final AppError error,
}) extends ThemeDetailState;

class const ThemeDetailDeleted() extends ThemeDetailState;
