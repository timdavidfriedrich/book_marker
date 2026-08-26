// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'highlight_region.dart';

class HighlightRegionMapper extends ClassMapperBase<HighlightRegion> {
  HighlightRegionMapper._();

  static HighlightRegionMapper? _instance;
  static HighlightRegionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HighlightRegionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HighlightRegion';

  static String _$text(HighlightRegion v) => v.text;
  static const Field<HighlightRegion, String> _f$text = Field('text', _$text);
  static double _$left(HighlightRegion v) => v.left;
  static const Field<HighlightRegion, double> _f$left = Field('left', _$left);
  static double _$top(HighlightRegion v) => v.top;
  static const Field<HighlightRegion, double> _f$top = Field('top', _$top);
  static double _$width(HighlightRegion v) => v.width;
  static const Field<HighlightRegion, double> _f$width = Field(
    'width',
    _$width,
  );
  static double _$height(HighlightRegion v) => v.height;
  static const Field<HighlightRegion, double> _f$height = Field(
    'height',
    _$height,
  );

  @override
  final MappableFields<HighlightRegion> fields = const {
    #text: _f$text,
    #left: _f$left,
    #top: _f$top,
    #width: _f$width,
    #height: _f$height,
  };

  static HighlightRegion _instantiate(DecodingData data) {
    return HighlightRegion(
      text: data.dec(_f$text),
      left: data.dec(_f$left),
      top: data.dec(_f$top),
      width: data.dec(_f$width),
      height: data.dec(_f$height),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HighlightRegion fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HighlightRegion>(map);
  }

  static HighlightRegion fromJson(String json) {
    return ensureInitialized().decodeJson<HighlightRegion>(json);
  }
}

mixin HighlightRegionMappable {
  String toJson() {
    return HighlightRegionMapper.ensureInitialized()
        .encodeJson<HighlightRegion>(this as HighlightRegion);
  }

  Map<String, dynamic> toMap() {
    return HighlightRegionMapper.ensureInitialized().encodeMap<HighlightRegion>(
      this as HighlightRegion,
    );
  }

  HighlightRegionCopyWith<HighlightRegion, HighlightRegion, HighlightRegion>
  get copyWith =>
      _HighlightRegionCopyWithImpl<HighlightRegion, HighlightRegion>(
        this as HighlightRegion,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HighlightRegionMapper.ensureInitialized().stringifyValue(
      this as HighlightRegion,
    );
  }

  @override
  bool operator ==(Object other) {
    return HighlightRegionMapper.ensureInitialized().equalsValue(
      this as HighlightRegion,
      other,
    );
  }

  @override
  int get hashCode {
    return HighlightRegionMapper.ensureInitialized().hashValue(
      this as HighlightRegion,
    );
  }
}

extension HighlightRegionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HighlightRegion, $Out> {
  HighlightRegionCopyWith<$R, HighlightRegion, $Out> get $asHighlightRegion =>
      $base.as((v, t, t2) => _HighlightRegionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HighlightRegionCopyWith<$R, $In extends HighlightRegion, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? text,
    double? left,
    double? top,
    double? width,
    double? height,
  });
  HighlightRegionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HighlightRegionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HighlightRegion, $Out>
    implements HighlightRegionCopyWith<$R, HighlightRegion, $Out> {
  _HighlightRegionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HighlightRegion> $mapper =
      HighlightRegionMapper.ensureInitialized();
  @override
  $R call({
    String? text,
    double? left,
    double? top,
    double? width,
    double? height,
  }) => $apply(
    FieldCopyWithData({
      if (text != null) #text: text,
      if (left != null) #left: left,
      if (top != null) #top: top,
      if (width != null) #width: width,
      if (height != null) #height: height,
    }),
  );
  @override
  HighlightRegion $make(CopyWithData data) => HighlightRegion(
    text: data.get(#text, or: $value.text),
    left: data.get(#left, or: $value.left),
    top: data.get(#top, or: $value.top),
    width: data.get(#width, or: $value.width),
    height: data.get(#height, or: $value.height),
  );

  @override
  HighlightRegionCopyWith<$R2, HighlightRegion, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HighlightRegionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

