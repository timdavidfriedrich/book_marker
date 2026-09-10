import 'dart:convert';
import 'dart:isolate';

import 'package:jose/jose.dart';
import 'package:serverpod/serverpod.dart';

const _audience = 'powersync';
const _lifetime = Duration(minutes: 10);

/// Mints the short-lived RS256 tokens the PowerSync service accepts.
///
/// PowerSync validates these against a static JWK in its own `service.yaml`; it
/// never contacts an identity provider. The subject is the Serverpod AuthUser
/// id, which is what `auth.user_id()` resolves to in the sync streams.
class PowerSyncTokens {
  const PowerSyncTokens();

  Future<String> issue(final UuidValue userId) {
    final signingKey = _password('powerSyncSigningKey');
    // * signing is CPU-bound; keep it off the request isolate
    return Isolate.run(() => _sign(userId.toString(), signingKey));
  }
}

String _password(final String key) {
  final value = Serverpod.instance.getPassword(key);
  if (value == null) {
    throw StateError('Missing "$key" in config/passwords.yaml');
  }
  return value;
}

String _sign(final String subject, final String signingKey) {
  final decoded = json.decode(utf8.decode(base64.decode(signingKey)));
  final key = JsonWebKey.fromJson(decoded as Map<String, Object?>);
  final now = DateTime.now();

  final builder = JsonWebSignatureBuilder()
    ..jsonContent = {
      'sub': subject,
      'iat': now.millisecondsSinceEpoch ~/ 1000,
      'exp': now.add(_lifetime).millisecondsSinceEpoch ~/ 1000,
      'aud': [_audience],
    }
    // * the key id travels in the JWS header, which is where PowerSync looks
    // * for it when picking a JWK; jose takes it from the key itself
    ..addRecipient(key, algorithm: 'RS256');

  return builder.build().toCompactSerialization();
}
