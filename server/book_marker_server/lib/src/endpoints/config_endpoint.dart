import 'package:serverpod/serverpod.dart';

import '../domain/config_source.dart';
import '../generated/protocol.dart';

const _config = ConfigSource();

/// Serves the runtime configuration to the app.
///
/// Deliberately unauthenticated. `maintenanceMode` and `minSupportedVersion`
/// have to reach a client that cannot sign in, which is the situation they
/// exist for, and the file holds nothing that is not already visible in a
/// decompiled APK.
class ConfigEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<RuntimeConfig> fetch(final Session session) async => _config.read();
}
