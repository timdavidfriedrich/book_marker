// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'plan_limits.dart';

class PlanLimitsMapper extends ClassMapperBase<PlanLimits> {
  PlanLimitsMapper._();

  static PlanLimitsMapper? _instance;
  static PlanLimitsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlanLimitsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PlanLimits';

  static int _$ocrPerDay(PlanLimits v) => v.ocrPerDay;
  static const Field<PlanLimits, int> _f$ocrPerDay = Field(
    'ocrPerDay',
    _$ocrPerDay,
  );
  static int _$ocrPerWeek(PlanLimits v) => v.ocrPerWeek;
  static const Field<PlanLimits, int> _f$ocrPerWeek = Field(
    'ocrPerWeek',
    _$ocrPerWeek,
  );
  static int _$ocrPerMonth(PlanLimits v) => v.ocrPerMonth;
  static const Field<PlanLimits, int> _f$ocrPerMonth = Field(
    'ocrPerMonth',
    _$ocrPerMonth,
  );
  static int _$maxImageBytes(PlanLimits v) => v.maxImageBytes;
  static const Field<PlanLimits, int> _f$maxImageBytes = Field(
    'maxImageBytes',
    _$maxImageBytes,
  );
  static bool _$attachmentsEnabled(PlanLimits v) => v.attachmentsEnabled;
  static const Field<PlanLimits, bool> _f$attachmentsEnabled = Field(
    'attachmentsEnabled',
    _$attachmentsEnabled,
  );

  @override
  final MappableFields<PlanLimits> fields = const {
    #ocrPerDay: _f$ocrPerDay,
    #ocrPerWeek: _f$ocrPerWeek,
    #ocrPerMonth: _f$ocrPerMonth,
    #maxImageBytes: _f$maxImageBytes,
    #attachmentsEnabled: _f$attachmentsEnabled,
  };

  static PlanLimits _instantiate(DecodingData data) {
    return PlanLimits(
      ocrPerDay: data.dec(_f$ocrPerDay),
      ocrPerWeek: data.dec(_f$ocrPerWeek),
      ocrPerMonth: data.dec(_f$ocrPerMonth),
      maxImageBytes: data.dec(_f$maxImageBytes),
      attachmentsEnabled: data.dec(_f$attachmentsEnabled),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PlanLimits fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PlanLimits>(map);
  }

  static PlanLimits fromJson(String json) {
    return ensureInitialized().decodeJson<PlanLimits>(json);
  }
}

mixin PlanLimitsMappable {
  String toJson() {
    return PlanLimitsMapper.ensureInitialized().encodeJson<PlanLimits>(
      this as PlanLimits,
    );
  }

  Map<String, dynamic> toMap() {
    return PlanLimitsMapper.ensureInitialized().encodeMap<PlanLimits>(
      this as PlanLimits,
    );
  }

  PlanLimitsCopyWith<PlanLimits, PlanLimits, PlanLimits> get copyWith =>
      _PlanLimitsCopyWithImpl<PlanLimits, PlanLimits>(
        this as PlanLimits,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PlanLimitsMapper.ensureInitialized().stringifyValue(
      this as PlanLimits,
    );
  }

  @override
  bool operator ==(Object other) {
    return PlanLimitsMapper.ensureInitialized().equalsValue(
      this as PlanLimits,
      other,
    );
  }

  @override
  int get hashCode {
    return PlanLimitsMapper.ensureInitialized().hashValue(this as PlanLimits);
  }
}

extension PlanLimitsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PlanLimits, $Out> {
  PlanLimitsCopyWith<$R, PlanLimits, $Out> get $asPlanLimits =>
      $base.as((v, t, t2) => _PlanLimitsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PlanLimitsCopyWith<$R, $In extends PlanLimits, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? ocrPerDay,
    int? ocrPerWeek,
    int? ocrPerMonth,
    int? maxImageBytes,
    bool? attachmentsEnabled,
  });
  PlanLimitsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PlanLimitsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PlanLimits, $Out>
    implements PlanLimitsCopyWith<$R, PlanLimits, $Out> {
  _PlanLimitsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PlanLimits> $mapper =
      PlanLimitsMapper.ensureInitialized();
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
  PlanLimits $make(CopyWithData data) => PlanLimits(
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
  PlanLimitsCopyWith<$R2, PlanLimits, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PlanLimitsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

