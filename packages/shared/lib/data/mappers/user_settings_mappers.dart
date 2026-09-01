import 'package:shared/data/database/app_database.dart';
import 'package:shared/domain/entities/user_settings.dart';

const _settingsRowId = 0;
const _localeSystem = "system";
const _localeEnglish = "english";
const _localeGerman = "german";
const _themeSystem = "system";
const _themeLight = "light";
const _themeDark = "dark";
const _contrastSystem = "system";
const _contrastStandard = "standard";
const _contrastHigh = "high";

extension LocalSettingsMappers on LocalSettings {
  UserSettings toUserSettings() {
    return UserSettings(
      displayName: displayName,
      localePreference: localePreference.toLocalePreference(),
      themePreference: themePreference.toThemePreference(),
      contrastPreference: contrastPreference.toContrastPreference(),
    );
  }
}

extension UserSettingsMappers on UserSettings {
  LocalSettings toLocalSettings() {
    return LocalSettings(
      id: _settingsRowId,
      displayName: displayName,
      localePreference: localePreference.value,
      themePreference: themePreference.value,
      contrastPreference: contrastPreference.value,
    );
  }
}

extension LocalePreferenceValueMappers on String? {
  LocalePreference toLocalePreference() => switch (this) {
    _localeEnglish => LocalePreference.english,
    _localeGerman => LocalePreference.german,
    _ => LocalePreference.system,
  };

  ThemePreference toThemePreference() => switch (this) {
    _themeLight => ThemePreference.light,
    _themeDark => ThemePreference.dark,
    _ => ThemePreference.system,
  };

  ContrastPreference toContrastPreference() => switch (this) {
    _contrastStandard => ContrastPreference.standard,
    _contrastHigh => ContrastPreference.high,
    _ => ContrastPreference.system,
  };
}

extension LocalePreferenceMappers on LocalePreference {
  String get value => switch (this) {
    LocalePreference.system => _localeSystem,
    LocalePreference.english => _localeEnglish,
    LocalePreference.german => _localeGerman,
  };
}

extension ThemePreferenceMappers on ThemePreference {
  String get value => switch (this) {
    ThemePreference.system => _themeSystem,
    ThemePreference.light => _themeLight,
    ThemePreference.dark => _themeDark,
  };
}

extension ContrastPreferenceMappers on ContrastPreference {
  String get value => switch (this) {
    ContrastPreference.system => _contrastSystem,
    ContrastPreference.standard => _contrastStandard,
    ContrastPreference.high => _contrastHigh,
  };
}
