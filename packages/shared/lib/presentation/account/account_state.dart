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

class const AccountLocked({
  required final Account account,
}) extends AccountState;

class const AccountBlocked({
  required final Account account,
  required final String? reason,
}) extends AccountState;

class const AccountReady({
  required final Account account,
}) extends AccountState;
