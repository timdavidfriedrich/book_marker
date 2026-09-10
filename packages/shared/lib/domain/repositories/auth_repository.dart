import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/account.dart';

abstract class AuthRepository {
  Stream<AppResult<Account?>> watchAccount();

  Future<AppResult<()>> restoreSession();

  Future<AppResult<Account>> signInWithGoogle();

  Future<AppResult<Account>> signInWithApple();

  Future<AppResult<()>> signOut({required bool allDevices});
}
