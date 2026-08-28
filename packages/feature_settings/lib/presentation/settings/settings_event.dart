import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/domain/entities/mark_theme.dart';
import 'package:shared/domain/entities/user_settings.dart';

sealed class SettingsEvent {
  const SettingsEvent();
}

class const SettingsStarted() extends SettingsEvent;

class const SettingsSettingsUpdated(final AppResult<UserSettings> result) extends SettingsEvent;

class const SettingsBooksUpdated(final AppResult<List<Book>> result) extends SettingsEvent;

class const SettingsBookmarksUpdated(final AppResult<List<Bookmark>> result) extends SettingsEvent;

class const SettingsThemesUpdated(final AppResult<List<MarkTheme>> result) extends SettingsEvent;

class const SettingsNameChanged(final String? name) extends SettingsEvent;

class const SettingsLocaleChanged(final LocalePreference preference) extends SettingsEvent;
