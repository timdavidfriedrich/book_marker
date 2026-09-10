import 'package:serverpod/serverpod.dart';

import '../domain/entitlements.dart';
import '../domain/power_sync_tokens.dart';
import '../generated/protocol.dart';

const _tokens = PowerSyncTokens();
const _entitlements = Entitlements();

/// Hands the client a PowerSync credential. This is the real gate on sync: a
/// blocked account is refused here, and the 10-minute token lifetime bounds how
/// long an already-issued one stays usable.
class PowerSyncEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<String> createToken(final Session session) async {
    final userId = authenticatedOwnerId(session);
    final entitlement = await _entitlements.ensureForUser(
      session,
      userId,
      transaction: null,
    );
    if (entitlement.status == statusBlocked) {
      throw AccountBlockedException(reason: entitlement.blockedReason);
    }
    return _tokens.issue(userId);
  }
}
