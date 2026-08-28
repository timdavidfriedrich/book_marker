// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_settings.dart';

class LocalePreferenceMapper extends EnumMapper<LocalePreference> {
  LocalePreferenceMapper._();

  static LocalePreferenceMapper? _instance;
  static LocalePreferenceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalePreferenceMapper._());
    }
    return _instance!;
  }

  static LocalePreference fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  LocalePreference decode(dynamic value) {
    switch (value) {
      case r'system':
        return LocalePreference.system;
      case r'english':
        return LocalePreference.english;
      case r'german':
        return LocalePreference.german;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(LocalePreference self) {
    switch (self) {
      case LocalePreference.system:
        return r'system';
      case LocalePreference.english:
        return r'english';
      case LocalePreference.german:
        return r'german';
    }
  }
}

extension LocalePreferenceMapperExtension on LocalePreference {
  String toValue() {
    LocalePreferenceMapper.ensureInitialized();
    return MapperContainer.globals.toValue<LocalePreference>(this) as String;
  }
}

class UserSettingsMapper extends ClassMapperBase<UserSettings> {
  UserSettingsMapper._();

  static UserSettingsMapper? _instance;
  static UserSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserSettingsMapper._());
      LocalePreferenceMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserSettings';

  static String? _$displayName(UserSettings v) => v.displayName;
  static const Field<UserSettings, String> _f$displayName = Field(
    'displayName',
    _$displayName,
  );
  static LocalePreference _$localePreference(UserSettings v) =>
      v.localePreference;
  static const Field<UserSettings, LocalePreference> _f$localePreference =
      Field('localePreference', _$localePreference);

  @override
  final MappableFields<UserSettings> fields = const {
    #displayName: _f$displayName,
    #localePreference: _f$localePreference,
  };

  static UserSettings _instantiate(DecodingData data) {
    return UserSettings(
      displayName: data.dec(_f$displayName),
      localePreference: data.dec(_f$localePreference),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UserSettings fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserSettings>(map);
  }

  static UserSettings fromJson(String json) {
    return ensureInitialized().decodeJson<UserSettings>(json);
  }
}

mixin UserSettingsMappable {
  String toJson() {
    return UserSettingsMapper.ensureInitialized().encodeJson<UserSettings>(
      this as UserSettings,
    );
  }

  Map<String, dynamic> toMap() {
    return UserSettingsMapper.ensureInitialized().encodeMap<UserSettings>(
      this as UserSettings,
    );
  }

  UserSettingsCopyWith<UserSettings, UserSettings, UserSettings> get copyWith =>
      _UserSettingsCopyWithImpl<UserSettings, UserSettings>(
        this as UserSettings,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserSettingsMapper.ensureInitialized().stringifyValue(
      this as UserSettings,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserSettingsMapper.ensureInitialized().equalsValue(
      this as UserSettings,
      other,
    );
  }

  @override
  int get hashCode {
    return UserSettingsMapper.ensureInitialized().hashValue(
      this as UserSettings,
    );
  }
}

extension UserSettingsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserSettings, $Out> {
  UserSettingsCopyWith<$R, UserSettings, $Out> get $asUserSettings =>
      $base.as((v, t, t2) => _UserSettingsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserSettingsCopyWith<$R, $In extends UserSettings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? displayName, LocalePreference? localePreference});
  UserSettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserSettingsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserSettings, $Out>
    implements UserSettingsCopyWith<$R, UserSettings, $Out> {
  _UserSettingsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserSettings> $mapper =
      UserSettingsMapper.ensureInitialized();
  @override
  $R call({Object? displayName = $none, LocalePreference? localePreference}) =>
      $apply(
        FieldCopyWithData({
          if (displayName != $none) #displayName: displayName,
          if (localePreference != null) #localePreference: localePreference,
        }),
      );
  @override
  UserSettings $make(CopyWithData data) => UserSettings(
    displayName: data.get(#displayName, or: $value.displayName),
    localePreference: data.get(#localePreference, or: $value.localePreference),
  );

  @override
  UserSettingsCopyWith<$R2, UserSettings, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserSettingsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

