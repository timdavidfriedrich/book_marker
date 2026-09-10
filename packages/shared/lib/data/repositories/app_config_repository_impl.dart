import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/app_config_local_data_source.dart';
import 'package:shared/data/data_sources/app_config_remote_data_source.dart';
import 'package:shared/data/mappers/app_config_mappers.dart';
import 'package:shared/domain/entities/app_config.dart';
import 'package:shared/domain/repositories/app_config_repository.dart';

@Injectable(as: AppConfigRepository)
class const AppConfigRepositoryImpl(
  final AppConfigRemoteDataSource _remoteDataSource,
  final AppConfigLocalDataSource _localDataSource,
) implements AppConfigRepository {
  @override
  Stream<AppResult<AppConfig>> watchConfig() async* {
    try {
      yield* _localDataSource.watchCache().map<AppResult<AppConfig>>(
        (row) => Success(row?.toAppConfig() ?? defaultAppConfig),
      );
    } on Object {
      yield const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<AppConfig>> refresh() async {
    try {
      final remote = await _remoteDataSource.fetchConfig();
      await _localDataSource.upsertCache(remote.toLocalAppConfigCache(DateTime.now()));
      return Success(remote.toAppConfig());
    } on Object {
      // * never surfaced: a refresh that cannot reach the server leaves the
      // * cached values in place, and those are only ever used for display
      return const Failure(ConnectionError());
    }
  }
}
