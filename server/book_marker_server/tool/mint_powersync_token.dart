// ignore_for_file: avoid_print

// Mints a PowerSync JWT for one user, the same way PowerSyncEndpoint does.
//
//   dart run tool/mint_powersync_token.dart <auth-user-uuid>
//
// For verifying the sync path without a signed-in device:
//
//   curl -X POST http://localhost:8095/sync/stream \
//     -H "Authorization: Bearer $(dart run tool/mint_powersync_token.dart <uuid>)" \
//     -H 'Content-Type: application/json' -d '{"raw_data":true}'
//
// Reads the signing key from the run mode's passwords.yaml, so it can only mint
// what that machine could already sign.

import 'package:book_marker_server/src/domain/power_sync_tokens.dart';
import 'package:book_marker_server/src/generated/serverpod.dart';

void main(List<String> args) async {
  if (args.length != 1) {
    print('usage: dart run tool/mint_powersync_token.dart <auth-user-uuid>');
    return;
  }
  Serverpod(['--role', 'maintenance']);
  print(await const PowerSyncTokens().issue(UuidValue.fromString(args.first)));
}
