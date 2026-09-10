import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../domain/attachments.dart';
import '../domain/entitlements.dart';

const _attachments = Attachments();

/// Encrypted attachment blobs: page photographs and voice notes.
///
/// The bytes are already encrypted when they arrive, with a key derived from
/// the device's master key. This server stores them and cannot read them, the
/// same posture as every synced row.
class AttachmentEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<void> upload(
    final Session session,
    final String attachmentId,
    final ByteData bytes,
  ) => _attachments.store(
    session,
    authenticatedOwnerId(session),
    attachmentId,
    bytes,
  );

  Future<ByteData> download(final Session session, final String attachmentId) =>
      _attachments.load(session, authenticatedOwnerId(session), attachmentId);

  Future<void> delete(final Session session, final String attachmentId) =>
      _attachments.remove(session, authenticatedOwnerId(session), attachmentId);
}
