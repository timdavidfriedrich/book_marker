import 'package:book_marker_client/book_marker_client.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/models/remote_app_config.dart';

// * the only place the generated runtime config types are used; everything
// * above this file sees RemoteAppConfig
abstract class AppConfigRemoteDataSource {
  Future<RemoteAppConfig> fetchConfig();
}

@Injectable(as: AppConfigRemoteDataSource)
class const AppConfigRemoteDataSourceImpl(
  final Client _client,
) implements AppConfigRemoteDataSource {
  @override
  Future<RemoteAppConfig> fetchConfig() async {
    final config = await _client.config.fetch();
    return RemoteAppConfig(
      version: config.version,
      free: _toRemotePlanLimits(config.free),
      premium: _toRemotePlanLimits(config.premium),
      recognition: RemoteRecognitionConfig(
        provider: config.recognition.provider,
        cloudEnabledByDefault: config.recognition.cloudEnabledByDefault,
      ),
      client: RemoteClientConfig(
        minSupportedVersion: config.client.minSupportedVersion,
        maintenanceMode: config.client.maintenanceMode,
        maintenanceMessage: config.client.maintenanceMessage,
      ),
    );
  }
}

RemotePlanLimits _toRemotePlanLimits(PlanLimits limits) {
  return RemotePlanLimits(
    ocrPerDay: limits.ocrPerDay,
    ocrPerWeek: limits.ocrPerWeek,
    ocrPerMonth: limits.ocrPerMonth,
    maxImageBytes: limits.maxImageBytes,
    attachmentsEnabled: limits.attachmentsEnabled,
  );
}
