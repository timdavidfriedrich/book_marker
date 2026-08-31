// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'captured_shot.dart';

class CapturedShotMapper extends ClassMapperBase<CapturedShot> {
  CapturedShotMapper._();

  static CapturedShotMapper? _instance;
  static CapturedShotMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CapturedShotMapper._());
      PageQuadMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CapturedShot';

  static String _$imagePath(CapturedShot v) => v.imagePath;
  static const Field<CapturedShot, String> _f$imagePath = Field(
    'imagePath',
    _$imagePath,
  );
  static PageQuad? _$pageQuad(CapturedShot v) => v.pageQuad;
  static const Field<CapturedShot, PageQuad> _f$pageQuad = Field(
    'pageQuad',
    _$pageQuad,
  );

  @override
  final MappableFields<CapturedShot> fields = const {
    #imagePath: _f$imagePath,
    #pageQuad: _f$pageQuad,
  };

  static CapturedShot _instantiate(DecodingData data) {
    return CapturedShot(
      imagePath: data.dec(_f$imagePath),
      pageQuad: data.dec(_f$pageQuad),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CapturedShot fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CapturedShot>(map);
  }

  static CapturedShot fromJson(String json) {
    return ensureInitialized().decodeJson<CapturedShot>(json);
  }
}

mixin CapturedShotMappable {
  String toJson() {
    return CapturedShotMapper.ensureInitialized().encodeJson<CapturedShot>(
      this as CapturedShot,
    );
  }

  Map<String, dynamic> toMap() {
    return CapturedShotMapper.ensureInitialized().encodeMap<CapturedShot>(
      this as CapturedShot,
    );
  }

  CapturedShotCopyWith<CapturedShot, CapturedShot, CapturedShot> get copyWith =>
      _CapturedShotCopyWithImpl<CapturedShot, CapturedShot>(
        this as CapturedShot,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CapturedShotMapper.ensureInitialized().stringifyValue(
      this as CapturedShot,
    );
  }

  @override
  bool operator ==(Object other) {
    return CapturedShotMapper.ensureInitialized().equalsValue(
      this as CapturedShot,
      other,
    );
  }

  @override
  int get hashCode {
    return CapturedShotMapper.ensureInitialized().hashValue(
      this as CapturedShot,
    );
  }
}

extension CapturedShotValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CapturedShot, $Out> {
  CapturedShotCopyWith<$R, CapturedShot, $Out> get $asCapturedShot =>
      $base.as((v, t, t2) => _CapturedShotCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CapturedShotCopyWith<$R, $In extends CapturedShot, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PageQuadCopyWith<$R, PageQuad, PageQuad>? get pageQuad;
  $R call({String? imagePath, PageQuad? pageQuad});
  CapturedShotCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CapturedShotCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CapturedShot, $Out>
    implements CapturedShotCopyWith<$R, CapturedShot, $Out> {
  _CapturedShotCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CapturedShot> $mapper =
      CapturedShotMapper.ensureInitialized();
  @override
  PageQuadCopyWith<$R, PageQuad, PageQuad>? get pageQuad =>
      $value.pageQuad?.copyWith.$chain((v) => call(pageQuad: v));
  @override
  $R call({String? imagePath, Object? pageQuad = $none}) => $apply(
    FieldCopyWithData({
      if (imagePath != null) #imagePath: imagePath,
      if (pageQuad != $none) #pageQuad: pageQuad,
    }),
  );
  @override
  CapturedShot $make(CopyWithData data) => CapturedShot(
    imagePath: data.get(#imagePath, or: $value.imagePath),
    pageQuad: data.get(#pageQuad, or: $value.pageQuad),
  );

  @override
  CapturedShotCopyWith<$R2, CapturedShot, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CapturedShotCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

