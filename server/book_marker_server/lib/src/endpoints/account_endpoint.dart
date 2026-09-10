import 'package:serverpod/serverpod.dart';

import '../domain/account_deletion.dart';
import '../domain/entitlements.dart';

const _deletion = AccountDeletion();

/// Account deletion, which DSGVO requires and which nothing else on this server
/// does: every other path only ever adds or updates.
///
/// Deliberately allowed while blocked. A suspended account still has the right
/// to its own erasure, and refusing would turn a legal obligation into a
/// support ticket.
class AccountEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<void> delete(final Session session) =>
      _deletion.delete(session, authenticatedOwnerId(session));
}
