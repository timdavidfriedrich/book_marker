import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/app_config.dart';
import 'package:shared/domain/repositories/app_config_repository.dart';

@injectable
class AppConfigCubit extends Cubit<AppConfig> {
  AppConfigCubit(this._appConfigRepository) : super(defaultAppConfig);

  final AppConfigRepository _appConfigRepository;
  StreamSubscription<AppResult<AppConfig>>? _subscription;

  void start() {
    _subscription?.cancel();
    _subscription = _appConfigRepository.watchConfig().listen((result) {
      if (result case Success(:final data)) emit(data);
    });
    // * fire and forget: the cached or compiled in values are already usable,
    // * so first paint must not wait for the server
    unawaited(_appConfigRepository.refresh());
  }

  Future<void> refresh() => _appConfigRepository.refresh();

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
