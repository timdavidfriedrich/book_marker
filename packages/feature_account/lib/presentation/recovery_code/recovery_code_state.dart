sealed class RecoveryCodeState {
  const RecoveryCodeState();
}

class const RecoveryCodeGenerating() extends RecoveryCodeState;

// * backupExists means another device finished setup first. Its key is the
// * canonical one, so this device must unlock with the existing code rather
// * than keep the one it just generated
enum RecoveryCodeFailure { unreachable, backupExists }

class const RecoveryCodeReady({
  required final List<String> groups,
  required final bool isCopied,
  required final bool isConfirmed,
  required final bool isStarting,
  required final RecoveryCodeFailure? failure,
}) extends RecoveryCodeState;

class const RecoveryCodeCommitted() extends RecoveryCodeState;
