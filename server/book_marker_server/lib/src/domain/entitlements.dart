import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'owner_lock.dart';

const planFree = 'free';
const planPremium = 'premium';

const statusActive = 'active';
const statusBlocked = 'blocked';

/// The AuthUser id as a UUID. It is what `auth.user_id()` resolves to in the
/// PowerSync sync streams, and the owner of every row this server stores.
UuidValue authenticatedOwnerId(final Session session) =>
    UuidValue.fromString(session.authenticated!.userIdentifier);

/// Creation and lookup of the per-user entitlement row.
///
/// Every account must have exactly one. It is created in the same transaction
/// as the auth user, never lazily on first use - a missing row would fail the
/// first cloud scan of every new account.
class Entitlements {
  const Entitlements();

  Future<Entitlement> createForUser(
    final Session session,
    final UuidValue ownerId, {
    required final Transaction? transaction,
  }) {
    return Entitlement.db.insertRow(
      session,
      Entitlement(
        ownerId: ownerId,
        plan: planFree,
        status: statusActive,
        usedDay: 0,
        usedWeek: 0,
        usedMonth: 0,
        updatedAt: DateTime.now().toUtc(),
      ),
      transaction: transaction,
    );
  }

  /// Idempotent: safe to call for a user who already has a row, which happens
  /// when a second identity provider is linked to an existing account.
  Future<Entitlement> ensureForUser(
    final Session session,
    final UuidValue ownerId, {
    required final Transaction? transaction,
  }) async {
    final existing = await findForUser(
      session,
      ownerId,
      transaction: transaction,
    );
    if (existing != null) return existing;
    return createForUser(session, ownerId, transaction: transaction);
  }

  /// Registers the backup verifier written by the first device to finish key
  /// setup. One-way: an existing verifier is never overwritten, because that
  /// would orphan everything already encrypted under the first key.
  ///
  /// The advisory lock closes the one race that loses data, two devices both
  /// finding no verifier and both writing one. It is transaction scoped, per
  /// user, and released at commit.
  ///
  /// Returns the row as it stands afterwards, so a caller that lost the race
  /// sees the verifier that won and can route the user to unlock instead.
  Future<Entitlement> registerBackup(
    final Session session,
    final UuidValue ownerId,
    final String verifier,
  ) {
    return session.db.transaction((final transaction) async {
      await lockOwner(session, ownerId, transaction);
      final entitlement = await ensureForUser(
        session,
        ownerId,
        transaction: transaction,
      );
      if (entitlement.backupVerifier != null) return entitlement;
      final now = DateTime.now().toUtc();
      return Entitlement.db.updateRow(
        session,
        entitlement.copyWith(
          backupVerifier: verifier,
          backupInitializedAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
    });
  }

  /// The narrower shape the device is allowed to see. The purchase columns and
  /// the setup timestamp stay on the server; the device needs the verifier and
  /// nothing else about the backup.
  EntitlementView toView(final Entitlement entitlement) {
    return EntitlementView(
      plan: entitlement.plan,
      status: entitlement.status,
      blockedReason: entitlement.blockedReason,
      backupVerifier: entitlement.backupVerifier,
      usedDay: entitlement.usedDay,
      usedWeek: entitlement.usedWeek,
      usedMonth: entitlement.usedMonth,
    );
  }

  Future<Entitlement?> findForUser(
    final Session session,
    final UuidValue ownerId, {
    final Transaction? transaction,
  }) {
    return Entitlement.db.findFirstRow(
      session,
      where: (final t) => t.ownerId.equals(ownerId),
      transaction: transaction,
    );
  }
}
