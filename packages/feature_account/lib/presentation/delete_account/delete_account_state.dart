sealed class DeleteAccountState {
  const DeleteAccountState();
}

class const DeleteAccountIdle({
  required final bool hasFailed,
}) extends DeleteAccountState;

class const DeleteAccountRunning() extends DeleteAccountState;

class const DeleteAccountDone() extends DeleteAccountState;
