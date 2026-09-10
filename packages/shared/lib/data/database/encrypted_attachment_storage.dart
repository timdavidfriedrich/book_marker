// * PowerSync marks its whole attachments API experimental. Taking the
// * dependency is deliberate: the alternative is hand-rolling a queue with the
// * same states, retries and reconciliation, which is more code to be wrong in.
// ignore_for_file: experimental_member_use

import 'dart:typed_data';

import 'package:core/security/attachment_cipher.dart';
import 'package:injectable/injectable.dart';
import 'package:powersync/attachments/attachments.dart';
import 'package:shared/data/data_sources/attachment_remote_data_source.dart';

// * the file that makes an attachment as unreadable to the server as a row is.
// * The queue hands over plaintext and gets plaintext back; nothing above or
// * below this class knows that anything was encrypted in between.
@lazySingleton
class const EncryptedAttachmentStorage(
  final AttachmentRemoteDataSource _dataSource,
  final AttachmentCipher _cipher,
) implements RemoteStorage {
  @override
  Future<void> uploadFile(Stream<Uint8List> fileData, Attachment attachment) async {
    final plaintext = await _collect(fileData);
    await _dataSource.upload(
      attachment.id,
      await _cipher.encrypt(attachment.id, plaintext),
    );
  }

  @override
  Future<Stream<List<int>>> downloadFile(Attachment attachment) async {
    final ciphertext = await _dataSource.download(attachment.id);
    return Stream.value(await _cipher.decrypt(attachment.id, ciphertext));
  }

  @override
  Future<void> deleteFile(Attachment attachment) => _dataSource.delete(attachment.id);

  // * a page image is a few hundred kilobytes, so holding one in memory to
  // * encrypt it whole is the simple thing rather than the wasteful one
  Future<Uint8List> _collect(Stream<Uint8List> data) async {
    final chunks = await data.toList();
    if (chunks.length == 1) return chunks.first;
    return Uint8List.fromList([for (final chunk in chunks) ...chunk]);
  }
}
