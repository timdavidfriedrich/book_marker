import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/settings_local_data_source.dart';
import 'package:shared/data/mappers/user_settings_mappers.dart';
import 'package:shared/domain/entities/user_settings.dart';
import 'package:shared/domain/repositories/settings_repository.dart';

const _defaultSettings = UserSettings(
  displayName: null,
  localePreference: LocalePreference.system,
);

@Injectable(as: SettingsRepository)
class const SettingsRepositoryImpl(
  final SettingsLocalDataSource _localDataSource,
) implements SettingsRepository {
  @override
  Stream<AppResult<UserSettings>> watchSettings() async* {
    try {
      yield* _localDataSource.watchSettings().map<AppResult<UserSettings>>(
        (row) => Success(row?.toUserSettings() ?? _defaultSettings),
      );
    } on Object {
      yield const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> setDisplayName(String? name) async {
    try {
      final current = await _currentSettings();
      await _localDataSource.upsertSettings(
        UserSettings(
          displayName: name,
          localePreference: current.localePreference,
        ).toLocalSettings(),
      );
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> setLocalePreference(LocalePreference preference) async {
    try {
      final current = await _currentSettings();
      await _localDataSource.upsertSettings(
        UserSettings(
          displayName: current.displayName,
          localePreference: preference,
        ).toLocalSettings(),
      );
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  Future<UserSettings> _currentSettings() async {
    final row = await _localDataSource.readSettings();
    return row?.toUserSettings() ?? _defaultSettings;
  }
}
