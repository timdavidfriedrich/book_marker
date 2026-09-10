// * the attachment seam, matching SyncService: nothing above it knows that
// * PowerSync has an attachment queue, or that there is a queue at all.
abstract class AttachmentService {
  /// Re-reads the plan and starts or stops uploading accordingly.
  ///
  /// Called on every account state change rather than on a plan change, because
  /// the plan is not something this device is told about; it is something it
  /// notices.
  Future<void> refresh();

  Future<void> stop();

  /// Copies a captured file into attachment storage and queues it for upload,
  /// returning where it now lives.
  Future<String> adopt(String sourcePath, String extension);

  /// Removes a file and queues its blob for deletion.
  Future<void> discard(String path);
}
