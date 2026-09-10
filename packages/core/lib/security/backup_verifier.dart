import 'dart:typed_data';

abstract class BackupVerifier {
  Future<String> create(Uint8List key);

  Future<bool> matches(String verifier, Uint8List key);
}
