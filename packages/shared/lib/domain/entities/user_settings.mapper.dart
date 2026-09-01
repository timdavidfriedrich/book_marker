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

class ThemePreferenceMapper extends EnumMapper<ThemePreference> {
  ThemePreferenceMapper._();

  static ThemePreferenceMapper? _instance;
  static ThemePreferenceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ThemePreferenceMapper._());
    }
    return _instance!;
  }

  static ThemePreference fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ThemePreference decode(dynamic value) {
    switch (value) {
      case r'system':
        return ThemePreference.system;
      case r'light':
        return ThemePreference.light;
      case r'dark':
        return ThemePreference.dark;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ThemePreference self) {
    switch (self) {
      case ThemePreference.system:
        return r'system';
      case ThemePreference.light:
        return r'light';
      case ThemePreference.dark:
        return r'dark';
    }
  }
}

extension ThemePreferenceMapperExtension on ThemePreference {
  String toValue() {
    ThemePreferenceMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ThemePreference>(this) as String;
  }
}

class ContrastPreferenceMapper extends EnumMapper<ContrastPreference> {
  ContrastPreferenceMapper._();

  static ContrastPreferenceMapper? _instance;
  static ContrastPreferenceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContrastPreferenceMapper._());
    }
    return _instance!;
  }

  static ContrastPreference fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ContrastPreference decode(dynamic value) {
    switch (value) {
      case r'system':
        return ContrastPreference.system;
      case r'standard':
        return ContrastPreference.standard;
      case r'high':
        return ContrastPreference.high;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ContrastPreference self) {
    switch (self) {
      case ContrastPreference.system:
        return r'system';
      case ContrastPreference.standard:
        return r'standard';
      case ContrastPreference.high:
        return r'high';
    }
  }
}

extension ContrastPreferenceMapperExtension on ContrastPreference {
  String toValue() {
    ContrastPreferenceMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ContrastPreference>(this) as String;
  }
}

class UserSettingsMapper extends ClassMapperBase<UserSettings> {
  UserSettingsMapper._();

  static UserSettingsMapper? _instance;
  static UserSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserSettingsMapper._());
      LocalePreferenceMapper.ensureInitialized();
      ThemePreferenceMapper.ensureInitialized();
      ContrastPreferenceMapper.ensureInitialized();
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
  static ThemePreference _$themePreference(UserSettings v) => v.themePreference;
  static const Field<UserSettings, ThemePreference> _f$themePreference = Field(
    'themePreference',
    _$themePreference,
  );
  static ContrastPreference _$contrastPreference(UserSettings v) =>
      v.contrastPreference;
  static const Field<UserSettings, ContrastPreference> _f$contrastPreference =
      Field('contrastPreference', _$contrastPreference);

  @override
  final MappableFields<UserSettings> fields = const {
    #displayName: _f$displayName,
    #localePreference: _f$localePreference,
    #themePreference: _f$themePreference,
    #contrastPreference: _f$contrastPreference,
  };

  static UserSettings _instantiate(DecodingData data) {
    return UserSettings(
      displayName: data.dec(_f$displayName),
      localePreference: data.dec(_f$localePreference),
      themePreference: data.dec(_f$themePreference),
      contrastPreference: data.dec(_f$contrastPreference),
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
  $R call({
    String? displayName,
    LocalePreference? localePreference,
    ThemePreference? themePreference,
    ContrastPreference? contrastPreference,
  });
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
  $R call({
    Object? displayName = $none,
    LocalePreference? localePreference,
    ThemePreference? themePreference,
    ContrastPreference? contrastPreference,
  }) => $apply(
    FieldCopyWithData({
      if (displayName != $none) #displayName: displayName,
      if (localePreference != null) #localePreference: localePreference,
      if (themePreference != null) #themePreference: themePreference,
      if (contrastPreference != null) #contrastPreference: contrastPreference,
    }),
  );
  @override
  UserSettings $make(CopyWithData data) => UserSettings(
    displayName: data.get(#displayName, or: $value.displayName),
    localePreference: data.get(#localePreference, or: $value.localePreference),
    themePreference: data.get(#themePreference, or: $value.themePreference),
    contrastPreference: data.get(
      #contrastPreference,
      or: $value.contrastPreference,
    ),
  );

  @override
  UserSettingsCopyWith<$R2, UserSettings, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserSettingsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

