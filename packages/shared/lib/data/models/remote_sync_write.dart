// * one row change on its way up, already flattened out of the sync engine's
// * own type so the endpoint call does not have to know about PowerSync
class const RemoteSyncWrite({
  required final String table,
  required final String operation,
  required final String rowId,
  required final String? data,
});
