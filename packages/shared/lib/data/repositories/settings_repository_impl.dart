import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/settings_local_data_source.dart';
import 'package:shared/data/mappers/user_settings_mappers.dart';
import 'package:shared/domain/entities/user_settings.dart';
import 'package:shared/domain/repositories/settings_repository.dart';

@Injectable(as: SettingsRepository)
class const SettingsRepositoryImpl(
  final SettingsLocalDataSource _localDataSource,
) implements SettingsRepository {
  @override
  Stream<AppResult<UserSettings>> watchSettings() async* {
    try {
      yield* _localDataSource.watchSettings().map<AppResult<UserSettings>>(
        (row) => Success(row?.toUserSettings() ?? defaultUserSettings),
      );
    } on Object {
      yield const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> setDisplayName(String? name) =>
      _update((current) => current.copyWith(displayName: name));

  @override
  Future<AppResult<()>> setLocalePreference(LocalePreference preference) =>
      _update((current) => current.copyWith(localePreference: preference));

  @override
  Future<AppResult<()>> setThemePreference(ThemePreference preference) =>
      _update((current) => current.copyWith(themePreference: preference));

  @override
  Future<AppResult<()>> setContrastPreference(ContrastPreference preference) =>
      _update((current) => current.copyWith(contrastPreference: preference));

  Future<AppResult<()>> _update(UserSettings Function(UserSettings current) change) async {
    try {
      final row = await _localDataSource.readSettings();
      final current = row?.toUserSettings() ?? defaultUserSettings;
      await _localDataSource.upsertSettings(change(current).toLocalSettings());
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }
}
