abstract class FieldCipher {
  Future<String> encrypt(String plaintext);

  Future<String> decrypt(String ciphertext);
}

class const MissingMasterKeyException() implements Exception;

class const UndecryptableFieldException() implements Exception;
