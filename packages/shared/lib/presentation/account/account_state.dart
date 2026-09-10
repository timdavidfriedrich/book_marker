import 'package:shared/domain/entities/account.dart';

sealed class AccountState {
  const AccountState();
}

class const AccountRestoring() extends AccountState;

enum SignInProvider { google, apple }

class const AccountSignedOut({
  final SignInProvider? pendingProvider,
  final Object? error,
}) extends AccountState {
  bool get isSigningIn => pendingProvider != null;
}

// * the two locked cases must not be confused. Offering to generate a code to
// * someone who already has a backup would orphan everything encrypted under
// * the first key, so anything short of a clear "no backup exists" is enterCode
enum LockedReason { setUpBackup, enterCode }

class const AccountLocked({
  required final Account account,
  required final LockedReason reason,
}) extends AccountState;

class const AccountBlocked({
  required final Account account,
  required final String? reason,
}) extends AccountState;

class const AccountReady({
  required final Account account,
}) extends AccountState;
