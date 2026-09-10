import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/plan_limits.dart';

part 'app_config.mapper.dart';

const _defaultMaxImageBytes = 2097152;

@MappableClass()
class const AppConfig({
  required final int version,
  required final PlanLimits free,
  required final PlanLimits premium,
  required final bool cloudRecognitionEnabledByDefault,
  required final String minSupportedVersion,
  required final bool maintenanceMode,
  required final String? maintenanceMessage,
}) with AppConfigMappable;

// * used until the server has been reached once, so it must never lock anyone
// * out: no maintenance, and a minimum version below every build that exists.
// * The limits mirror app_config.yaml only so the UI shows plausible numbers;
// * the server is authoritative on every actual decision.
const defaultAppConfig = AppConfig(
  version: 0,
  free: PlanLimits(
    ocrPerDay: 3,
    ocrPerWeek: 10,
    ocrPerMonth: 20,
    maxImageBytes: _defaultMaxImageBytes,
    attachmentsEnabled: false,
  ),
  premium: PlanLimits(
    ocrPerDay: 50,
    ocrPerWeek: 250,
    ocrPerMonth: 500,
    maxImageBytes: _defaultMaxImageBytes,
    attachmentsEnabled: true,
  ),
  cloudRecognitionEnabledByDefault: true,
  minSupportedVersion: "0.0.0",
  maintenanceMode: false,
  maintenanceMessage: null,
);
