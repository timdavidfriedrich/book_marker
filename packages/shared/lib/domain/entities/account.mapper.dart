// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'account.dart';

class AccountMapper extends ClassMapperBase<Account> {
  AccountMapper._();

  static AccountMapper? _instance;
  static AccountMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AccountMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Account';

  static String _$id(Account v) => v.id;
  static const Field<Account, String> _f$id = Field('id', _$id);
  static String? _$displayName(Account v) => v.displayName;
  static const Field<Account, String> _f$displayName = Field(
    'displayName',
    _$displayName,
  );
  static String? _$email(Account v) => v.email;
  static const Field<Account, String> _f$email = Field('email', _$email);

  @override
  final MappableFields<Account> fields = const {
    #id: _f$id,
    #displayName: _f$displayName,
    #email: _f$email,
  };

  static Account _instantiate(DecodingData data) {
    return Account(
      id: data.dec(_f$id),
      displayName: data.dec(_f$displayName),
      email: data.dec(_f$email),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Account fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Account>(map);
  }

  static Account fromJson(String json) {
    return ensureInitialized().decodeJson<Account>(json);
  }
}

mixin AccountMappable {
  String toJson() {
    return AccountMapper.ensureInitialized().encodeJson<Account>(
      this as Account,
    );
  }

  Map<String, dynamic> toMap() {
    return AccountMapper.ensureInitialized().encodeMap<Account>(
      this as Account,
    );
  }

  AccountCopyWith<Account, Account, Account> get copyWith =>
      _AccountCopyWithImpl<Account, Account>(
        this as Account,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AccountMapper.ensureInitialized().stringifyValue(this as Account);
  }

  @override
  bool operator ==(Object other) {
    return AccountMapper.ensureInitialized().equalsValue(
      this as Account,
      other,
    );
  }

  @override
  int get hashCode {
    return AccountMapper.ensureInitialized().hashValue(this as Account);
  }
}

extension AccountValueCopy<$R, $Out> on ObjectCopyWith<$R, Account, $Out> {
  AccountCopyWith<$R, Account, $Out> get $asAccount =>
      $base.as((v, t, t2) => _AccountCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AccountCopyWith<$R, $In extends Account, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? displayName, String? email});
  AccountCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AccountCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Account, $Out>
    implements AccountCopyWith<$R, Account, $Out> {
  _AccountCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Account> $mapper =
      AccountMapper.ensureInitialized();
  @override
  $R call({String? id, Object? displayName = $none, Object? email = $none}) =>
      $apply(
        FieldCopyWithData({
          if (id != null) #id: id,
          if (displayName != $none) #displayName: displayName,
          if (email != $none) #email: email,
        }),
      );
  @override
  Account $make(CopyWithData data) => Account(
    id: data.get(#id, or: $value.id),
    displayName: data.get(#displayName, or: $value.displayName),
    email: data.get(#email, or: $value.email),
  );

  @override
  AccountCopyWith<$R2, Account, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AccountCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

