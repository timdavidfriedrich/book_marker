// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'remote_app_config.dart';

class RemoteAppConfigMapper extends ClassMapperBase<RemoteAppConfig> {
  RemoteAppConfigMapper._();

  static RemoteAppConfigMapper? _instance;
  static RemoteAppConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteAppConfigMapper._());
      RemotePlanLimitsMapper.ensureInitialized();
      RemoteRecognitionConfigMapper.ensureInitialized();
      RemoteClientConfigMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteAppConfig';

  static int _$version(RemoteAppConfig v) => v.version;
  static const Field<RemoteAppConfig, int> _f$version = Field(
    'version',
    _$version,
  );
  static RemotePlanLimits _$free(RemoteAppConfig v) => v.free;
  static const Field<RemoteAppConfig, RemotePlanLimits> _f$free = Field(
    'free',
    _$free,
  );
  static RemotePlanLimits _$premium(RemoteAppConfig v) => v.premium;
  static const Field<RemoteAppConfig, RemotePlanLimits> _f$premium = Field(
    'premium',
    _$premium,
  );
  static RemoteRecognitionConfig _$recognition(RemoteAppConfig v) =>
      v.recognition;
  static const Field<RemoteAppConfig, RemoteRecognitionConfig> _f$recognition =
      Field('recognition', _$recognition);
  static RemoteClientConfig _$client(RemoteAppConfig v) => v.client;
  static const Field<RemoteAppConfig, RemoteClientConfig> _f$client = Field(
    'client',
    _$client,
  );

  @override
  final MappableFields<RemoteAppConfig> fields = const {
    #version: _f$version,
    #free: _f$free,
    #premium: _f$premium,
    #recognition: _f$recognition,
    #client: _f$client,
  };

  static RemoteAppConfig _instantiate(DecodingData data) {
    return RemoteAppConfig(
      version: data.dec(_f$version),
      free: data.dec(_f$free),
      premium: data.dec(_f$premium),
      recognition: data.dec(_f$recognition),
      client: data.dec(_f$client),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteAppConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteAppConfig>(map);
  }

  static RemoteAppConfig fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteAppConfig>(json);
  }
}

mixin RemoteAppConfigMappable {
  String toJson() {
    return RemoteAppConfigMapper.ensureInitialized()
        .encodeJson<RemoteAppConfig>(this as RemoteAppConfig);
  }

  Map<String, dynamic> toMap() {
    return RemoteAppConfigMapper.ensureInitialized().encodeMap<RemoteAppConfig>(
      this as RemoteAppConfig,
    );
  }

  RemoteAppConfigCopyWith<RemoteAppConfig, RemoteAppConfig, RemoteAppConfig>
  get copyWith =>
      _RemoteAppConfigCopyWithImpl<RemoteAppConfig, RemoteAppConfig>(
        this as RemoteAppConfig,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return RemoteAppConfigMapper.ensureInitialized().stringifyValue(
      this as RemoteAppConfig,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteAppConfigMapper.ensureInitialized().equalsValue(
      this as RemoteAppConfig,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteAppConfigMapper.ensureInitialized().hashValue(
      this as RemoteAppConfig,
    );
  }
}

extension RemoteAppConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteAppConfig, $Out> {
  RemoteAppConfigCopyWith<$R, RemoteAppConfig, $Out> get $asRemoteAppConfig =>
      $base.as((v, t, t2) => _RemoteAppConfigCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RemoteAppConfigCopyWith<$R, $In extends RemoteAppConfig, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  RemotePlanLimitsCopyWith<$R, RemotePlanLimits, RemotePlanLimits> get free;
  RemotePlanLimitsCopyWith<$R, RemotePlanLimits, RemotePlanLimits> get premium;
  RemoteRecognitionConfigCopyWith<
    $R,
    RemoteRecognitionConfig,
    RemoteRecognitionConfig
  >
  get recognition;
  RemoteClientConfigCopyWith<$R, RemoteClientConfig, RemoteClientConfig>
  get client;
  $R call({
    int? version,
    RemotePlanLimits? free,
    RemotePlanLimits? premium,
    RemoteRecognitionConfig? recognition,
    RemoteClientConfig? client,
  });
  RemoteAppConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteAppConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteAppConfig, $Out>
    implements RemoteAppConfigCopyWith<$R, RemoteAppConfig, $Out> {
  _RemoteAppConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteAppConfig> $mapper =
      RemoteAppConfigMapper.ensureInitialized();
  @override
  RemotePlanLimitsCopyWith<$R, RemotePlanLimits, RemotePlanLimits> get free =>
      $value.free.copyWith.$chain((v) => call(free: v));
  @override
  RemotePlanLimitsCopyWith<$R, RemotePlanLimits, RemotePlanLimits>
  get premium => $value.premium.copyWith.$chain((v) => call(premium: v));
  @override
  RemoteRecognitionConfigCopyWith<
    $R,
    RemoteRecognitionConfig,
    RemoteRecognitionConfig
  >
  get recognition =>
      $value.recognition.copyWith.$chain((v) => call(recognition: v));
  @override
  RemoteClientConfigCopyWith<$R, RemoteClientConfig, RemoteClientConfig>
  get client => $value.client.copyWith.$chain((v) => call(client: v));
  @override
  $R call({
    int? version,
    RemotePlanLimits? free,
    RemotePlanLimits? premium,
    RemoteRecognitionConfig? recognition,
    RemoteClientConfig? client,
  }) => $apply(
    FieldCopyWithData({
      if (version != null) #version: version,
      if (free != null) #free: free,
      if (premium != null) #premium: premium,
      if (recognition != null) #recognition: recognition,
      if (client != null) #client: client,
    }),
  );
  @override
  RemoteAppConfig $make(CopyWithData data) => RemoteAppConfig(
    version: data.get(#version, or: $value.version),
    free: data.get(#free, or: $value.free),
    premium: data.get(#premium, or: $value.premium),
    recognition: data.get(#recognition, or: $value.recognition),
    client: data.get(#client, or: $value.client),
  );

  @override
  RemoteAppConfigCopyWith<$R2, RemoteAppConfig, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _RemoteAppConfigCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RemotePlanLimitsMapper extends ClassMapperBase<RemotePlanLimits> {
  RemotePlanLimitsMapper._();

  static RemotePlanLimitsMapper? _instance;
  static RemotePlanLimitsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemotePlanLimitsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RemotePlanLimits';

  static int _$ocrPerDay(RemotePlanLimits v) => v.ocrPerDay;
  static const Field<RemotePlanLimits, int> _f$ocrPerDay = Field(
    'ocrPerDay',
    _$ocrPerDay,
  );
  static int _$ocrPerWeek(RemotePlanLimits v) => v.ocrPerWeek;
  static const Field<RemotePlanLimits, int> _f$ocrPerWeek = Field(
    'ocrPerWeek',
    _$ocrPerWeek,
  );
  static int _$ocrPerMonth(RemotePlanLimits v) => v.ocrPerMonth;
  static const Field<RemotePlanLimits, int> _f$ocrPerMonth = Field(
    'ocrPerMonth',
    _$ocrPerMonth,
  );
  static int _$maxImageBytes(RemotePlanLimits v) => v.maxImageBytes;
  static const Field<RemotePlanLimits, int> _f$maxImageBytes = Field(
    'maxImageBytes',
    _$maxImageBytes,
  );
  static bool _$attachmentsEnabled(RemotePlanLimits v) => v.attachmentsEnabled;
  static const Field<RemotePlanLimits, bool> _f$attachmentsEnabled = Field(
    'attachmentsEnabled',
    _$attachmentsEnabled,
  );

  @override
  final MappableFields<RemotePlanLimits> fields = const {
    #ocrPerDay: _f$ocrPerDay,
    #ocrPerWeek: _f$ocrPerWeek,
    #ocrPerMonth: _f$ocrPerMonth,
    #maxImageBytes: _f$maxImageBytes,
    #attachmentsEnabled: _f$attachmentsEnabled,
  };

  static RemotePlanLimits _instantiate(DecodingData data) {
    return RemotePlanLimits(
      ocrPerDay: data.dec(_f$ocrPerDay),
      ocrPerWeek: data.dec(_f$ocrPerWeek),
      ocrPerMonth: data.dec(_f$ocrPerMonth),
      maxImageBytes: data.dec(_f$maxImageBytes),
      attachmentsEnabled: data.dec(_f$attachmentsEnabled),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemotePlanLimits fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemotePlanLimits>(map);
  }

  static RemotePlanLimits fromJson(String json) {
    return ensureInitialized().decodeJson<RemotePlanLimits>(json);
  }
}

mixin RemotePlanLimitsMappable {
  String toJson() {
    return RemotePlanLimitsMapper.ensureInitialized()
        .encodeJson<RemotePlanLimits>(this as RemotePlanLimits);
  }

  Map<String, dynamic> toMap() {
    return RemotePlanLimitsMapper.ensureInitialized()
        .encodeMap<RemotePlanLimits>(this as RemotePlanLimits);
  }

  RemotePlanLimitsCopyWith<RemotePlanLimits, RemotePlanLimits, RemotePlanLimits>
  get copyWith =>
      _RemotePlanLimitsCopyWithImpl<RemotePlanLimits, RemotePlanLimits>(
        this as RemotePlanLimits,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return RemotePlanLimitsMapper.ensureInitialized().stringifyValue(
      this as RemotePlanLimits,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemotePlanLimitsMapper.ensureInitialized().equalsValue(
      this as RemotePlanLimits,
      other,
    );
  }

  @override
  int get hashCode {
    return RemotePlanLimitsMapper.ensureInitialized().hashValue(
      this as RemotePlanLimits,
    );
  }
}

extension RemotePlanLimitsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemotePlanLimits, $Out> {
  RemotePlanLimitsCopyWith<$R, RemotePlanLimits, $Out>
  get $asRemotePlanLimits =>
      $base.as((v, t, t2) => _RemotePlanLimitsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RemotePlanLimitsCopyWith<$R, $In extends RemotePlanLimits, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? ocrPerDay,
    int? ocrPerWeek,
    int? ocrPerMonth,
    int? maxImageBytes,
    bool? attachmentsEnabled,
  });
  RemotePlanLimitsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemotePlanLimitsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemotePlanLimits, $Out>
    implements RemotePlanLimitsCopyWith<$R, RemotePlanLimits, $Out> {
  _RemotePlanLimitsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemotePlanLimits> $mapper =
      RemotePlanLimitsMapper.ensureInitialized();
  @override
  $R call({
    int? ocrPerDay,
    int? ocrPerWeek,
    int? ocrPerMonth,
    int? maxImageBytes,
    bool? attachmentsEnabled,
  }) => $apply(
    FieldCopyWithData({
      if (ocrPerDay != null) #ocrPerDay: ocrPerDay,
      if (ocrPerWeek != null) #ocrPerWeek: ocrPerWeek,
      if (ocrPerMonth != null) #ocrPerMonth: ocrPerMonth,
      if (maxImageBytes != null) #maxImageBytes: maxImageBytes,
      if (attachmentsEnabled != null) #attachmentsEnabled: attachmentsEnabled,
    }),
  );
  @override
  RemotePlanLimits $make(CopyWithData data) => RemotePlanLimits(
    ocrPerDay: data.get(#ocrPerDay, or: $value.ocrPerDay),
    ocrPerWeek: data.get(#ocrPerWeek, or: $value.ocrPerWeek),
    ocrPerMonth: data.get(#ocrPerMonth, or: $value.ocrPerMonth),
    maxImageBytes: data.get(#maxImageBytes, or: $value.maxImageBytes),
    attachmentsEnabled: data.get(
      #attachmentsEnabled,
      or: $value.attachmentsEnabled,
    ),
  );

  @override
  RemotePlanLimitsCopyWith<$R2, RemotePlanLimits, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _RemotePlanLimitsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RemoteRecognitionConfigMapper
    extends ClassMapperBase<RemoteRecognitionConfig> {
  RemoteRecognitionConfigMapper._();

  static RemoteRecognitionConfigMapper? _instance;
  static RemoteRecognitionConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = RemoteRecognitionConfigMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteRecognitionConfig';

  static String _$provider(RemoteRecognitionConfig v) => v.provider;
  static const Field<RemoteRecognitionConfig, String> _f$provider = Field(
    'provider',
    _$provider,
  );
  static bool _$cloudEnabledByDefault(RemoteRecognitionConfig v) =>
      v.cloudEnabledByDefault;
  static const Field<RemoteRecognitionConfig, bool> _f$cloudEnabledByDefault =
      Field('cloudEnabledByDefault', _$cloudEnabledByDefault);

  @override
  final MappableFields<RemoteRecognitionConfig> fields = const {
    #provider: _f$provider,
    #cloudEnabledByDefault: _f$cloudEnabledByDefault,
  };

  static RemoteRecognitionConfig _instantiate(DecodingData data) {
    return RemoteRecognitionConfig(
      provider: data.dec(_f$provider),
      cloudEnabledByDefault: data.dec(_f$cloudEnabledByDefault),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteRecognitionConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteRecognitionConfig>(map);
  }

  static RemoteRecognitionConfig fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteRecognitionConfig>(json);
  }
}

mixin RemoteRecognitionConfigMappable {
  String toJson() {
    return RemoteRecognitionConfigMapper.ensureInitialized()
        .encodeJson<RemoteRecognitionConfig>(this as RemoteRecognitionConfig);
  }

  Map<String, dynamic> toMap() {
    return RemoteRecognitionConfigMapper.ensureInitialized()
        .encodeMap<RemoteRecognitionConfig>(this as RemoteRecognitionConfig);
  }

  RemoteRecognitionConfigCopyWith<
    RemoteRecognitionConfig,
    RemoteRecognitionConfig,
    RemoteRecognitionConfig
  >
  get copyWith =>
      _RemoteRecognitionConfigCopyWithImpl<
        RemoteRecognitionConfig,
        RemoteRecognitionConfig
      >(this as RemoteRecognitionConfig, $identity, $identity);
  @override
  String toString() {
    return RemoteRecognitionConfigMapper.ensureInitialized().stringifyValue(
      this as RemoteRecognitionConfig,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteRecognitionConfigMapper.ensureInitialized().equalsValue(
      this as RemoteRecognitionConfig,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteRecognitionConfigMapper.ensureInitialized().hashValue(
      this as RemoteRecognitionConfig,
    );
  }
}

extension RemoteRecognitionConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteRecognitionConfig, $Out> {
  RemoteRecognitionConfigCopyWith<$R, RemoteRecognitionConfig, $Out>
  get $asRemoteRecognitionConfig => $base.as(
    (v, t, t2) => _RemoteRecognitionConfigCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RemoteRecognitionConfigCopyWith<
  $R,
  $In extends RemoteRecognitionConfig,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? provider, bool? cloudEnabledByDefault});
  RemoteRecognitionConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteRecognitionConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteRecognitionConfig, $Out>
    implements
        RemoteRecognitionConfigCopyWith<$R, RemoteRecognitionConfig, $Out> {
  _RemoteRecognitionConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteRecognitionConfig> $mapper =
      RemoteRecognitionConfigMapper.ensureInitialized();
  @override
  $R call({String? provider, bool? cloudEnabledByDefault}) => $apply(
    FieldCopyWithData({
      if (provider != null) #provider: provider,
      if (cloudEnabledByDefault != null)
        #cloudEnabledByDefault: cloudEnabledByDefault,
    }),
  );
  @override
  RemoteRecognitionConfig $make(CopyWithData data) => RemoteRecognitionConfig(
    provider: data.get(#provider, or: $value.provider),
    cloudEnabledByDefault: data.get(
      #cloudEnabledByDefault,
      or: $value.cloudEnabledByDefault,
    ),
  );

  @override
  RemoteRecognitionConfigCopyWith<$R2, RemoteRecognitionConfig, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RemoteRecognitionConfigCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RemoteClientConfigMapper extends ClassMapperBase<RemoteClientConfig> {
  RemoteClientConfigMapper._();

  static RemoteClientConfigMapper? _instance;
  static RemoteClientConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteClientConfigMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteClientConfig';

  static String _$minSupportedVersion(RemoteClientConfig v) =>
      v.minSupportedVersion;
  static const Field<RemoteClientConfig, String> _f$minSupportedVersion = Field(
    'minSupportedVersion',
    _$minSupportedVersion,
  );
  static bool _$maintenanceMode(RemoteClientConfig v) => v.maintenanceMode;
  static const Field<RemoteClientConfig, bool> _f$maintenanceMode = Field(
    'maintenanceMode',
    _$maintenanceMode,
  );
  static String? _$maintenanceMessage(RemoteClientConfig v) =>
      v.maintenanceMessage;
  static const Field<RemoteClientConfig, String> _f$maintenanceMessage = Field(
    'maintenanceMessage',
    _$maintenanceMessage,
  );

  @override
  final MappableFields<RemoteClientConfig> fields = const {
    #minSupportedVersion: _f$minSupportedVersion,
    #maintenanceMode: _f$maintenanceMode,
    #maintenanceMessage: _f$maintenanceMessage,
  };

  static RemoteClientConfig _instantiate(DecodingData data) {
    return RemoteClientConfig(
      minSupportedVersion: data.dec(_f$minSupportedVersion),
      maintenanceMode: data.dec(_f$maintenanceMode),
      maintenanceMessage: data.dec(_f$maintenanceMessage),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteClientConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteClientConfig>(map);
  }

  static RemoteClientConfig fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteClientConfig>(json);
  }
}

mixin RemoteClientConfigMappable {
  String toJson() {
    return RemoteClientConfigMapper.ensureInitialized()
        .encodeJson<RemoteClientConfig>(this as RemoteClientConfig);
  }

  Map<String, dynamic> toMap() {
    return RemoteClientConfigMapper.ensureInitialized()
        .encodeMap<RemoteClientConfig>(this as RemoteClientConfig);
  }

  RemoteClientConfigCopyWith<
    RemoteClientConfig,
    RemoteClientConfig,
    RemoteClientConfig
  >
  get copyWith =>
      _RemoteClientConfigCopyWithImpl<RemoteClientConfig, RemoteClientConfig>(
        this as RemoteClientConfig,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return RemoteClientConfigMapper.ensureInitialized().stringifyValue(
      this as RemoteClientConfig,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteClientConfigMapper.ensureInitialized().equalsValue(
      this as RemoteClientConfig,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteClientConfigMapper.ensureInitialized().hashValue(
      this as RemoteClientConfig,
    );
  }
}

extension RemoteClientConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteClientConfig, $Out> {
  RemoteClientConfigCopyWith<$R, RemoteClientConfig, $Out>
  get $asRemoteClientConfig => $base.as(
    (v, t, t2) => _RemoteClientConfigCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RemoteClientConfigCopyWith<
  $R,
  $In extends RemoteClientConfig,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? minSupportedVersion,
    bool? maintenanceMode,
    String? maintenanceMessage,
  });
  RemoteClientConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteClientConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteClientConfig, $Out>
    implements RemoteClientConfigCopyWith<$R, RemoteClientConfig, $Out> {
  _RemoteClientConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteClientConfig> $mapper =
      RemoteClientConfigMapper.ensureInitialized();
  @override
  $R call({
    String? minSupportedVersion,
    bool? maintenanceMode,
    Object? maintenanceMessage = $none,
  }) => $apply(
    FieldCopyWithData({
      if (minSupportedVersion != null)
        #minSupportedVersion: minSupportedVersion,
      if (maintenanceMode != null) #maintenanceMode: maintenanceMode,
      if (maintenanceMessage != $none) #maintenanceMessage: maintenanceMessage,
    }),
  );
  @override
  RemoteClientConfig $make(CopyWithData data) => RemoteClientConfig(
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
  RemoteClientConfigCopyWith<$R2, RemoteClientConfig, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _RemoteClientConfigCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

