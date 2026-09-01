import 'package:dart_mappable/dart_mappable.dart';

part 'user_settings.mapper.dart';

@MappableEnum()
enum LocalePreference { system, english, german }

@MappableEnum()
enum ThemePreference { system, light, dark }

@MappableEnum()
enum ContrastPreference { system, standard, high }

@MappableClass()
class const UserSettings({
  required final String? displayName,
  required final LocalePreference localePreference,
  required final ThemePreference themePreference,
  required final ContrastPreference contrastPreference,
}) with UserSettingsMappable;

const defaultUserSettings = UserSettings(
  displayName: null,
  localePreference: LocalePreference.system,
  themePreference: ThemePreference.system,
  contrastPreference: ContrastPreference.system,
);
