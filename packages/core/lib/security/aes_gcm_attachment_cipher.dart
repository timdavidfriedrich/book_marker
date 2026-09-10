import 'dart:convert';
import 'dart:typed_data';

import 'package:core/security/attachment_cipher.dart';
import 'package:core/security/field_cipher.dart';
import 'package:core/security/master_key_store.dart';
import 'package:core/src/security/aes_gcm_codec.dart';
import 'package:cryptography/cryptography.dart';
import 'package:injectable/injectable.dart';

const _keyLength = 16;

// * one key per attachment, derived rather than stored. HKDF over the master
// * key with the attachment id as info: nothing extra to keep anywhere, the
// * same id always yields the same key, and a nonce reuse bug in one file
// * cannot reach any other.
final _kdf = Hkdf(hmac: Hmac.sha256(), outputLength: _keyLength);

@LazySingleton(as: AttachmentCipher)
class const AesGcmAttachmentCipher(
  final MasterKeyStore _keyStore,
) implements AttachmentCipher {
  @override
  Future<Uint8List> encrypt(String attachmentId, List<int> bytes) async =>
      encryptBytesWithKey(await _keyFor(attachmentId), bytes);

  @override
  Future<Uint8List> decrypt(String attachmentId, Uint8List bytes) async =>
      decryptBytesWithKey(await _keyFor(attachmentId), bytes);

  Future<Uint8List> _keyFor(String attachmentId) async {
    final master = await _keyStore.read();
    if (master == null) throw const MissingMasterKeyException();
    final derived = await _kdf.deriveKey(
      secretKey: SecretKey(master),
      info: utf8.encode(attachmentId),
      nonce: const [],
    );
    return Uint8List.fromList(await derived.extractBytes());
  }
}
