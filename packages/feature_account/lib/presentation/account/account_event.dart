import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/account.dart';

sealed class AccountEvent {
  const AccountEvent();
}

class const AccountStarted() extends AccountEvent;

class const AccountUpdated(final AppResult<Account?> result) extends AccountEvent;

class const AccountGoogleSignInRequested() extends AccountEvent;

class const AccountAppleSignInRequested() extends AccountEvent;

class const AccountSignOutRequested({
  required final bool removesLocalData,
}) extends AccountEvent;

class const AccountUnlocked() extends AccountEvent;
