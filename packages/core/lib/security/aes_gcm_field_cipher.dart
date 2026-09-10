import 'dart:convert';
import 'dart:typed_data';

import 'package:core/security/field_cipher.dart';
import 'package:core/security/master_key_store.dart';
import 'package:cryptography/cryptography.dart';
import 'package:injectable/injectable.dart';

const _nonceLength = 12;
const _macLength = 16;

@LazySingleton(as: FieldCipher)
class AesGcmFieldCipher(
  final MasterKeyStore _keyStore,
) implements FieldCipher {
  final AesGcm _algorithm = AesGcm.with128bits();

  @override
  Future<String> encrypt(String plaintext) async {
    final box = await _algorithm.encrypt(
      utf8.encode(plaintext),
      secretKey: await _secretKey(),
    );
    return base64Encode([...box.nonce, ...box.cipherText, ...box.mac.bytes]);
  }

  @override
  Future<String> decrypt(String ciphertext) async {
    final bytes = _decode(ciphertext);
    if (bytes == null || bytes.length < _nonceLength + _macLength) {
      throw const UndecryptableFieldException();
    }
    final box = SecretBox(
      bytes.sublist(_nonceLength, bytes.length - _macLength),
      nonce: bytes.sublist(0, _nonceLength),
      mac: Mac(bytes.sublist(bytes.length - _macLength)),
    );
    try {
      return utf8.decode(await _algorithm.decrypt(box, secretKey: await _secretKey()));
    } on SecretBoxAuthenticationError {
      // * wrong key, or the value was tampered with; both are unreadable and
      // * must not be reported differently
      throw const UndecryptableFieldException();
    }
  }

  Future<SecretKey> _secretKey() async {
    final key = await _keyStore.read();
    if (key == null) throw const MissingMasterKeyException();
    return SecretKey(key);
  }
}

Uint8List? _decode(String value) {
  try {
    return Uint8List.fromList(base64Decode(value));
  } on FormatException {
    return null;
  }
}
