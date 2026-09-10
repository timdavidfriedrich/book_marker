import 'package:shared/domain/entities/account.dart';

sealed class AccountState {
  const AccountState();
}

class const AccountRestoring() extends AccountState;

class const AccountSignedOut({
  final bool isSigningIn = false,
  final Object? error,
}) extends AccountState;

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
