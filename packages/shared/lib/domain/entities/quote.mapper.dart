// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'quote.dart';

class QuoteMapper extends ClassMapperBase<Quote> {
  QuoteMapper._();

  static QuoteMapper? _instance;
  static QuoteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = QuoteMapper._());
      HighlightRegionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Quote';

  static String _$id(Quote v) => v.id;
  static const Field<Quote, String> _f$id = Field('id', _$id);
  static String _$bookId(Quote v) => v.bookId;
  static const Field<Quote, String> _f$bookId = Field('bookId', _$bookId);
  static int? _$pageNumber(Quote v) => v.pageNumber;
  static const Field<Quote, int> _f$pageNumber = Field(
    'pageNumber',
    _$pageNumber,
  );
  static String _$quote(Quote v) => v.quote;
  static const Field<Quote, String> _f$quote = Field('quote', _$quote);
  static String? _$note(Quote v) => v.note;
  static const Field<Quote, String> _f$note = Field('note', _$note);
  static String? _$voiceNotePath(Quote v) => v.voiceNotePath;
  static const Field<Quote, String> _f$voiceNotePath = Field(
    'voiceNotePath',
    _$voiceNotePath,
  );
  static int? _$voiceNoteDurationMs(Quote v) => v.voiceNoteDurationMs;
  static const Field<Quote, int> _f$voiceNoteDurationMs = Field(
    'voiceNoteDurationMs',
    _$voiceNoteDurationMs,
  );
  static String _$photoPath(Quote v) => v.photoPath;
  static const Field<Quote, String> _f$photoPath = Field(
    'photoPath',
    _$photoPath,
  );
  static double _$imageAspectRatio(Quote v) => v.imageAspectRatio;
  static const Field<Quote, double> _f$imageAspectRatio = Field(
    'imageAspectRatio',
    _$imageAspectRatio,
  );
  static List<HighlightRegion> _$highlights(Quote v) => v.highlights;
  static const Field<Quote, List<HighlightRegion>> _f$highlights = Field(
    'highlights',
    _$highlights,
  );
  static bool _$isFavorite(Quote v) => v.isFavorite;
  static const Field<Quote, bool> _f$isFavorite = Field(
    'isFavorite',
    _$isFavorite,
  );
  static DateTime _$createdAt(Quote v) => v.createdAt;
  static const Field<Quote, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<Quote> fields = const {
    #id: _f$id,
    #bookId: _f$bookId,
    #pageNumber: _f$pageNumber,
    #quote: _f$quote,
    #note: _f$note,
    #voiceNotePath: _f$voiceNotePath,
    #voiceNoteDurationMs: _f$voiceNoteDurationMs,
    #photoPath: _f$photoPath,
    #imageAspectRatio: _f$imageAspectRatio,
    #highlights: _f$highlights,
    #isFavorite: _f$isFavorite,
    #createdAt: _f$createdAt,
  };

  static Quote _instantiate(DecodingData data) {
    return Quote(
      id: data.dec(_f$id),
      bookId: data.dec(_f$bookId),
      pageNumber: data.dec(_f$pageNumber),
      quote: data.dec(_f$quote),
      note: data.dec(_f$note),
      voiceNotePath: data.dec(_f$voiceNotePath),
      voiceNoteDurationMs: data.dec(_f$voiceNoteDurationMs),
      photoPath: data.dec(_f$photoPath),
      imageAspectRatio: data.dec(_f$imageAspectRatio),
      highlights: data.dec(_f$highlights),
      isFavorite: data.dec(_f$isFavorite),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Quote fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Quote>(map);
  }

  static Quote fromJson(String json) {
    return ensureInitialized().decodeJson<Quote>(json);
  }
}

mixin QuoteMappable {
  String toJson() {
    return QuoteMapper.ensureInitialized().encodeJson<Quote>(this as Quote);
  }

  Map<String, dynamic> toMap() {
    return QuoteMapper.ensureInitialized().encodeMap<Quote>(this as Quote);
  }

  QuoteCopyWith<Quote, Quote, Quote> get copyWith =>
      _QuoteCopyWithImpl<Quote, Quote>(this as Quote, $identity, $identity);
  @override
  String toString() {
    return QuoteMapper.ensureInitialized().stringifyValue(this as Quote);
  }

  @override
  bool operator ==(Object other) {
    return QuoteMapper.ensureInitialized().equalsValue(this as Quote, other);
  }

  @override
  int get hashCode {
    return QuoteMapper.ensureInitialized().hashValue(this as Quote);
  }
}

extension QuoteValueCopy<$R, $Out> on ObjectCopyWith<$R, Quote, $Out> {
  QuoteCopyWith<$R, Quote, $Out> get $asQuote =>
      $base.as((v, t, t2) => _QuoteCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class QuoteCopyWith<$R, $In extends Quote, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    HighlightRegion,
    HighlightRegionCopyWith<$R, HighlightRegion, HighlightRegion>
  >
  get highlights;
  $R call({
    String? id,
    String? bookId,
    int? pageNumber,
    String? quote,
    String? note,
    String? voiceNotePath,
    int? voiceNoteDurationMs,
    String? photoPath,
    double? imageAspectRatio,
    List<HighlightRegion>? highlights,
    bool? isFavorite,
    DateTime? createdAt,
  });
  QuoteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _QuoteCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Quote, $Out>
    implements QuoteCopyWith<$R, Quote, $Out> {
  _QuoteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Quote> $mapper = QuoteMapper.ensureInitialized();
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
    String? id,
    String? bookId,
    Object? pageNumber = $none,
    String? quote,
    Object? note = $none,
    Object? voiceNotePath = $none,
    Object? voiceNoteDurationMs = $none,
    String? photoPath,
    double? imageAspectRatio,
    List<HighlightRegion>? highlights,
    bool? isFavorite,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (bookId != null) #bookId: bookId,
      if (pageNumber != $none) #pageNumber: pageNumber,
      if (quote != null) #quote: quote,
      if (note != $none) #note: note,
      if (voiceNotePath != $none) #voiceNotePath: voiceNotePath,
      if (voiceNoteDurationMs != $none)
        #voiceNoteDurationMs: voiceNoteDurationMs,
      if (photoPath != null) #photoPath: photoPath,
      if (imageAspectRatio != null) #imageAspectRatio: imageAspectRatio,
      if (highlights != null) #highlights: highlights,
      if (isFavorite != null) #isFavorite: isFavorite,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  Quote $make(CopyWithData data) => Quote(
    id: data.get(#id, or: $value.id),
    bookId: data.get(#bookId, or: $value.bookId),
    pageNumber: data.get(#pageNumber, or: $value.pageNumber),
    quote: data.get(#quote, or: $value.quote),
    note: data.get(#note, or: $value.note),
    voiceNotePath: data.get(#voiceNotePath, or: $value.voiceNotePath),
    voiceNoteDurationMs: data.get(
      #voiceNoteDurationMs,
      or: $value.voiceNoteDurationMs,
    ),
    photoPath: data.get(#photoPath, or: $value.photoPath),
    imageAspectRatio: data.get(#imageAspectRatio, or: $value.imageAspectRatio),
    highlights: data.get(#highlights, or: $value.highlights),
    isFavorite: data.get(#isFavorite, or: $value.isFavorite),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  QuoteCopyWith<$R2, Quote, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _QuoteCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

