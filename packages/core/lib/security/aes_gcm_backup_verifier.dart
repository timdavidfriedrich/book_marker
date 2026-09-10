import 'dart:typed_data';

import 'package:core/security/backup_verifier.dart';
import 'package:core/security/field_cipher.dart';
import 'package:core/src/security/aes_gcm_codec.dart';
import 'package:injectable/injectable.dart';

// * a known string encrypted under the master key. It looks alarming and is
// * not: AES-GCM is secure against a chosen plaintext, so publishing one
// * ciphertext of a known message reveals nothing about a 128 bit random key.
// * What it buys is the ability to tell a wrong recovery code from a right one
// * immediately, instead of after a sync round trip produces garbage.
const _knownPlaintext = "book_marker.backup.v1";

@LazySingleton(as: BackupVerifier)
class const AesGcmBackupVerifier() implements BackupVerifier {
  @override
  Future<String> create(Uint8List key) => encryptWithKey(key, _knownPlaintext);

  @override
  Future<bool> matches(String verifier, Uint8List key) async {
    try {
      return await decryptWithKey(key, verifier) == _knownPlaintext;
    } on UndecryptableFieldException {
      return false;
    }
  }
}
