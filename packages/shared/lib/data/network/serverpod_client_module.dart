import 'package:book_marker_client/book_marker_client.dart';
import 'package:core/config/build_config.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

const _fallbackBaseUrl = "http://localhost:8080/";

@module
abstract class ServerpodClientModule {
  @lazySingleton
  FlutterAuthSessionManager sessionManager() => FlutterAuthSessionManager();

  @lazySingleton
  Client client(FlutterAuthSessionManager sessionManager) {
    // * localhost is fine on a simulator or desktop but can never work on a
    // * physical device, and the resulting "connection refused" says nothing
    // * about the missing dart-define, so say it here instead
    if (serverBaseUrl.isEmpty && isInDebugMode) {
      debugPrint(
        "SERVER_BASE_URL is empty, falling back to $_fallbackBaseUrl. "
        "On a physical device pass --dart-define-from-file=dart_defines.json "
        "and rebuild; dart-defines are compile time and survive hot restart.",
      );
    }
    final client = Client(serverBaseUrl.isEmpty ? _fallbackBaseUrl : serverBaseUrl)
      ..connectivityMonitor = FlutterConnectivityMonitor();
    // * the session manager both provides the auth key and needs the client to
    // * refresh it, so the two are wired to each other after construction
    sessionManager.setCaller(client.modules.serverpod_auth_core);
    client.authKeyProvider = sessionManager;
    return client;
  }
}
