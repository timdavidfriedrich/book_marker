// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'page_quad.dart';

class PagePointMapper extends ClassMapperBase<PagePoint> {
  PagePointMapper._();

  static PagePointMapper? _instance;
  static PagePointMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PagePointMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PagePoint';

  static double _$x(PagePoint v) => v.x;
  static const Field<PagePoint, double> _f$x = Field('x', _$x);
  static double _$y(PagePoint v) => v.y;
  static const Field<PagePoint, double> _f$y = Field('y', _$y);

  @override
  final MappableFields<PagePoint> fields = const {#x: _f$x, #y: _f$y};

  static PagePoint _instantiate(DecodingData data) {
    return PagePoint(x: data.dec(_f$x), y: data.dec(_f$y));
  }

  @override
  final Function instantiate = _instantiate;

  static PagePoint fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PagePoint>(map);
  }

  static PagePoint fromJson(String json) {
    return ensureInitialized().decodeJson<PagePoint>(json);
  }
}

mixin PagePointMappable {
  String toJson() {
    return PagePointMapper.ensureInitialized().encodeJson<PagePoint>(
      this as PagePoint,
    );
  }

  Map<String, dynamic> toMap() {
    return PagePointMapper.ensureInitialized().encodeMap<PagePoint>(
      this as PagePoint,
    );
  }

  PagePointCopyWith<PagePoint, PagePoint, PagePoint> get copyWith =>
      _PagePointCopyWithImpl<PagePoint, PagePoint>(
        this as PagePoint,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PagePointMapper.ensureInitialized().stringifyValue(
      this as PagePoint,
    );
  }

  @override
  bool operator ==(Object other) {
    return PagePointMapper.ensureInitialized().equalsValue(
      this as PagePoint,
      other,
    );
  }

  @override
  int get hashCode {
    return PagePointMapper.ensureInitialized().hashValue(this as PagePoint);
  }
}

extension PagePointValueCopy<$R, $Out> on ObjectCopyWith<$R, PagePoint, $Out> {
  PagePointCopyWith<$R, PagePoint, $Out> get $asPagePoint =>
      $base.as((v, t, t2) => _PagePointCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PagePointCopyWith<$R, $In extends PagePoint, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? x, double? y});
  PagePointCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PagePointCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PagePoint, $Out>
    implements PagePointCopyWith<$R, PagePoint, $Out> {
  _PagePointCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PagePoint> $mapper =
      PagePointMapper.ensureInitialized();
  @override
  $R call({double? x, double? y}) =>
      $apply(FieldCopyWithData({if (x != null) #x: x, if (y != null) #y: y}));
  @override
  PagePoint $make(CopyWithData data) => PagePoint(
    x: data.get(#x, or: $value.x),
    y: data.get(#y, or: $value.y),
  );

  @override
  PagePointCopyWith<$R2, PagePoint, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PagePointCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PageQuadMapper extends ClassMapperBase<PageQuad> {
  PageQuadMapper._();

  static PageQuadMapper? _instance;
  static PageQuadMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PageQuadMapper._());
      PagePointMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PageQuad';

  static PagePoint _$topLeft(PageQuad v) => v.topLeft;
  static const Field<PageQuad, PagePoint> _f$topLeft = Field(
    'topLeft',
    _$topLeft,
  );
  static PagePoint _$topRight(PageQuad v) => v.topRight;
  static const Field<PageQuad, PagePoint> _f$topRight = Field(
    'topRight',
    _$topRight,
  );
  static PagePoint _$bottomRight(PageQuad v) => v.bottomRight;
  static const Field<PageQuad, PagePoint> _f$bottomRight = Field(
    'bottomRight',
    _$bottomRight,
  );
  static PagePoint _$bottomLeft(PageQuad v) => v.bottomLeft;
  static const Field<PageQuad, PagePoint> _f$bottomLeft = Field(
    'bottomLeft',
    _$bottomLeft,
  );

  @override
  final MappableFields<PageQuad> fields = const {
    #topLeft: _f$topLeft,
    #topRight: _f$topRight,
    #bottomRight: _f$bottomRight,
    #bottomLeft: _f$bottomLeft,
  };

  static PageQuad _instantiate(DecodingData data) {
    return PageQuad(
      topLeft: data.dec(_f$topLeft),
      topRight: data.dec(_f$topRight),
      bottomRight: data.dec(_f$bottomRight),
      bottomLeft: data.dec(_f$bottomLeft),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PageQuad fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PageQuad>(map);
  }

  static PageQuad fromJson(String json) {
    return ensureInitialized().decodeJson<PageQuad>(json);
  }
}

mixin PageQuadMappable {
  String toJson() {
    return PageQuadMapper.ensureInitialized().encodeJson<PageQuad>(
      this as PageQuad,
    );
  }

  Map<String, dynamic> toMap() {
    return PageQuadMapper.ensureInitialized().encodeMap<PageQuad>(
      this as PageQuad,
    );
  }

  PageQuadCopyWith<PageQuad, PageQuad, PageQuad> get copyWith =>
      _PageQuadCopyWithImpl<PageQuad, PageQuad>(
        this as PageQuad,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PageQuadMapper.ensureInitialized().stringifyValue(this as PageQuad);
  }

  @override
  bool operator ==(Object other) {
    return PageQuadMapper.ensureInitialized().equalsValue(
      this as PageQuad,
      other,
    );
  }

  @override
  int get hashCode {
    return PageQuadMapper.ensureInitialized().hashValue(this as PageQuad);
  }
}

extension PageQuadValueCopy<$R, $Out> on ObjectCopyWith<$R, PageQuad, $Out> {
  PageQuadCopyWith<$R, PageQuad, $Out> get $asPageQuad =>
      $base.as((v, t, t2) => _PageQuadCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PageQuadCopyWith<$R, $In extends PageQuad, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PagePointCopyWith<$R, PagePoint, PagePoint> get topLeft;
  PagePointCopyWith<$R, PagePoint, PagePoint> get topRight;
  PagePointCopyWith<$R, PagePoint, PagePoint> get bottomRight;
  PagePointCopyWith<$R, PagePoint, PagePoint> get bottomLeft;
  $R call({
    PagePoint? topLeft,
    PagePoint? topRight,
    PagePoint? bottomRight,
    PagePoint? bottomLeft,
  });
  PageQuadCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PageQuadCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PageQuad, $Out>
    implements PageQuadCopyWith<$R, PageQuad, $Out> {
  _PageQuadCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PageQuad> $mapper =
      PageQuadMapper.ensureInitialized();
  @override
  PagePointCopyWith<$R, PagePoint, PagePoint> get topLeft =>
      $value.topLeft.copyWith.$chain((v) => call(topLeft: v));
  @override
  PagePointCopyWith<$R, PagePoint, PagePoint> get topRight =>
      $value.topRight.copyWith.$chain((v) => call(topRight: v));
  @override
  PagePointCopyWith<$R, PagePoint, PagePoint> get bottomRight =>
      $value.bottomRight.copyWith.$chain((v) => call(bottomRight: v));
  @override
  PagePointCopyWith<$R, PagePoint, PagePoint> get bottomLeft =>
      $value.bottomLeft.copyWith.$chain((v) => call(bottomLeft: v));
  @override
  $R call({
    PagePoint? topLeft,
    PagePoint? topRight,
    PagePoint? bottomRight,
    PagePoint? bottomLeft,
  }) => $apply(
    FieldCopyWithData({
      if (topLeft != null) #topLeft: topLeft,
      if (topRight != null) #topRight: topRight,
      if (bottomRight != null) #bottomRight: bottomRight,
      if (bottomLeft != null) #bottomLeft: bottomLeft,
    }),
  );
  @override
  PageQuad $make(CopyWithData data) => PageQuad(
    topLeft: data.get(#topLeft, or: $value.topLeft),
    topRight: data.get(#topRight, or: $value.topRight),
    bottomRight: data.get(#bottomRight, or: $value.bottomRight),
    bottomLeft: data.get(#bottomLeft, or: $value.bottomLeft),
  );

  @override
  PageQuadCopyWith<$R2, PageQuad, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PageQuadCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

