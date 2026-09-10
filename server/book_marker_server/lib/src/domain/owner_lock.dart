import 'package:serverpod/serverpod.dart';

/// Serialises everything one user does inside a transaction, and nothing that
/// any other user does. Transaction scoped, so it releases at commit, and cheap
/// enough to take on every admission.
///
/// Two places need it and both guard against the same shape of bug: two
/// requests reading the same state, both deciding they may proceed, and both
/// writing.
Future<void> lockOwner(
  final Session session,
  final UuidValue ownerId,
  final Transaction transaction,
) async {
  await session.db.unsafeQuery(
    'SELECT pg_advisory_xact_lock(hashtext(@owner))',
    parameters: QueryParameters.named({'owner': ownerId.toString()}),
    transaction: transaction,
  );
}
