import 'dart:io';

import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/apple.dart';
import 'package:serverpod_auth_idp_server/providers/google.dart';
import 'package:serverpod_cloud_storage/serverpod_cloud_storage.dart';

import 'src/cache_busting.dart';
import 'src/domain/entitlements.dart';
import 'src/generated/serverpod.dart';
import 'src/web/routes/app_config_route.dart';

const _entitlements = Entitlements();

/// Google and Apple only, deliberately. No passwords are stored anywhere, which
/// removes the credential-breach surface entirely, and no identity data leaves
/// this server. Adding the email provider later means taking on an SMTP service
/// and password hashes - read the plan before doing it.
///
/// Apple ships alongside Google because App Store review requires Sign in with
/// Apple wherever another social sign-in is offered.
///
/// A provider is only registered when its credentials are present, so a machine
/// without OAuth setup can still run migrations and boot the server. Production
/// refuses to start instead, because silently having no way to sign in is worse
/// than crashing.
List<IdentityProviderBuilder> _identityProviders(final Serverpod pod) {
  final hasGoogle = pod.getPassword('googleClientSecret') != null;
  final hasApple = pod.getPassword('appleServiceIdentifier') != null;

  if (pod.runMode == ServerpodRunMode.production && !(hasGoogle && hasApple)) {
    throw StateError(
      'Production requires both identity providers. Missing: '
      '${[if (!hasGoogle) 'googleClientSecret', if (!hasApple) 'apple* keys'].join(', ')} '
      'in config/passwords.yaml.',
    );
  }

  return [
    if (hasGoogle)
      GoogleIdpConfigFromPasswords(
        onAfterGoogleAccountCreated: (session, authUser, _, {transaction}) =>
            _entitlements.createForUser(
              session,
              authUser.id,
              transaction: transaction,
            ),
      ),
    if (hasApple)
      AppleIdpConfigFromPasswords(
        onAfterAppleAccountCreated: (session, authUser, _, {transaction}) =>
            _entitlements.createForUser(
              session,
              authUser.id,
              transaction: transaction,
            ),
      ),
  ];
}

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod. The generated Serverpod class is already connected
  // with your project's generated code.
  final pod = Serverpod(args);

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: _identityProviders(pod),
  );

  // Serve all files in the web/static relative directory under /web.
  // These are used by the default web page.
  pod.webServer.addRoute(
    StaticRoute.withCacheBusting(cacheBustingConfig),
    cacheBustingConfig.mountPrefix,
  );

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app.
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/assets/assets/config.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // Serve the flutter web app under /.
    pod.webServer.addRoute(
      FlutterRoute(
        appDir,
        // If building the Flutter app with WASM, set the below parameter to
        // true and add the --wasm flag to the flutter build command.
        enableWasmHeaders: false,
      ),
      '/',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    final defaultRoute = StaticRoute.file(
      File(
        Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
      ),
    );

    pod.webServer.addMiddleware(
      FallbackMiddleware(
        fallback: defaultRoute,
        on: (response) => response.statusCode == 404,
      ).call,
      '/',
    );

    pod.webServer.addRoute(
      defaultRoute,
      '/**',
    );
  }

  // Configure cloud storage.
  // This setup works with Serverpod Cloud without extra configuration.
  // If you want to use a custom provider for cloud storage, replace these
  // with your preferred provider.
  pod.addCloudStorage(
    await ServerpodCloudProvider.private(
      fallback: () => DatabaseCloudStorage('private'),
    ),
  );
  pod.addCloudStorage(
    await ServerpodCloudProvider.public(
      fallback: () => DatabaseCloudStorage('public'),
    ),
  );

  // Start the server.
  await pod.start();
}
