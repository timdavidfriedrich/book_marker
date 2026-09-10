import 'package:dart_mappable/dart_mappable.dart';

part 'remote_app_config.mapper.dart';

// * mirrors app_config.yaml one to one, including its nesting, because this is
// * also the shape written to the local cache. Flattening happens in the mapper
@MappableClass()
class const RemoteAppConfig({
  required final int version,
  required final RemotePlanLimits free,
  required final RemotePlanLimits premium,
  required final RemoteRecognitionConfig recognition,
  required final RemoteClientConfig client,
}) with RemoteAppConfigMappable;

@MappableClass()
class const RemotePlanLimits({
  required final int ocrPerDay,
  required final int ocrPerWeek,
  required final int ocrPerMonth,
  required final int maxImageBytes,
  required final bool attachmentsEnabled,
}) with RemotePlanLimitsMappable;

@MappableClass()
class const RemoteRecognitionConfig({
  required final String provider,
  required final bool cloudEnabledByDefault,
}) with RemoteRecognitionConfigMappable;

@MappableClass()
class const RemoteClientConfig({
  required final String minSupportedVersion,
  required final bool maintenanceMode,
  required final String? maintenanceMessage,
}) with RemoteClientConfigMappable;
