import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import 'attachments.dart';

// * everything on this server that is keyed by owner. Deleting is by column
// * rather than by model so a table added later without being listed here is a
// * compile-time nothing but a review-time obvious omission: the list is the
// * documentation of what "delete my account" actually covers.
const _attachments = Attachments();

const _ownedTables = [
  'attachment_objects',
  'quotes',
  'books',
  'shelf_books',
  'theme_quotes',
  'shelves',
  'themes',
  'ocr_usage',
  'entitlements',
];

/// DSGVO account deletion, and the only operation on this server that destroys
/// user data.
///
/// The device's copy is not touched. That is the promise the screen makes: the
/// account, the server-side library and the usage log go, and the library on
/// this phone stays exactly where it is.
class AccountDeletion {
  const AccountDeletion();

  Future<void> delete(final Session session, final UuidValue ownerId) async {
    // * before the transaction, because object storage is not part of it. A
    // * blob left behind after the row that indexed it is gone is unreachable
    // * forever, so the blobs go first and a failure here stops the deletion
    // * with everything still consistent
    await _attachments.removeAll(session, ownerId);

    // * rows first, then the auth user, and all of it in one transaction. The
    // * other order risks an account that is gone while its rows remain, which
    // * nothing would ever reach again to clean up
    await session.db.transaction((final transaction) async {
      for (final table in _ownedTables) {
        await session.db.unsafeQuery(
          'DELETE FROM "$table" WHERE "owner_id" = @owner::uuid',
          parameters: QueryParameters.named({'owner': ownerId.toString()}),
          transaction: transaction,
        );
      }
      await const AuthUsers().delete(
        session,
        authUserId: ownerId,
        transaction: transaction,
      );
    });

    // * tells any open method stream that this session is finished, rather than
    // * leaving it to discover it on the next call
    await session.messages.authenticationRevoked(
      ownerId.toString(),
      RevokedAuthenticationUser(),
    );
  }
}
