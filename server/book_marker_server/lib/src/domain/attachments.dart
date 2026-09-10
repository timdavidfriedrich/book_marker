import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'config_source.dart';
import 'entitlements.dart';

const _config = ConfigSource();
const _entitlements = Entitlements();

/// The Serverpod storage id everything here uses. Which backend answers to it
/// is decided once at boot, in `composition.dart`.
const attachmentStorageId = 'private';

/// Gate 2: attachment sync, premium only.
///
/// Bytes arriving here are already encrypted by the device with a key derived
/// from its master key. This server stores an opaque blob and could not open it
/// if it wanted to, which is why the object key is the only thing about an
/// attachment it can reason about.
class Attachments {
  const Attachments();

  Future<void> store(
    final Session session,
    final UuidValue ownerId,
    final String attachmentId,
    final ByteData bytes,
  ) async {
    final entitlement = await _requireActive(session, ownerId);
    final limits = _config.limitsFor(entitlement.plan);
    if (!limits.attachmentsEnabled) {
      throw AttachmentNotEntitledException(
        reason: 'the ${entitlement.plan} plan does not sync attachments',
      );
    }
    if (bytes.lengthInBytes > limits.maxAttachmentBytes) {
      // * also permanent: a file this size will still be this size on a retry
      throw AttachmentNotEntitledException(
        reason:
            'attachment is ${bytes.lengthInBytes} bytes, '
            'the limit is ${limits.maxAttachmentBytes}',
      );
    }
    await session.storage.storeFile(
      storageId: attachmentStorageId,
      path: _key(ownerId, attachmentId),
      byteData: bytes,
    );
    await _index(session, ownerId, attachmentId, bytes.lengthInBytes);
  }

  /// Downloading is deliberately NOT gated on the plan.
  ///
  /// A lapsed subscriber keeps everything they already uploaded and can still
  /// read it. Only new uploads stop, which is the difference between a plan
  /// ending and data being taken away.
  Future<ByteData> load(
    final Session session,
    final UuidValue ownerId,
    final String attachmentId,
  ) async {
    await _requireActive(session, ownerId);
    return session.storage.retrieveFile(
      storageId: attachmentStorageId,
      path: _key(ownerId, attachmentId),
    );
  }

  Future<void> remove(
    final Session session,
    final UuidValue ownerId,
    final String attachmentId,
  ) async {
    await _requireActive(session, ownerId);
    await session.storage.deleteFile(
      storageId: attachmentStorageId,
      path: _key(ownerId, attachmentId),
    );
    await AttachmentObject.db.deleteWhere(
      session,
      where: (final t) =>
          t.ownerId.equals(ownerId) & t.attachmentId.equals(attachmentId),
    );
  }

  /// Removes everything an owner has stored. Called from account deletion,
  /// where the row that referenced each blob is about to disappear.
  Future<void> removeAll(final Session session, final UuidValue ownerId) async {
    final objects = await AttachmentObject.db.find(
      session,
      where: (final t) => t.ownerId.equals(ownerId),
    );
    for (final object in objects) {
      await session.storage.deleteFile(
        storageId: attachmentStorageId,
        path: _key(ownerId, object.attachmentId),
      );
    }
    await AttachmentObject.db.deleteWhere(
      session,
      where: (final t) => t.ownerId.equals(ownerId),
    );
  }

  /// What this owner is costing in blob storage. The plan's disk arithmetic is
  /// 565 KB a page against 100 GB, and this is the number that makes it real
  /// rather than an estimate.
  Future<int> storedBytes(
    final Session session,
    final UuidValue ownerId,
  ) async {
    final rows = await session.db.unsafeQuery(
      'SELECT coalesce(sum(size_bytes), 0)::bigint FROM attachment_objects '
      'WHERE owner_id = @owner::uuid',
      parameters: QueryParameters.named({'owner': ownerId.toString()}),
    );
    return rows.first.first! as int;
  }

  // * upsert by (owner, attachment), because re-uploading the same attachment
  // * replaces the blob and must not leave two rows claiming its size
  Future<void> _index(
    final Session session,
    final UuidValue ownerId,
    final String attachmentId,
    final int sizeBytes,
  ) async {
    await AttachmentObject.db.deleteWhere(
      session,
      where: (final t) =>
          t.ownerId.equals(ownerId) & t.attachmentId.equals(attachmentId),
    );
    await AttachmentObject.db.insertRow(
      session,
      AttachmentObject(
        ownerId: ownerId,
        attachmentId: attachmentId,
        sizeBytes: sizeBytes,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<Entitlement> _requireActive(
    final Session session,
    final UuidValue ownerId,
  ) async {
    final entitlement = await _entitlements.ensureForUser(
      session,
      ownerId,
      transaction: null,
    );
    if (entitlement.status == statusBlocked) {
      throw AccountBlockedException(reason: entitlement.blockedReason);
    }
    return entitlement;
  }
}

// * the owner is in the key, so ownership is structural rather than a check
// * somebody could forget to write. A key outside the caller's own prefix
// * cannot be built from a session at all
String _key(final UuidValue ownerId, final String attachmentId) =>
    '$ownerId/${_sanitise(attachmentId)}';

// * the id reaches an object store path, so anything that could climb out of
// * the owner's prefix is rejected rather than escaped
String _sanitise(final String attachmentId) {
  if (!RegExp(r'^[A-Za-z0-9_-]{1,64}$').hasMatch(attachmentId)) {
    throw AttachmentNotEntitledException(
      reason: 'malformed attachment id',
    );
  }
  return attachmentId;
}
