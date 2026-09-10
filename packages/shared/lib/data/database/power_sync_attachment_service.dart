// * PowerSync marks its whole attachments API experimental. Taking the
// * dependency is deliberate: the alternative is hand-rolling a queue with the
// * same states, retries and reconciliation, which is more code to be wrong in.
// ignore_for_file: experimental_member_use

import 'dart:async';
import 'dart:io';

import 'package:core/error/app_result.dart';
import 'package:core/sync/attachment_service.dart';
import 'package:powersync/attachments/attachments.dart';
import 'package:powersync/attachments/io.dart';
import 'package:shared/data/data_sources/quote_local_data_source.dart';
import 'package:shared/data/database/attachment_paths.dart';
import 'package:shared/data/database/encrypted_attachment_storage.dart';
import 'package:shared/data/database/sync_database.dart';
import 'package:shared/data/models/remote_attachment.dart';
import 'package:shared/domain/entities/account_entitlement.dart';
import 'package:shared/domain/repositories/app_config_repository.dart';
import 'package:shared/domain/repositories/entitlement_repository.dart';

const _photoMediaType = "image/jpeg";
const _voiceNoteMediaType = "audio/mp4";

class PowerSyncAttachmentService implements AttachmentService {
  PowerSyncAttachmentService(this._queue, this._paths, this._entitlements, this._config);

  final AttachmentQueue _queue;
  final AttachmentPaths _paths;
  final EntitlementRepository _entitlements;
  final AppConfigRepository _config;

  bool _isRunning = false;

  static Future<PowerSyncAttachmentService> open({
    required SyncDatabase syncDatabase,
    required EncryptedAttachmentStorage storage,
    required AttachmentPaths paths,
    required QuoteLocalDataSource quotes,
    required EntitlementRepository entitlements,
    required AppConfigRepository config,
  }) async {
    final queue = AttachmentQueue(
      db: syncDatabase.database,
      remoteStorage: storage,
      localStorage: IOLocalStorage(Directory(paths.root)),
      watchAttachments: () => quotes.watchAttachmentReferences().map(
        (references) => [
          for (final reference in references)
            WatchedAttachmentItem(
              id: reference.id,
              fileExtension: reference.extension,
            ),
        ],
      ),
      // * a refusal is permanent by construction: not premium, or too large.
      // * Retrying either is how a background queue turns into a denial of
      // * service against its own server
      errorHandler: const AttachmentErrorHandler(
        onUploadError: _isRetryable,
        onDownloadError: _isRetryable,
        onDeleteError: _isRetryable,
      ),
    );
    return PowerSyncAttachmentService(queue, paths, entitlements, config);
  }

  // * the queue is the gate, not a per-file check. While it is stopped nothing
  // * is attempted, so a free account's photos sit at queuedUpload and go up
  // * the moment it becomes premium: the backfill this needs is the absence of
  // * anything having archived them in the meantime
  @override
  Future<void> refresh() async {
    final isEnabled = await _isEnabled();
    if (isEnabled == _isRunning) return;
    _isRunning = isEnabled;
    await (isEnabled ? _queue.startSync() : _queue.stopSyncing());
  }

  @override
  Future<void> stop() async {
    if (!_isRunning) return;
    _isRunning = false;
    await _queue.stopSyncing();
  }

  @override
  Future<String> adopt(String sourcePath, String extension) async {
    final source = File(sourcePath);
    final attachment = await _queue.saveFile(
      data: source.openRead(),
      mediaType: extension == voiceNoteExtension ? _voiceNoteMediaType : _photoMediaType,
      fileExtension: extension,
      updateHook: (_, _) async {},
    );
    // * the capture file has been copied into attachment storage, so leaving it
    // * behind would keep a second copy of every photo forever
    if (source.existsSync()) await source.delete();
    return _paths.pathFor(attachment.id, extension);
  }

  @override
  Future<void> discard(String path) async {
    final id = _paths.idFrom(path);
    if (id == null) return;
    await _queue.deleteFile(attachmentId: id, updateHook: (_, _) async {});
  }

  Future<bool> _isEnabled() async {
    final entitlement = switch (await _entitlements.fetch()) {
      Success(:final data) => data,
      Failure() => null,
    };
    if (entitlement == null || entitlement.status == AccountStatus.blocked) return false;
    final config = switch (await _config.watchConfig().first) {
      Success(:final data) => data,
      Failure() => null,
    };
    if (config == null) return false;
    return switch (entitlement.plan) {
      AccountPlan.premium => config.premium.attachmentsEnabled,
      AccountPlan.free || AccountPlan.unknown => config.free.attachmentsEnabled,
    };
  }
}

Future<bool> _isRetryable(
  Attachment attachment,
  Object exception,
  StackTrace stackTrace,
) async => exception is! AttachmentRefusedException;
