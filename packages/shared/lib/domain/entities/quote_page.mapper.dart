// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'quote_page.dart';

class QuotePageMapper extends ClassMapperBase<QuotePage> {
  QuotePageMapper._();

  static QuotePageMapper? _instance;
  static QuotePageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = QuotePageMapper._());
      HighlightRegionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'QuotePage';

  static String _$photoPath(QuotePage v) => v.photoPath;
  static const Field<QuotePage, String> _f$photoPath = Field(
    'photoPath',
    _$photoPath,
  );
  static double _$imageAspectRatio(QuotePage v) => v.imageAspectRatio;
  static const Field<QuotePage, double> _f$imageAspectRatio = Field(
    'imageAspectRatio',
    _$imageAspectRatio,
  );
  static List<HighlightRegion> _$highlights(QuotePage v) => v.highlights;
  static const Field<QuotePage, List<HighlightRegion>> _f$highlights = Field(
    'highlights',
    _$highlights,
  );

  @override
  final MappableFields<QuotePage> fields = const {
    #photoPath: _f$photoPath,
    #imageAspectRatio: _f$imageAspectRatio,
    #highlights: _f$highlights,
  };

  static QuotePage _instantiate(DecodingData data) {
    return QuotePage(
      photoPath: data.dec(_f$photoPath),
      imageAspectRatio: data.dec(_f$imageAspectRatio),
      highlights: data.dec(_f$highlights),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static QuotePage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<QuotePage>(map);
  }

  static QuotePage fromJson(String json) {
    return ensureInitialized().decodeJson<QuotePage>(json);
  }
}

mixin QuotePageMappable {
  String toJson() {
    return QuotePageMapper.ensureInitialized().encodeJson<QuotePage>(
      this as QuotePage,
    );
  }

  Map<String, dynamic> toMap() {
    return QuotePageMapper.ensureInitialized().encodeMap<QuotePage>(
      this as QuotePage,
    );
  }

  QuotePageCopyWith<QuotePage, QuotePage, QuotePage> get copyWith =>
      _QuotePageCopyWithImpl<QuotePage, QuotePage>(
        this as QuotePage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return QuotePageMapper.ensureInitialized().stringifyValue(
      this as QuotePage,
    );
  }

  @override
  bool operator ==(Object other) {
    return QuotePageMapper.ensureInitialized().equalsValue(
      this as QuotePage,
      other,
    );
  }

  @override
  int get hashCode {
    return QuotePageMapper.ensureInitialized().hashValue(this as QuotePage);
  }
}

extension QuotePageValueCopy<$R, $Out> on ObjectCopyWith<$R, QuotePage, $Out> {
  QuotePageCopyWith<$R, QuotePage, $Out> get $asQuotePage =>
      $base.as((v, t, t2) => _QuotePageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class QuotePageCopyWith<$R, $In extends QuotePage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    HighlightRegion,
    HighlightRegionCopyWith<$R, HighlightRegion, HighlightRegion>
  >
  get highlights;
  $R call({
    String? photoPath,
    double? imageAspectRatio,
    List<HighlightRegion>? highlights,
  });
  QuotePageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _QuotePageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, QuotePage, $Out>
    implements QuotePageCopyWith<$R, QuotePage, $Out> {
  _QuotePageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<QuotePage> $mapper =
      QuotePageMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    HighlightRegion,
    HighlightRegionCopyWith<$R, HighlightRegion, HighlightRegion>
  >
  get highlights => ListCopyWith(
    $value.highlights,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(highlights: v),
  );
  @override
  $R call({
    String? photoPath,
    double? imageAspectRatio,
    List<HighlightRegion>? highlights,
  }) => $apply(
    FieldCopyWithData({
      if (photoPath != null) #photoPath: photoPath,
      if (imageAspectRatio != null) #imageAspectRatio: imageAspectRatio,
      if (highlights != null) #highlights: highlights,
    }),
  );
  @override
  QuotePage $make(CopyWithData data) => QuotePage(
    photoPath: data.get(#photoPath, or: $value.photoPath),
    imageAspectRatio: data.get(#imageAspectRatio, or: $value.imageAspectRatio),
    highlights: data.get(#highlights, or: $value.highlights),
  );

  @override
  QuotePageCopyWith<$R2, QuotePage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _QuotePageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

