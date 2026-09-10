// * the attachment seam, matching SyncService: nothing above it knows that
// * PowerSync has an attachment queue, or that there is a queue at all.
abstract class AttachmentService {
  /// Starts or stops uploading. Idempotent, and called on every account state
  /// change rather than only on a plan change, because a plan can change while
  /// the account state does not.
  Future<void> setEnabled({required bool isEnabled});

  /// Copies a captured file into attachment storage and queues it for upload,
  /// returning where it now lives.
  Future<String> adopt(String sourcePath, String extension);

  /// Removes a file and queues its blob for deletion.
  Future<void> discard(String path);
}
