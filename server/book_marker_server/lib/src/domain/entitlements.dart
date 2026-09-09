import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

const planFree = 'free';
const planPremium = 'premium';

const statusActive = 'active';
const statusBlocked = 'blocked';

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
