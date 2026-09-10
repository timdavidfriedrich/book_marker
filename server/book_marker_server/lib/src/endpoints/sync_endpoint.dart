import 'package:serverpod/serverpod.dart';

import '../domain/config_source.dart';
import '../domain/entitlements.dart';
import '../domain/sync_writes.dart';
import '../generated/protocol.dart';

const _config = ConfigSource();
const _entitlements = Entitlements();
const _writes = SyncWrites();

/// The upload half of sync. PowerSync streams rows down; everything the device
/// writes comes back up through here.
class SyncEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<SyncResult> upload(
    final Session session,
    final List<SyncWrite> writes,
  ) async {
    final ownerId = authenticatedOwnerId(session);
    // * checked here as well as in createToken, deliberately. A ten minute
    // * token already in a client's hands proves nothing about current status
    final entitlement = await _entitlements.ensureForUser(
      session,
      ownerId,
      transaction: null,
    );
    if (entitlement.status == statusBlocked) {
      throw AccountBlockedException(reason: entitlement.blockedReason);
    }
    return _writes.apply(session, ownerId, writes, _config.read().syncLimits);
  }
}
