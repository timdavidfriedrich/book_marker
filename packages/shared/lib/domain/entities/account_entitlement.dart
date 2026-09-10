import 'package:dart_mappable/dart_mappable.dart';

part 'account_entitlement.mapper.dart';

@MappableEnum()
enum AccountPlan { free, premium, unknown }

@MappableEnum()
enum AccountStatus { active, blocked, unknown }

@MappableClass()
class const AccountEntitlement({
  required final AccountPlan plan,
  required final AccountStatus status,
  required final String? blockedReason,
  required final String? backupVerifier,
  required final int usedDay,
  required final int usedWeek,
  required final int usedMonth,
}) with AccountEntitlementMappable {
  bool get hasBackup => backupVerifier != null;
}
