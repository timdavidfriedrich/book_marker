// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'quote_theme.dart';

class QuoteThemeMapper extends ClassMapperBase<QuoteTheme> {
  QuoteThemeMapper._();

  static QuoteThemeMapper? _instance;
  static QuoteThemeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = QuoteThemeMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'QuoteTheme';

  static String _$id(QuoteTheme v) => v.id;
  static const Field<QuoteTheme, String> _f$id = Field('id', _$id);
  static String _$name(QuoteTheme v) => v.name;
  static const Field<QuoteTheme, String> _f$name = Field('name', _$name);
  static DateTime _$createdAt(QuoteTheme v) => v.createdAt;
  static const Field<QuoteTheme, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static AccentColor? _$accent(QuoteTheme v) => v.accent;
  static const Field<QuoteTheme, AccentColor> _f$accent = Field(
    'accent',
    _$accent,
    opt: true,
  );

  @override
  final MappableFields<QuoteTheme> fields = const {
    #id: _f$id,
    #name: _f$name,
    #createdAt: _f$createdAt,
    #accent: _f$accent,
  };

  static QuoteTheme _instantiate(DecodingData data) {
    return QuoteTheme(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      createdAt: data.dec(_f$createdAt),
      accent: data.dec(_f$accent),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static QuoteTheme fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<QuoteTheme>(map);
  }

  static QuoteTheme fromJson(String json) {
    return ensureInitialized().decodeJson<QuoteTheme>(json);
  }
}

mixin QuoteThemeMappable {
  String toJson() {
    return QuoteThemeMapper.ensureInitialized().encodeJson<QuoteTheme>(
      this as QuoteTheme,
    );
  }

  Map<String, dynamic> toMap() {
    return QuoteThemeMapper.ensureInitialized().encodeMap<QuoteTheme>(
      this as QuoteTheme,
    );
  }

  QuoteThemeCopyWith<QuoteTheme, QuoteTheme, QuoteTheme> get copyWith =>
      _QuoteThemeCopyWithImpl<QuoteTheme, QuoteTheme>(
        this as QuoteTheme,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return QuoteThemeMapper.ensureInitialized().stringifyValue(
      this as QuoteTheme,
    );
  }

  @override
  bool operator ==(Object other) {
    return QuoteThemeMapper.ensureInitialized().equalsValue(
      this as QuoteTheme,
      other,
    );
  }

  @override
  int get hashCode {
    return QuoteThemeMapper.ensureInitialized().hashValue(this as QuoteTheme);
  }
}

extension QuoteThemeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, QuoteTheme, $Out> {
  QuoteThemeCopyWith<$R, QuoteTheme, $Out> get $asQuoteTheme =>
      $base.as((v, t, t2) => _QuoteThemeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class QuoteThemeCopyWith<$R, $In extends QuoteTheme, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, DateTime? createdAt, AccentColor? accent});
  QuoteThemeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _QuoteThemeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, QuoteTheme, $Out>
    implements QuoteThemeCopyWith<$R, QuoteTheme, $Out> {
  _QuoteThemeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<QuoteTheme> $mapper =
      QuoteThemeMapper.ensureInitialized();
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
  QuoteTheme $make(CopyWithData data) => QuoteTheme(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    accent: data.get(#accent, or: $value.accent),
  );

  @override
  QuoteThemeCopyWith<$R2, QuoteTheme, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _QuoteThemeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

