import 'dart:typed_data';

abstract class FieldCipher {
  Future<String> encrypt(String plaintext);

  Future<String> decrypt(String ciphertext);

  // * rotation belongs on this seam rather than beside its one caller: a
  // * replacement cipher has to be able to rewrite values it already wrote, or
  // * keyVersion could never be bumped
  Future<String> rotate(String ciphertext, {required Uint8List from, required Uint8List to});
}

class const MissingMasterKeyException() implements Exception;

class const UndecryptableFieldException() implements Exception;
