sealed class RecoveryCodeState {
  const RecoveryCodeState();
}

class const RecoveryCodeGenerating() extends RecoveryCodeState;

class const RecoveryCodeReady({
  required final List<String> groups,
  required final bool isCopied,
  required final bool isConfirmed,
  required final bool isStarting,
}) extends RecoveryCodeState;
