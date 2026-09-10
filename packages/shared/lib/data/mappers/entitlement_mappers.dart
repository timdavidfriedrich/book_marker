import 'package:shared/data/models/remote_entitlement.dart';
import 'package:shared/domain/entities/account_entitlement.dart';

const _planFree = "free";
const _planPremium = "premium";
const _statusActive = "active";
const _statusBlocked = "blocked";

extension RemoteEntitlementMappers on RemoteEntitlement {
  AccountEntitlement toAccountEntitlement() {
    return AccountEntitlement(
      plan: plan.toAccountPlan(),
      status: status.toAccountStatus(),
      blockedReason: blockedReason,
      backupVerifier: backupVerifier,
      usedDay: usedDay,
      usedWeek: usedWeek,
      usedMonth: usedMonth,
    );
  }
}

extension AccountPlanValueMappers on String {
  AccountPlan toAccountPlan() => switch (this) {
    _planFree => AccountPlan.free,
    _planPremium => AccountPlan.premium,
    _ => AccountPlan.unknown,
  };

  AccountStatus toAccountStatus() => switch (this) {
    _statusActive => AccountStatus.active,
    _statusBlocked => AccountStatus.blocked,
    _ => AccountStatus.unknown,
  };
}
