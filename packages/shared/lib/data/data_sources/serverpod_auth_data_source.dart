import 'dart:async';

import 'package:book_marker_client/book_marker_client.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:shared/data/models/remote_account.dart';

// * the session manager validates against the server on restore; this app must
// * open instantly offline, so the wait is short and failure is not fatal
const _restoreTimeout = Duration(seconds: 2);

// * the only place Serverpod's auth types are used; everything above this file
// * sees RemoteAccount and plain futures
abstract class ServerpodAuthDataSource {
  Stream<RemoteAccount?> watchAccount();

  Future<void> restoreSession();

  Future<RemoteAccount> signInWithGoogle();

  Future<RemoteAccount> signInWithApple();

  Future<void> signOut({required bool allDevices});

  Future<void> deleteAccount();
}

@Injectable(as: ServerpodAuthDataSource)
class const ServerpodAuthDataSourceImpl(
  final Client _client,
  final FlutterAuthSessionManager _sessionManager,
) implements ServerpodAuthDataSource {
  @override
  Stream<RemoteAccount?> watchAccount() {
    final controller = StreamController<RemoteAccount?>.broadcast();
    void emit() => unawaited(_emitAccount(controller));
    _sessionManager.authInfoListenable.addListener(emit);
    controller
      ..onListen = emit
      ..onCancel = () => _sessionManager.authInfoListenable.removeListener(emit);
    return controller.stream;
  }

  Future<void> _emitAccount(StreamController<RemoteAccount?> controller) async {
    if (controller.isClosed) return;
    controller.add(await _currentAccount());
  }

  // * the session carries only the id; name and e-mail need a second call, and
  // * a profile that cannot be fetched still yields an account, just unnamed
  Future<RemoteAccount?> _currentAccount() async {
    final authInfo = _sessionManager.authInfo;
    if (authInfo == null) return null;
    final id = authInfo.authUserId.toString();
    try {
      final profile = await _client.modules.serverpod_auth_core.userProfileInfo.get();
      return RemoteAccount(
        id: id,
        fullName: profile.fullName,
        userName: profile.userName,
        email: profile.email,
      );
    } on Object {
      return RemoteAccount(id: id, fullName: null, userName: null, email: null);
    }
  }

  @override
  Future<void> restoreSession() async {
    await _sessionManager.initialize(timeout: _restoreTimeout);
  }

  @override
  Future<RemoteAccount> signInWithGoogle() => _signIn(_googleController);

  @override
  Future<RemoteAccount> signInWithApple() => _signIn(_appleController);

  @override
  Future<void> signOut({required bool allDevices}) async {
    if (allDevices) {
      await _sessionManager.signOutAllDevices();
      return;
    }
    await _sessionManager.signOutDevice();
  }

  @override
  Future<void> deleteAccount() => _client.account.delete();

  _SignInHandle _googleController(VoidCallback onDone, _OnError onError) {
    final controller = GoogleAuthController(
      client: _client,
      onAuthenticated: onDone,
      onError: onError,
    );
    return (signIn: controller.signIn, dispose: controller.dispose);
  }

  _SignInHandle _appleController(VoidCallback onDone, _OnError onError) {
    final controller = AppleAuthController(
      client: _client,
      onAuthenticated: onDone,
      onError: onError,
    );
    return (signIn: controller.signIn, dispose: controller.dispose);
  }

  // * the SDK controllers report through callbacks, not futures; this adapts
  // * one sign-in attempt into a single awaitable
  Future<RemoteAccount> _signIn(_ControllerBuilder build) async {
    final completer = Completer<void>();
    final handle = build(
      () {
        if (!completer.isCompleted) completer.complete();
      },
      (error) {
        if (!completer.isCompleted) completer.completeError(error);
      },
    );
    try {
      await handle.signIn();
      await completer.future;
    } finally {
      handle.dispose();
    }
    final account = await _currentAccount();
    if (account == null) throw const _SignInIncompleteException();
    return account;
  }
}

typedef _OnError = void Function(Object error);
typedef _SignInHandle = ({Future<void> Function() signIn, void Function() dispose});
typedef _ControllerBuilder = _SignInHandle Function(VoidCallback onDone, _OnError onError);

class const _SignInIncompleteException() implements Exception;
