sealed class UnlockState {
  const UnlockState();
}

class const UnlockPreparing() extends UnlockState;

// * a code cannot be checked offline: the verifier that proves it belongs to
// * this account lives on the server, and committing an unverified key would
// * leave a device that decrypts nothing and no way to tell why
enum UnlockBlocker { unreachable, noBackup }

class const UnlockUnavailable({
  required final UnlockBlocker blocker,
}) extends UnlockState;

class const UnlockReady({
  required final bool isChecking,
  required final bool hasFailed,
}) extends UnlockState;

class const UnlockSucceeded() extends UnlockState;
