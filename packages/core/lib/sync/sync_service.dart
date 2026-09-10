// * the sync engine seam. Nothing above this interface knows that PowerSync
// * exists: no Bloc, no screen, no repository. Replacing the engine means
// * rewriting its implementation and the connector beside it, and nothing else.
enum SyncConnectionStatus { disconnected, connecting, syncing, synced, failed }

abstract class SyncService {
  /// When the last full round trip finished, or null if there has not been one
  /// on this device yet.
  DateTime? get lastSyncedAt;

  Stream<SyncConnectionStatus> watchStatus();

  Future<void> connect();

  Future<void> disconnect({required bool clearsLocalData});
}
