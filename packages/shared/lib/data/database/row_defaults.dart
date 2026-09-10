// * rows carry no owner while they are local. SyncEndpoint.upload overwrites it
// * from the session on the way up, and the row comes back down with the real
// * value, so writing anything here would only be a guess the server ignores.
const unownedRow = "";

// * which key encrypted the row. Bumped only when re-encryption lands, which is
// * what the column exists for.
const currentKeyVersion = 1;
