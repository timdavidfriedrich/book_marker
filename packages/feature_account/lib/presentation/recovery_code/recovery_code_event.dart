sealed class RecoveryCodeEvent {
  const RecoveryCodeEvent();
}

class const RecoveryCodeStarted() extends RecoveryCodeEvent;

class const RecoveryCodeCopied() extends RecoveryCodeEvent;

class const RecoveryCodeConfirmationToggled() extends RecoveryCodeEvent;

class const RecoveryCodeAccepted() extends RecoveryCodeEvent;
