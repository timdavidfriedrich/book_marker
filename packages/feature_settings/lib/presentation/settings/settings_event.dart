import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/quote_theme.dart';
import 'package:shared/domain/entities/user_settings.dart';

sealed class SettingsEvent {
  const SettingsEvent();
}

class const SettingsStarted() extends SettingsEvent;

class const SettingsSettingsUpdated(final AppResult<UserSettings> result) extends SettingsEvent;

class const SettingsBooksUpdated(final AppResult<List<Book>> result) extends SettingsEvent;

class const SettingsQuotesUpdated(final AppResult<List<Quote>> result) extends SettingsEvent;

class const SettingsThemesUpdated(final AppResult<List<QuoteTheme>> result) extends SettingsEvent;

class const SettingsNameChanged(final String? name) extends SettingsEvent;

class const SettingsLocaleChanged(final LocalePreference preference) extends SettingsEvent;

class const SettingsThemeChanged(final ThemePreference preference) extends SettingsEvent;

class const SettingsContrastChanged(final ContrastPreference preference) extends SettingsEvent;

class const SettingsSampleDataUpdated(final bool hasSampleData) extends SettingsEvent;

class const SettingsSampleDataRequested() extends SettingsEvent;
