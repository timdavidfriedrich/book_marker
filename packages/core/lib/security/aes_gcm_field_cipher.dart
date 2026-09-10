import 'dart:typed_data';

import 'package:core/security/field_cipher.dart';
import 'package:core/security/master_key_store.dart';
import 'package:core/src/security/aes_gcm_codec.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FieldCipher)
class const AesGcmFieldCipher(
  final MasterKeyStore _keyStore,
) implements FieldCipher {
  @override
  Future<String> encrypt(String plaintext) async => encryptWithKey(await _requireKey(), plaintext);

  @override
  Future<String> decrypt(String ciphertext) async =>
      decryptWithKey(await _requireKey(), ciphertext);

  Future<Uint8List> _requireKey() async {
    final key = await _keyStore.read();
    if (key == null) throw const MissingMasterKeyException();
    return key;
  }
}
