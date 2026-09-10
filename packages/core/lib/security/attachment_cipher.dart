import 'dart:typed_data';

abstract class AttachmentCipher {
  Future<Uint8List> encrypt(String attachmentId, List<int> bytes);

  Future<Uint8List> decrypt(String attachmentId, Uint8List bytes);
}
