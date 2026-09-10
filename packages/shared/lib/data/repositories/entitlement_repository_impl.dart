import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/entitlement_remote_data_source.dart';
import 'package:shared/data/mappers/entitlement_mappers.dart';
import 'package:shared/data/models/remote_entitlement.dart';
import 'package:shared/domain/entities/account_entitlement.dart';
import 'package:shared/domain/repositories/entitlement_repository.dart';

@Injectable(as: EntitlementRepository)
class const EntitlementRepositoryImpl(
  final EntitlementRemoteDataSource _dataSource,
) implements EntitlementRepository {
  @override
  Future<AppResult<AccountEntitlement>> fetch() => _read(_dataSource.fetchEntitlement);

  @override
  Future<AppResult<AccountEntitlement>> registerBackup(String verifier) =>
      _read(() => _dataSource.registerBackup(verifier));

  Future<AppResult<AccountEntitlement>> _read(
    Future<RemoteEntitlement> Function() read,
  ) async {
    try {
      return Success((await read()).toAccountEntitlement());
    } on Object {
      return const Failure(ConnectionError());
    }
  }
}
