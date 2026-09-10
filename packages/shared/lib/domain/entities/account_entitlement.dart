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
  // * resolved from the runtime config against the plan, in the repository.
  // * Nothing above needs to know which plan implies what, and the answer moves
  // * the moment app_config.yaml does
  required final bool attachmentsEnabled,
}) with AccountEntitlementMappable {
  bool get hasBackup => backupVerifier != null;
}
