// ignore_for_file: avoid_print

// Generates the RSA keypair Serverpod uses to sign PowerSync JWTs.
//
//   dart run tool/generate_keys.dart
//
// The public half (n, e, kid) goes into .env for the powersync container.
// The private half goes into config/passwords.yaml as powerSyncSigningKey and
// is never committed. The key id needs no separate entry: it is inside the
// private key, and jose puts it in the JWS header where PowerSync looks.
//
// Development and production get DIFFERENT pairs. The production one is
// generated on the VPS so its private half never reaches a laptop.

import 'dart:convert';
import 'dart:math';

import 'package:jose/jose.dart';

const _alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

void main() {
  final key = {
    ...JsonWebKey.generate('RS256').toJson(),
    'kid': 'powersync-${_randomString(8)}',
  };

  final private = base64Encode(utf8.encode(json.encode(key)));

  print('''
Add to .env (public half - safe to commit only as an example):

  PS_JWK_N=${key['n']}
  PS_JWK_E=${key['e']}
  PS_JWK_KID=${key['kid']}

Add to config/passwords.yaml under the relevant run mode (SECRET - never commit):

  powerSyncSigningKey: '$private'
''');
}

String _randomString(int length) {
  final random = Random.secure();
  return String.fromCharCodes(
    List.generate(
      length,
      (_) => _alphabet.codeUnitAt(random.nextInt(_alphabet.length)),
    ),
  );
}
