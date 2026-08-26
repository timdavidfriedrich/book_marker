// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bookmark.dart';

class BookmarkMapper extends ClassMapperBase<Bookmark> {
  BookmarkMapper._();

  static BookmarkMapper? _instance;
  static BookmarkMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookmarkMapper._());
      HighlightRegionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Bookmark';

  static String _$id(Bookmark v) => v.id;
  static const Field<Bookmark, String> _f$id = Field('id', _$id);
  static String _$bookId(Bookmark v) => v.bookId;
  static const Field<Bookmark, String> _f$bookId = Field('bookId', _$bookId);
  static int? _$pageNumber(Bookmark v) => v.pageNumber;
  static const Field<Bookmark, int> _f$pageNumber = Field(
    'pageNumber',
    _$pageNumber,
  );
  static String _$quote(Bookmark v) => v.quote;
  static const Field<Bookmark, String> _f$quote = Field('quote', _$quote);
  static String _$photoPath(Bookmark v) => v.photoPath;
  static const Field<Bookmark, String> _f$photoPath = Field(
    'photoPath',
    _$photoPath,
  );
  static double _$imageAspectRatio(Bookmark v) => v.imageAspectRatio;
  static const Field<Bookmark, double> _f$imageAspectRatio = Field(
    'imageAspectRatio',
    _$imageAspectRatio,
  );
  static List<HighlightRegion> _$highlights(Bookmark v) => v.highlights;
  static const Field<Bookmark, List<HighlightRegion>> _f$highlights = Field(
    'highlights',
    _$highlights,
  );
  static bool _$isFavorite(Bookmark v) => v.isFavorite;
  static const Field<Bookmark, bool> _f$isFavorite = Field(
    'isFavorite',
    _$isFavorite,
  );
  static DateTime _$createdAt(Bookmark v) => v.createdAt;
  static const Field<Bookmark, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<Bookmark> fields = const {
    #id: _f$id,
    #bookId: _f$bookId,
    #pageNumber: _f$pageNumber,
    #quote: _f$quote,
    #photoPath: _f$photoPath,
    #imageAspectRatio: _f$imageAspectRatio,
    #highlights: _f$highlights,
    #isFavorite: _f$isFavorite,
    #createdAt: _f$createdAt,
  };

  static Bookmark _instantiate(DecodingData data) {
    return Bookmark(
      id: data.dec(_f$id),
      bookId: data.dec(_f$bookId),
      pageNumber: data.dec(_f$pageNumber),
      quote: data.dec(_f$quote),
      photoPath: data.dec(_f$photoPath),
      imageAspectRatio: data.dec(_f$imageAspectRatio),
      highlights: data.dec(_f$highlights),
      isFavorite: data.dec(_f$isFavorite),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Bookmark fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Bookmark>(map);
  }

  static Bookmark fromJson(String json) {
    return ensureInitialized().decodeJson<Bookmark>(json);
  }
}

mixin BookmarkMappable {
  String toJson() {
    return BookmarkMapper.ensureInitialized().encodeJson<Bookmark>(
      this as Bookmark,
    );
  }

  Map<String, dynamic> toMap() {
    return BookmarkMapper.ensureInitialized().encodeMap<Bookmark>(
      this as Bookmark,
    );
  }

  BookmarkCopyWith<Bookmark, Bookmark, Bookmark> get copyWith =>
      _BookmarkCopyWithImpl<Bookmark, Bookmark>(
        this as Bookmark,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BookmarkMapper.ensureInitialized().stringifyValue(this as Bookmark);
  }

  @override
  bool operator ==(Object other) {
    return BookmarkMapper.ensureInitialized().equalsValue(
      this as Bookmark,
      other,
    );
  }

  @override
  int get hashCode {
    return BookmarkMapper.ensureInitialized().hashValue(this as Bookmark);
  }
}

extension BookmarkValueCopy<$R, $Out> on ObjectCopyWith<$R, Bookmark, $Out> {
  BookmarkCopyWith<$R, Bookmark, $Out> get $asBookmark =>
      $base.as((v, t, t2) => _BookmarkCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BookmarkCopyWith<$R, $In extends Bookmark, $Out>
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
    String? photoPath,
    double? imageAspectRatio,
    List<HighlightRegion>? highlights,
    bool? isFavorite,
    DateTime? createdAt,
  });
  BookmarkCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BookmarkCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Bookmark, $Out>
    implements BookmarkCopyWith<$R, Bookmark, $Out> {
  _BookmarkCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Bookmark> $mapper =
      BookmarkMapper.ensureInitialized();
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
      if (photoPath != null) #photoPath: photoPath,
      if (imageAspectRatio != null) #imageAspectRatio: imageAspectRatio,
      if (highlights != null) #highlights: highlights,
      if (isFavorite != null) #isFavorite: isFavorite,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  Bookmark $make(CopyWithData data) => Bookmark(
    id: data.get(#id, or: $value.id),
    bookId: data.get(#bookId, or: $value.bookId),
    pageNumber: data.get(#pageNumber, or: $value.pageNumber),
    quote: data.get(#quote, or: $value.quote),
    photoPath: data.get(#photoPath, or: $value.photoPath),
    imageAspectRatio: data.get(#imageAspectRatio, or: $value.imageAspectRatio),
    highlights: data.get(#highlights, or: $value.highlights),
    isFavorite: data.get(#isFavorite, or: $value.isFavorite),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  BookmarkCopyWith<$R2, Bookmark, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BookmarkCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

