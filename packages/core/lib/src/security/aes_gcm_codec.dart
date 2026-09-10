import 'dart:convert';
import 'dart:typed_data';

import 'package:core/security/field_cipher.dart';
import 'package:cryptography/cryptography.dart';

const _nonceLength = 12;
const _macLength = 16;

final _algorithm = AesGcm.with128bits();

// * key explicit rather than taken from the keystore, because a candidate key
// * has to be testable before it is committed
Future<String> encryptWithKey(Uint8List key, String plaintext) async {
  final box = await _algorithm.encrypt(utf8.encode(plaintext), secretKey: SecretKey(key));
  return base64Encode([...box.nonce, ...box.cipherText, ...box.mac.bytes]);
}

Future<String> decryptWithKey(Uint8List key, String ciphertext) async {
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
    return utf8.decode(await _algorithm.decrypt(box, secretKey: SecretKey(key)));
  } on SecretBoxAuthenticationError {
    // * wrong key, or the value was tampered with; both are unreadable and
    // * must not be reported differently
    throw const UndecryptableFieldException();
  }
}

// * bytes in, bytes out, for attachment blobs. The string pair above is for
// * column values, where base64 is what the column holds anyway; running an
// * image through base64 on the way to an object store would cost a third of
// * its size for nothing
Future<Uint8List> encryptBytesWithKey(Uint8List key, List<int> plaintext) async {
  final box = await _algorithm.encrypt(plaintext, secretKey: SecretKey(key));
  return Uint8List.fromList([...box.nonce, ...box.cipherText, ...box.mac.bytes]);
}

Future<Uint8List> decryptBytesWithKey(Uint8List key, Uint8List bytes) async {
  if (bytes.length < _nonceLength + _macLength) {
    throw const UndecryptableFieldException();
  }
  final box = SecretBox(
    bytes.sublist(_nonceLength, bytes.length - _macLength),
    nonce: bytes.sublist(0, _nonceLength),
    mac: Mac(bytes.sublist(bytes.length - _macLength)),
  );
  try {
    return Uint8List.fromList(
      await _algorithm.decrypt(box, secretKey: SecretKey(key)),
    );
  } on SecretBoxAuthenticationError {
    throw const UndecryptableFieldException();
  }
}

Uint8List? _decode(String value) {
  try {
    return Uint8List.fromList(base64Decode(value));
  } on FormatException {
    return null;
  }
}
