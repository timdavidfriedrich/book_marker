// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'app_config.dart';

class AppConfigMapper extends ClassMapperBase<AppConfig> {
  AppConfigMapper._();

  static AppConfigMapper? _instance;
  static AppConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppConfigMapper._());
      PlanLimitsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppConfig';

  static int _$version(AppConfig v) => v.version;
  static const Field<AppConfig, int> _f$version = Field('version', _$version);
  static PlanLimits _$free(AppConfig v) => v.free;
  static const Field<AppConfig, PlanLimits> _f$free = Field('free', _$free);
  static PlanLimits _$premium(AppConfig v) => v.premium;
  static const Field<AppConfig, PlanLimits> _f$premium = Field(
    'premium',
    _$premium,
  );
  static bool _$cloudRecognitionEnabledByDefault(AppConfig v) =>
      v.cloudRecognitionEnabledByDefault;
  static const Field<AppConfig, bool> _f$cloudRecognitionEnabledByDefault =
      Field(
        'cloudRecognitionEnabledByDefault',
        _$cloudRecognitionEnabledByDefault,
      );
  static String _$minSupportedVersion(AppConfig v) => v.minSupportedVersion;
  static const Field<AppConfig, String> _f$minSupportedVersion = Field(
    'minSupportedVersion',
    _$minSupportedVersion,
  );
  static bool _$maintenanceMode(AppConfig v) => v.maintenanceMode;
  static const Field<AppConfig, bool> _f$maintenanceMode = Field(
    'maintenanceMode',
    _$maintenanceMode,
  );
  static String? _$maintenanceMessage(AppConfig v) => v.maintenanceMessage;
  static const Field<AppConfig, String> _f$maintenanceMessage = Field(
    'maintenanceMessage',
    _$maintenanceMessage,
  );

  @override
  final MappableFields<AppConfig> fields = const {
    #version: _f$version,
    #free: _f$free,
    #premium: _f$premium,
    #cloudRecognitionEnabledByDefault: _f$cloudRecognitionEnabledByDefault,
    #minSupportedVersion: _f$minSupportedVersion,
    #maintenanceMode: _f$maintenanceMode,
    #maintenanceMessage: _f$maintenanceMessage,
  };

  static AppConfig _instantiate(DecodingData data) {
    return AppConfig(
      version: data.dec(_f$version),
      free: data.dec(_f$free),
      premium: data.dec(_f$premium),
      cloudRecognitionEnabledByDefault: data.dec(
        _f$cloudRecognitionEnabledByDefault,
      ),
      minSupportedVersion: data.dec(_f$minSupportedVersion),
      maintenanceMode: data.dec(_f$maintenanceMode),
      maintenanceMessage: data.dec(_f$maintenanceMessage),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppConfig>(map);
  }

  static AppConfig fromJson(String json) {
    return ensureInitialized().decodeJson<AppConfig>(json);
  }
}

mixin AppConfigMappable {
  String toJson() {
    return AppConfigMapper.ensureInitialized().encodeJson<AppConfig>(
      this as AppConfig,
    );
  }

  Map<String, dynamic> toMap() {
    return AppConfigMapper.ensureInitialized().encodeMap<AppConfig>(
      this as AppConfig,
    );
  }

  AppConfigCopyWith<AppConfig, AppConfig, AppConfig> get copyWith =>
      _AppConfigCopyWithImpl<AppConfig, AppConfig>(
        this as AppConfig,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AppConfigMapper.ensureInitialized().stringifyValue(
      this as AppConfig,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppConfigMapper.ensureInitialized().equalsValue(
      this as AppConfig,
      other,
    );
  }

  @override
  int get hashCode {
    return AppConfigMapper.ensureInitialized().hashValue(this as AppConfig);
  }
}

extension AppConfigValueCopy<$R, $Out> on ObjectCopyWith<$R, AppConfig, $Out> {
  AppConfigCopyWith<$R, AppConfig, $Out> get $asAppConfig =>
      $base.as((v, t, t2) => _AppConfigCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppConfigCopyWith<$R, $In extends AppConfig, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PlanLimitsCopyWith<$R, PlanLimits, PlanLimits> get free;
  PlanLimitsCopyWith<$R, PlanLimits, PlanLimits> get premium;
  $R call({
    int? version,
    PlanLimits? free,
    PlanLimits? premium,
    bool? cloudRecognitionEnabledByDefault,
    String? minSupportedVersion,
    bool? maintenanceMode,
    String? maintenanceMessage,
  });
  AppConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AppConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppConfig, $Out>
    implements AppConfigCopyWith<$R, AppConfig, $Out> {
  _AppConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppConfig> $mapper =
      AppConfigMapper.ensureInitialized();
  @override
  PlanLimitsCopyWith<$R, PlanLimits, PlanLimits> get free =>
      $value.free.copyWith.$chain((v) => call(free: v));
  @override
  PlanLimitsCopyWith<$R, PlanLimits, PlanLimits> get premium =>
      $value.premium.copyWith.$chain((v) => call(premium: v));
  @override
  $R call({
    int? version,
    PlanLimits? free,
    PlanLimits? premium,
    bool? cloudRecognitionEnabledByDefault,
    String? minSupportedVersion,
    bool? maintenanceMode,
    Object? maintenanceMessage = $none,
  }) => $apply(
    FieldCopyWithData({
      if (version != null) #version: version,
      if (free != null) #free: free,
      if (premium != null) #premium: premium,
      if (cloudRecognitionEnabledByDefault != null)
        #cloudRecognitionEnabledByDefault: cloudRecognitionEnabledByDefault,
      if (minSupportedVersion != null)
        #minSupportedVersion: minSupportedVersion,
      if (maintenanceMode != null) #maintenanceMode: maintenanceMode,
      if (maintenanceMessage != $none) #maintenanceMessage: maintenanceMessage,
    }),
  );
  @override
  AppConfig $make(CopyWithData data) => AppConfig(
    version: data.get(#version, or: $value.version),
    free: data.get(#free, or: $value.free),
    premium: data.get(#premium, or: $value.premium),
    cloudRecognitionEnabledByDefault: data.get(
      #cloudRecognitionEnabledByDefault,
      or: $value.cloudRecognitionEnabledByDefault,
    ),
    minSupportedVersion: data.get(
      #minSupportedVersion,
      or: $value.minSupportedVersion,
    ),
    maintenanceMode: data.get(#maintenanceMode, or: $value.maintenanceMode),
    maintenanceMessage: data.get(
      #maintenanceMessage,
      or: $value.maintenanceMessage,
    ),
  );

  @override
  AppConfigCopyWith<$R2, AppConfig, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppConfigCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

