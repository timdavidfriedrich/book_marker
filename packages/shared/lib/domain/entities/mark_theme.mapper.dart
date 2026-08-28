// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'mark_theme.dart';

class MarkThemeMapper extends ClassMapperBase<MarkTheme> {
  MarkThemeMapper._();

  static MarkThemeMapper? _instance;
  static MarkThemeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MarkThemeMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MarkTheme';

  static String _$id(MarkTheme v) => v.id;
  static const Field<MarkTheme, String> _f$id = Field('id', _$id);
  static String _$name(MarkTheme v) => v.name;
  static const Field<MarkTheme, String> _f$name = Field('name', _$name);
  static DateTime _$createdAt(MarkTheme v) => v.createdAt;
  static const Field<MarkTheme, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static AccentColor? _$accent(MarkTheme v) => v.accent;
  static const Field<MarkTheme, AccentColor> _f$accent = Field(
    'accent',
    _$accent,
    opt: true,
  );

  @override
  final MappableFields<MarkTheme> fields = const {
    #id: _f$id,
    #name: _f$name,
    #createdAt: _f$createdAt,
    #accent: _f$accent,
  };

  static MarkTheme _instantiate(DecodingData data) {
    return MarkTheme(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      createdAt: data.dec(_f$createdAt),
      accent: data.dec(_f$accent),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MarkTheme fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MarkTheme>(map);
  }

  static MarkTheme fromJson(String json) {
    return ensureInitialized().decodeJson<MarkTheme>(json);
  }
}

mixin MarkThemeMappable {
  String toJson() {
    return MarkThemeMapper.ensureInitialized().encodeJson<MarkTheme>(
      this as MarkTheme,
    );
  }

  Map<String, dynamic> toMap() {
    return MarkThemeMapper.ensureInitialized().encodeMap<MarkTheme>(
      this as MarkTheme,
    );
  }

  MarkThemeCopyWith<MarkTheme, MarkTheme, MarkTheme> get copyWith =>
      _MarkThemeCopyWithImpl<MarkTheme, MarkTheme>(
        this as MarkTheme,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MarkThemeMapper.ensureInitialized().stringifyValue(
      this as MarkTheme,
    );
  }

  @override
  bool operator ==(Object other) {
    return MarkThemeMapper.ensureInitialized().equalsValue(
      this as MarkTheme,
      other,
    );
  }

  @override
  int get hashCode {
    return MarkThemeMapper.ensureInitialized().hashValue(this as MarkTheme);
  }
}

extension MarkThemeValueCopy<$R, $Out> on ObjectCopyWith<$R, MarkTheme, $Out> {
  MarkThemeCopyWith<$R, MarkTheme, $Out> get $asMarkTheme =>
      $base.as((v, t, t2) => _MarkThemeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MarkThemeCopyWith<$R, $In extends MarkTheme, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, DateTime? createdAt, AccentColor? accent});
  MarkThemeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MarkThemeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MarkTheme, $Out>
    implements MarkThemeCopyWith<$R, MarkTheme, $Out> {
  _MarkThemeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MarkTheme> $mapper =
      MarkThemeMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    DateTime? createdAt,
    Object? accent = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (createdAt != null) #createdAt: createdAt,
      if (accent != $none) #accent: accent,
    }),
  );
  @override
  MarkTheme $make(CopyWithData data) => MarkTheme(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    accent: data.get(#accent, or: $value.accent),
  );

  @override
  MarkThemeCopyWith<$R2, MarkTheme, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MarkThemeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

