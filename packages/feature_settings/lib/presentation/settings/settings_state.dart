import 'package:shared/domain/entities/user_settings.dart';

sealed class SettingsState {
  const SettingsState();
}

class const SettingsLoading() extends SettingsState;

class const SettingsLoaded({
  required final String? displayName,
  required final LocalePreference localePreference,
  required final int bookCount,
  required final int markCount,
  required final int themeCount,
}) extends SettingsState;
