import 'package:dart_mappable/dart_mappable.dart';

part 'user_settings.mapper.dart';

@MappableEnum()
enum LocalePreference { system, english, german }

@MappableClass()
class const UserSettings({
  required final String? displayName,
  required final LocalePreference localePreference,
}) with UserSettingsMappable;
