import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/user_settings.dart';
import 'package:shared/domain/repositories/settings_repository.dart';

@injectable
class AppSettingsCubit extends Cubit<UserSettings> {
  AppSettingsCubit(this._settingsRepository)
    : super(
        const UserSettings(displayName: null, localePreference: LocalePreference.system),
      );

  final SettingsRepository _settingsRepository;
  StreamSubscription<AppResult<UserSettings>>? _subscription;

  void start() {
    _subscription?.cancel();
    _subscription = _settingsRepository.watchSettings().listen((result) {
      if (result case Success(:final data)) emit(data);
    });
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
