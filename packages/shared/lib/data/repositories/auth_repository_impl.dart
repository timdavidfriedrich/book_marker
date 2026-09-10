import 'package:book_marker_client/book_marker_client.dart';
import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/serverpod_auth_data_source.dart';
import 'package:shared/data/mappers/account_mappers.dart';
import 'package:shared/data/models/remote_account.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class const AuthRepositoryImpl(
  final ServerpodAuthDataSource _dataSource,
) implements AuthRepository {
  @override
  Stream<AppResult<Account?>> watchAccount() {
    return _dataSource
        .watchAccount()
        .map<AppResult<Account?>>((remote) => Success(remote?.toAccount()))
        .handleError((Object _) => const Failure<Account?>(UnexpectedError()));
  }

  @override
  Future<AppResult<()>> restoreSession() async {
    try {
      await _dataSource.restoreSession();
      return const Success(());
    } on Object {
      // * a restore that cannot reach the server is not a failure; the session
      // * is still valid locally and revalidates on the next authenticated call
      return const Success(());
    }
  }

  @override
  Future<AppResult<Account>> signInWithGoogle() => _signIn(_dataSource.signInWithGoogle);

  @override
  Future<AppResult<Account>> signInWithApple() => _signIn(_dataSource.signInWithApple);

  @override
  Future<AppResult<()>> signOut({required bool allDevices}) async {
    try {
      await _dataSource.signOut(allDevices: allDevices);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  Future<AppResult<Account>> _signIn(Future<RemoteAccount> Function() signIn) async {
    try {
      return Success((await signIn()).toAccount());
    } on AccountBlockedException catch (exception) {
      return Failure(AccountBlockedError(exception.reason));
    } on Object catch (error) {
      return Failure(_toAppError(error));
    }
  }
}

AppError _toAppError(Object error) {
  final message = error.toString().toLowerCase();
  if (message.contains(_cancelledMarker) || message.contains(_abortedMarker)) {
    return const SignInCancelledError();
  }
  if (message.contains(_networkMarker) || message.contains(_socketMarker)) {
    return const ConnectionError();
  }
  return const UnexpectedError();
}

const _cancelledMarker = "cancel";
const _abortedMarker = "abort";
const _networkMarker = "network";
const _socketMarker = "socket";
