import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/entitlement_remote_data_source.dart';
import 'package:shared/data/mappers/entitlement_mappers.dart';
import 'package:shared/data/models/remote_entitlement.dart';
import 'package:shared/domain/entities/account_entitlement.dart';
import 'package:shared/domain/entities/app_config.dart';
import 'package:shared/domain/repositories/app_config_repository.dart';
import 'package:shared/domain/repositories/entitlement_repository.dart';

@Injectable(as: EntitlementRepository)
class const EntitlementRepositoryImpl(
  final EntitlementRemoteDataSource _dataSource,
  final AppConfigRepository _appConfigRepository,
) implements EntitlementRepository {
  @override
  Future<AppResult<AccountEntitlement>> fetch() => _read(_dataSource.fetchEntitlement);

  @override
  Future<AppResult<AccountEntitlement>> registerBackup(String verifier) =>
      _read(() => _dataSource.registerBackup(verifier));

  // * which plan may sync files is a config fact, not a property of the plan
  // * name, so it is resolved here rather than repeated at every call site
  Future<bool> _attachmentsEnabled(String plan) async {
    final config = switch (await _appConfigRepository.watchConfig().first) {
      Success(:final data) => data,
      Failure() => defaultAppConfig,
    };
    return plan.toAccountPlan() == AccountPlan.premium
        ? config.premium.attachmentsEnabled
        : config.free.attachmentsEnabled;
  }

  Future<AppResult<AccountEntitlement>> _read(
    Future<RemoteEntitlement> Function() read,
  ) async {
    final RemoteEntitlement remote;
    try {
      remote = await read();
    } on Object {
      return const Failure(ConnectionError());
    }
    // * a separate try on purpose. The server has answered by this point, so a
    // * failure here is ours, and calling it a connection problem sends people
    // * to look at their wifi
    try {
      return Success(
        remote.toAccountEntitlement(
          attachmentsEnabled: await _attachmentsEnabled(remote.plan),
        ),
      );
    } on Object {
      return const Failure(UnexpectedError());
    }
  }
}
