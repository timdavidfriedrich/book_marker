import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/models/remote_app_config.dart';
import 'package:shared/domain/entities/app_config.dart';
import 'package:shared/domain/entities/plan_limits.dart';

const _cacheRowId = 0;

extension RemoteAppConfigMappers on RemoteAppConfig {
  AppConfig toAppConfig() {
    return AppConfig(
      version: version,
      free: free.toPlanLimits(),
      premium: premium.toPlanLimits(),
      cloudRecognitionEnabledByDefault: recognition.cloudEnabledByDefault,
      minSupportedVersion: client.minSupportedVersion,
      maintenanceMode: client.maintenanceMode,
      maintenanceMessage: client.maintenanceMessage,
    );
  }

  LocalAppConfigCache toLocalAppConfigCache(DateTime fetchedAt) {
    return LocalAppConfigCache(
      id: _cacheRowId,
      version: version,
      fetchedAt: fetchedAt,
      payload: toJson(),
    );
  }
}

extension LocalAppConfigCacheMappers on LocalAppConfigCache {
  AppConfig toAppConfig() {
    try {
      return RemoteAppConfigMapper.fromJson(payload).toAppConfig();
    } on Object {
      // * a payload written by an older build can no longer be read. The
      // * compiled in defaults always are, and the next refresh replaces it
      return defaultAppConfig;
    }
  }
}

extension RemotePlanLimitsMappers on RemotePlanLimits {
  PlanLimits toPlanLimits() {
    return PlanLimits(
      ocrPerDay: ocrPerDay,
      ocrPerWeek: ocrPerWeek,
      ocrPerMonth: ocrPerMonth,
      maxImageBytes: maxImageBytes,
      attachmentsEnabled: attachmentsEnabled,
    );
  }
}
