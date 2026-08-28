import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/mark_theme.dart';

class const ThemeSummary({
  required final MarkTheme theme,
  required final int markCount,
  required final int bookCount,
});

sealed class ThemesState {
  const ThemesState();
}

class const ThemesLoading() extends ThemesState;

class const ThemesLoaded({
  required final List<ThemeSummary> themes,
  required final int totalMarks,
  required final int totalBooks,
}) extends ThemesState;

class const ThemesFailure({
  required final AppError error,
}) extends ThemesState;
