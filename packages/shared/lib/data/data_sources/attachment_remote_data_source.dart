import 'dart:typed_data';

import 'package:book_marker_client/book_marker_client.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/models/remote_attachment.dart';

// * the only place the generated attachment types are used. It also separates
// * the server's permanent refusals from everything else, because the queue
// * behaves completely differently for the two
abstract class AttachmentRemoteDataSource {
  Future<void> upload(String attachmentId, Uint8List bytes);

  Future<Uint8List> download(String attachmentId);

  Future<void> delete(String attachmentId);
}

@Injectable(as: AttachmentRemoteDataSource)
class const AttachmentRemoteDataSourceImpl(
  final Client _client,
) implements AttachmentRemoteDataSource {
  @override
  Future<void> upload(String attachmentId, Uint8List bytes) => _guard(
    () => _client.attachment.upload(attachmentId, ByteData.view(bytes.buffer)),
  );

  @override
  Future<Uint8List> download(String attachmentId) async {
    final data = await _guard(() => _client.attachment.download(attachmentId));
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  @override
  Future<void> delete(String attachmentId) => _guard(() => _client.attachment.delete(attachmentId));

  Future<T> _guard<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on AttachmentNotEntitledException catch (exception) {
      throw AttachmentRefusedException(exception.reason);
    }
  }
}
