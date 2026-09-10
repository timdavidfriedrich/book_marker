sealed class UnlockEvent {
  const UnlockEvent();
}

class const UnlockStarted() extends UnlockEvent;

class const UnlockSubmitted(final String code) extends UnlockEvent;
