import 'package:shared/data/database/app_database.dart';
import 'package:shared/domain/entities/user_settings.dart';

const _settingsRowId = 0;
const _localeSystem = "system";
const _localeEnglish = "english";
const _localeGerman = "german";

extension LocalSettingsMappers on LocalSettings {
  UserSettings toUserSettings() {
    return UserSettings(
      displayName: displayName,
      localePreference: localePreference.toLocalePreference(),
    );
  }
}

extension UserSettingsMappers on UserSettings {
  LocalSettings toLocalSettings() {
    return LocalSettings(
      id: _settingsRowId,
      displayName: displayName,
      localePreference: localePreference.value,
    );
  }
}

extension LocalePreferenceValueMappers on String? {
  LocalePreference toLocalePreference() => switch (this) {
    _localeEnglish => LocalePreference.english,
    _localeGerman => LocalePreference.german,
    _ => LocalePreference.system,
  };
}

extension LocalePreferenceMappers on LocalePreference {
  String get value => switch (this) {
    LocalePreference.system => _localeSystem,
    LocalePreference.english => _localeEnglish,
    LocalePreference.german => _localeGerman,
  };
}
