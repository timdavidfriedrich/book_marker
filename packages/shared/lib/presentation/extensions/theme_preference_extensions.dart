import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/user_settings.dart';

extension ThemePreferenceExtensions on ThemePreference {
  ThemeMode toThemeMode() => switch (this) {
    ThemePreference.system => ThemeMode.system,
    ThemePreference.light => ThemeMode.light,
    ThemePreference.dark => ThemeMode.dark,
  };
}

extension ContrastPreferenceExtensions on ContrastPreference {
  ContrastLevel? toContrastLevel() => switch (this) {
    ContrastPreference.system => null,
    ContrastPreference.standard => ContrastLevel.standard,
    ContrastPreference.high => ContrastLevel.high,
  };
}
