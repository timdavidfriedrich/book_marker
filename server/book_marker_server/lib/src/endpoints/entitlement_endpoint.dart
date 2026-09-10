import 'package:serverpod/serverpod.dart';

import '../domain/entitlements.dart';
import '../generated/protocol.dart';

const _entitlements = Entitlements();

/// Plan, account status and cloud OCR usage, read straight from the database.
///
/// This is the path that works before PowerSync connects, which is the only
/// path available at sign-in: the master key has to be resolved before the
/// encrypted local database can be opened, so sync cannot answer it.
class EntitlementEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Deliberately does NOT refuse a blocked account. The client has to read the
  /// status to explain the block; refusing here would leave it with nothing to
  /// show but a generic error.
  Future<EntitlementView> fetch(final Session session) async {
    final entitlement = await _entitlements.ensureForUser(
      session,
      authenticatedOwnerId(session),
      transaction: null,
    );
    return _entitlements.toView(entitlement);
  }

  /// Also allowed while blocked, unlike every other write. It consumes nothing
  /// and grants nothing; withholding it would leave a device holding a key the
  /// server has no record of, which is the one state that loses data later.
  ///
  /// Returns the row as it stands afterwards. A caller whose verifier is not
  /// the one that came back lost a race with another device and must not keep
  /// its own key.
  Future<EntitlementView> registerBackup(
    final Session session,
    final String verifier,
  ) async {
    final entitlement = await _entitlements.registerBackup(
      session,
      authenticatedOwnerId(session),
      verifier,
    );
    return _entitlements.toView(entitlement);
  }
}
