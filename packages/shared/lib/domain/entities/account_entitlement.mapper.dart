// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'account_entitlement.dart';

class AccountPlanMapper extends EnumMapper<AccountPlan> {
  AccountPlanMapper._();

  static AccountPlanMapper? _instance;
  static AccountPlanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AccountPlanMapper._());
    }
    return _instance!;
  }

  static AccountPlan fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AccountPlan decode(dynamic value) {
    switch (value) {
      case r'free':
        return AccountPlan.free;
      case r'premium':
        return AccountPlan.premium;
      case r'unknown':
        return AccountPlan.unknown;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AccountPlan self) {
    switch (self) {
      case AccountPlan.free:
        return r'free';
      case AccountPlan.premium:
        return r'premium';
      case AccountPlan.unknown:
        return r'unknown';
    }
  }
}

extension AccountPlanMapperExtension on AccountPlan {
  String toValue() {
    AccountPlanMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AccountPlan>(this) as String;
  }
}

class AccountStatusMapper extends EnumMapper<AccountStatus> {
  AccountStatusMapper._();

  static AccountStatusMapper? _instance;
  static AccountStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AccountStatusMapper._());
    }
    return _instance!;
  }

  static AccountStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AccountStatus decode(dynamic value) {
    switch (value) {
      case r'active':
        return AccountStatus.active;
      case r'blocked':
        return AccountStatus.blocked;
      case r'unknown':
        return AccountStatus.unknown;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AccountStatus self) {
    switch (self) {
      case AccountStatus.active:
        return r'active';
      case AccountStatus.blocked:
        return r'blocked';
      case AccountStatus.unknown:
        return r'unknown';
    }
  }
}

extension AccountStatusMapperExtension on AccountStatus {
  String toValue() {
    AccountStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AccountStatus>(this) as String;
  }
}

class AccountEntitlementMapper extends ClassMapperBase<AccountEntitlement> {
  AccountEntitlementMapper._();

  static AccountEntitlementMapper? _instance;
  static AccountEntitlementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AccountEntitlementMapper._());
      AccountPlanMapper.ensureInitialized();
      AccountStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AccountEntitlement';

  static AccountPlan _$plan(AccountEntitlement v) => v.plan;
  static const Field<AccountEntitlement, AccountPlan> _f$plan = Field(
    'plan',
    _$plan,
  );
  static AccountStatus _$status(AccountEntitlement v) => v.status;
  static const Field<AccountEntitlement, AccountStatus> _f$status = Field(
    'status',
    _$status,
  );
  static String? _$blockedReason(AccountEntitlement v) => v.blockedReason;
  static const Field<AccountEntitlement, String> _f$blockedReason = Field(
    'blockedReason',
    _$blockedReason,
  );
  static String? _$backupVerifier(AccountEntitlement v) => v.backupVerifier;
  static const Field<AccountEntitlement, String> _f$backupVerifier = Field(
    'backupVerifier',
    _$backupVerifier,
  );
  static int _$usedDay(AccountEntitlement v) => v.usedDay;
  static const Field<AccountEntitlement, int> _f$usedDay = Field(
    'usedDay',
    _$usedDay,
  );
  static int _$usedWeek(AccountEntitlement v) => v.usedWeek;
  static const Field<AccountEntitlement, int> _f$usedWeek = Field(
    'usedWeek',
    _$usedWeek,
  );
  static int _$usedMonth(AccountEntitlement v) => v.usedMonth;
  static const Field<AccountEntitlement, int> _f$usedMonth = Field(
    'usedMonth',
    _$usedMonth,
  );
  static bool _$attachmentsEnabled(AccountEntitlement v) =>
      v.attachmentsEnabled;
  static const Field<AccountEntitlement, bool> _f$attachmentsEnabled = Field(
    'attachmentsEnabled',
    _$attachmentsEnabled,
  );

  @override
  final MappableFields<AccountEntitlement> fields = const {
    #plan: _f$plan,
    #status: _f$status,
    #blockedReason: _f$blockedReason,
    #backupVerifier: _f$backupVerifier,
    #usedDay: _f$usedDay,
    #usedWeek: _f$usedWeek,
    #usedMonth: _f$usedMonth,
    #attachmentsEnabled: _f$attachmentsEnabled,
  };

  static AccountEntitlement _instantiate(DecodingData data) {
    return AccountEntitlement(
      plan: data.dec(_f$plan),
      status: data.dec(_f$status),
      blockedReason: data.dec(_f$blockedReason),
      backupVerifier: data.dec(_f$backupVerifier),
      usedDay: data.dec(_f$usedDay),
      usedWeek: data.dec(_f$usedWeek),
      usedMonth: data.dec(_f$usedMonth),
      attachmentsEnabled: data.dec(_f$attachmentsEnabled),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AccountEntitlement fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AccountEntitlement>(map);
  }

  static AccountEntitlement fromJson(String json) {
    return ensureInitialized().decodeJson<AccountEntitlement>(json);
  }
}

mixin AccountEntitlementMappable {
  String toJson() {
    return AccountEntitlementMapper.ensureInitialized()
        .encodeJson<AccountEntitlement>(this as AccountEntitlement);
  }

  Map<String, dynamic> toMap() {
    return AccountEntitlementMapper.ensureInitialized()
        .encodeMap<AccountEntitlement>(this as AccountEntitlement);
  }

  AccountEntitlementCopyWith<
    AccountEntitlement,
    AccountEntitlement,
    AccountEntitlement
  >
  get copyWith =>
      _AccountEntitlementCopyWithImpl<AccountEntitlement, AccountEntitlement>(
        this as AccountEntitlement,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AccountEntitlementMapper.ensureInitialized().stringifyValue(
      this as AccountEntitlement,
    );
  }

  @override
  bool operator ==(Object other) {
    return AccountEntitlementMapper.ensureInitialized().equalsValue(
      this as AccountEntitlement,
      other,
    );
  }

  @override
  int get hashCode {
    return AccountEntitlementMapper.ensureInitialized().hashValue(
      this as AccountEntitlement,
    );
  }
}

extension AccountEntitlementValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AccountEntitlement, $Out> {
  AccountEntitlementCopyWith<$R, AccountEntitlement, $Out>
  get $asAccountEntitlement => $base.as(
    (v, t, t2) => _AccountEntitlementCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AccountEntitlementCopyWith<
  $R,
  $In extends AccountEntitlement,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    AccountPlan? plan,
    AccountStatus? status,
    String? blockedReason,
    String? backupVerifier,
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
    bool? attachmentsEnabled,
  });
  AccountEntitlementCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AccountEntitlementCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AccountEntitlement, $Out>
    implements AccountEntitlementCopyWith<$R, AccountEntitlement, $Out> {
  _AccountEntitlementCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AccountEntitlement> $mapper =
      AccountEntitlementMapper.ensureInitialized();
  @override
  $R call({
    AccountPlan? plan,
    AccountStatus? status,
    Object? blockedReason = $none,
    Object? backupVerifier = $none,
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
    bool? attachmentsEnabled,
  }) => $apply(
    FieldCopyWithData({
      if (plan != null) #plan: plan,
      if (status != null) #status: status,
      if (blockedReason != $none) #blockedReason: blockedReason,
      if (backupVerifier != $none) #backupVerifier: backupVerifier,
      if (usedDay != null) #usedDay: usedDay,
      if (usedWeek != null) #usedWeek: usedWeek,
      if (usedMonth != null) #usedMonth: usedMonth,
      if (attachmentsEnabled != null) #attachmentsEnabled: attachmentsEnabled,
    }),
  );
  @override
  AccountEntitlement $make(CopyWithData data) => AccountEntitlement(
    plan: data.get(#plan, or: $value.plan),
    status: data.get(#status, or: $value.status),
    blockedReason: data.get(#blockedReason, or: $value.blockedReason),
    backupVerifier: data.get(#backupVerifier, or: $value.backupVerifier),
    usedDay: data.get(#usedDay, or: $value.usedDay),
    usedWeek: data.get(#usedWeek, or: $value.usedWeek),
    usedMonth: data.get(#usedMonth, or: $value.usedMonth),
    attachmentsEnabled: data.get(
      #attachmentsEnabled,
      or: $value.attachmentsEnabled,
    ),
  );

  @override
  AccountEntitlementCopyWith<$R2, AccountEntitlement, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AccountEntitlementCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

