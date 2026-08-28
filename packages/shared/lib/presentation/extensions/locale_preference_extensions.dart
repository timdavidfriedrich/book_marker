import 'package:flutter/widgets.dart';
import 'package:shared/domain/entities/user_settings.dart';

const _englishLocale = Locale("en");
const _germanLocale = Locale("de");

extension LocalePreferenceExtensions on LocalePreference {
  Locale? toLocale() => switch (this) {
    LocalePreference.system => null,
    LocalePreference.english => _englishLocale,
    LocalePreference.german => _germanLocale,
  };
}
