import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/account_entitlement.dart';

abstract class EntitlementRepository {
  Future<AppResult<AccountEntitlement>> fetch();

  Future<AppResult<AccountEntitlement>> registerBackup(String verifier);
}
