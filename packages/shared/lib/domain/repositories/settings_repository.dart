import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/user_settings.dart';

abstract class SettingsRepository {
  Stream<AppResult<UserSettings>> watchSettings();

  Future<AppResult<()>> setDisplayName(String? name);

  Future<AppResult<()>> setLocalePreference(LocalePreference preference);
}
