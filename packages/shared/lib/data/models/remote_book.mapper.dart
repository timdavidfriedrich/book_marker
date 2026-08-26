// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'remote_book.dart';

class RemoteBookMapper extends ClassMapperBase<RemoteBook> {
  RemoteBookMapper._();

  static RemoteBookMapper? _instance;
  static RemoteBookMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteBookMapper._());
      RemoteVolumeInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteBook';

  static RemoteVolumeInfo? _$volumeInfo(RemoteBook v) => v.volumeInfo;
  static const Field<RemoteBook, RemoteVolumeInfo> _f$volumeInfo = Field(
    'volumeInfo',
    _$volumeInfo,
  );

  @override
  final MappableFields<RemoteBook> fields = const {#volumeInfo: _f$volumeInfo};

  static RemoteBook _instantiate(DecodingData data) {
    return RemoteBook(volumeInfo: data.dec(_f$volumeInfo));
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteBook fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteBook>(map);
  }

  static RemoteBook fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteBook>(json);
  }
}

mixin RemoteBookMappable {
  String toJson() {
    return RemoteBookMapper.ensureInitialized().encodeJson<RemoteBook>(
      this as RemoteBook,
    );
  }

  Map<String, dynamic> toMap() {
    return RemoteBookMapper.ensureInitialized().encodeMap<RemoteBook>(
      this as RemoteBook,
    );
  }

  RemoteBookCopyWith<RemoteBook, RemoteBook, RemoteBook> get copyWith =>
      _RemoteBookCopyWithImpl<RemoteBook, RemoteBook>(
        this as RemoteBook,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return RemoteBookMapper.ensureInitialized().stringifyValue(
      this as RemoteBook,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteBookMapper.ensureInitialized().equalsValue(
      this as RemoteBook,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteBookMapper.ensureInitialized().hashValue(this as RemoteBook);
  }
}

extension RemoteBookValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteBook, $Out> {
  RemoteBookCopyWith<$R, RemoteBook, $Out> get $asRemoteBook =>
      $base.as((v, t, t2) => _RemoteBookCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RemoteBookCopyWith<$R, $In extends RemoteBook, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  RemoteVolumeInfoCopyWith<$R, RemoteVolumeInfo, RemoteVolumeInfo>?
  get volumeInfo;
  $R call({RemoteVolumeInfo? volumeInfo});
  RemoteBookCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RemoteBookCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteBook, $Out>
    implements RemoteBookCopyWith<$R, RemoteBook, $Out> {
  _RemoteBookCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteBook> $mapper =
      RemoteBookMapper.ensureInitialized();
  @override
  RemoteVolumeInfoCopyWith<$R, RemoteVolumeInfo, RemoteVolumeInfo>?
  get volumeInfo =>
      $value.volumeInfo?.copyWith.$chain((v) => call(volumeInfo: v));
  @override
  $R call({Object? volumeInfo = $none}) => $apply(
    FieldCopyWithData({if (volumeInfo != $none) #volumeInfo: volumeInfo}),
  );
  @override
  RemoteBook $make(CopyWithData data) =>
      RemoteBook(volumeInfo: data.get(#volumeInfo, or: $value.volumeInfo));

  @override
  RemoteBookCopyWith<$R2, RemoteBook, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _RemoteBookCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RemoteVolumeInfoMapper extends ClassMapperBase<RemoteVolumeInfo> {
  RemoteVolumeInfoMapper._();

  static RemoteVolumeInfoMapper? _instance;
  static RemoteVolumeInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteVolumeInfoMapper._());
      RemoteIndustryIdentifierMapper.ensureInitialized();
      RemoteImageLinksMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteVolumeInfo';

  static String? _$title(RemoteVolumeInfo v) => v.title;
  static const Field<RemoteVolumeInfo, String> _f$title = Field(
    'title',
    _$title,
  );
  static List<String>? _$authors(RemoteVolumeInfo v) => v.authors;
  static const Field<RemoteVolumeInfo, List<String>> _f$authors = Field(
    'authors',
    _$authors,
  );
  static List<RemoteIndustryIdentifier>? _$industryIdentifiers(
    RemoteVolumeInfo v,
  ) => v.industryIdentifiers;
  static const Field<RemoteVolumeInfo, List<RemoteIndustryIdentifier>>
  _f$industryIdentifiers = Field('industryIdentifiers', _$industryIdentifiers);
  static RemoteImageLinks? _$imageLinks(RemoteVolumeInfo v) => v.imageLinks;
  static const Field<RemoteVolumeInfo, RemoteImageLinks> _f$imageLinks = Field(
    'imageLinks',
    _$imageLinks,
  );

  @override
  final MappableFields<RemoteVolumeInfo> fields = const {
    #title: _f$title,
    #authors: _f$authors,
    #industryIdentifiers: _f$industryIdentifiers,
    #imageLinks: _f$imageLinks,
  };

  static RemoteVolumeInfo _instantiate(DecodingData data) {
    return RemoteVolumeInfo(
      title: data.dec(_f$title),
      authors: data.dec(_f$authors),
      industryIdentifiers: data.dec(_f$industryIdentifiers),
      imageLinks: data.dec(_f$imageLinks),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteVolumeInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteVolumeInfo>(map);
  }

  static RemoteVolumeInfo fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteVolumeInfo>(json);
  }
}

mixin RemoteVolumeInfoMappable {
  String toJson() {
    return RemoteVolumeInfoMapper.ensureInitialized()
        .encodeJson<RemoteVolumeInfo>(this as RemoteVolumeInfo);
  }

  Map<String, dynamic> toMap() {
    return RemoteVolumeInfoMapper.ensureInitialized()
        .encodeMap<RemoteVolumeInfo>(this as RemoteVolumeInfo);
  }

  RemoteVolumeInfoCopyWith<RemoteVolumeInfo, RemoteVolumeInfo, RemoteVolumeInfo>
  get copyWith =>
      _RemoteVolumeInfoCopyWithImpl<RemoteVolumeInfo, RemoteVolumeInfo>(
        this as RemoteVolumeInfo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return RemoteVolumeInfoMapper.ensureInitialized().stringifyValue(
      this as RemoteVolumeInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteVolumeInfoMapper.ensureInitialized().equalsValue(
      this as RemoteVolumeInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteVolumeInfoMapper.ensureInitialized().hashValue(
      this as RemoteVolumeInfo,
    );
  }
}

extension RemoteVolumeInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteVolumeInfo, $Out> {
  RemoteVolumeInfoCopyWith<$R, RemoteVolumeInfo, $Out>
  get $asRemoteVolumeInfo =>
      $base.as((v, t, t2) => _RemoteVolumeInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RemoteVolumeInfoCopyWith<$R, $In extends RemoteVolumeInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get authors;
  ListCopyWith<
    $R,
    RemoteIndustryIdentifier,
    RemoteIndustryIdentifierCopyWith<
      $R,
      RemoteIndustryIdentifier,
      RemoteIndustryIdentifier
    >
  >?
  get industryIdentifiers;
  RemoteImageLinksCopyWith<$R, RemoteImageLinks, RemoteImageLinks>?
  get imageLinks;
  $R call({
    String? title,
    List<String>? authors,
    List<RemoteIndustryIdentifier>? industryIdentifiers,
    RemoteImageLinks? imageLinks,
  });
  RemoteVolumeInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteVolumeInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteVolumeInfo, $Out>
    implements RemoteVolumeInfoCopyWith<$R, RemoteVolumeInfo, $Out> {
  _RemoteVolumeInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteVolumeInfo> $mapper =
      RemoteVolumeInfoMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get authors =>
      $value.authors != null
      ? ListCopyWith(
          $value.authors!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(authors: v),
        )
      : null;
  @override
  ListCopyWith<
    $R,
    RemoteIndustryIdentifier,
    RemoteIndustryIdentifierCopyWith<
      $R,
      RemoteIndustryIdentifier,
      RemoteIndustryIdentifier
    >
  >?
  get industryIdentifiers => $value.industryIdentifiers != null
      ? ListCopyWith(
          $value.industryIdentifiers!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(industryIdentifiers: v),
        )
      : null;
  @override
  RemoteImageLinksCopyWith<$R, RemoteImageLinks, RemoteImageLinks>?
  get imageLinks =>
      $value.imageLinks?.copyWith.$chain((v) => call(imageLinks: v));
  @override
  $R call({
    Object? title = $none,
    Object? authors = $none,
    Object? industryIdentifiers = $none,
    Object? imageLinks = $none,
  }) => $apply(
    FieldCopyWithData({
      if (title != $none) #title: title,
      if (authors != $none) #authors: authors,
      if (industryIdentifiers != $none)
        #industryIdentifiers: industryIdentifiers,
      if (imageLinks != $none) #imageLinks: imageLinks,
    }),
  );
  @override
  RemoteVolumeInfo $make(CopyWithData data) => RemoteVolumeInfo(
    title: data.get(#title, or: $value.title),
    authors: data.get(#authors, or: $value.authors),
    industryIdentifiers: data.get(
      #industryIdentifiers,
      or: $value.industryIdentifiers,
    ),
    imageLinks: data.get(#imageLinks, or: $value.imageLinks),
  );

  @override
  RemoteVolumeInfoCopyWith<$R2, RemoteVolumeInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _RemoteVolumeInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RemoteIndustryIdentifierMapper
    extends ClassMapperBase<RemoteIndustryIdentifier> {
  RemoteIndustryIdentifierMapper._();

  static RemoteIndustryIdentifierMapper? _instance;
  static RemoteIndustryIdentifierMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = RemoteIndustryIdentifierMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteIndustryIdentifier';

  static String? _$type(RemoteIndustryIdentifier v) => v.type;
  static const Field<RemoteIndustryIdentifier, String> _f$type = Field(
    'type',
    _$type,
  );
  static String? _$identifier(RemoteIndustryIdentifier v) => v.identifier;
  static const Field<RemoteIndustryIdentifier, String> _f$identifier = Field(
    'identifier',
    _$identifier,
  );

  @override
  final MappableFields<RemoteIndustryIdentifier> fields = const {
    #type: _f$type,
    #identifier: _f$identifier,
  };

  static RemoteIndustryIdentifier _instantiate(DecodingData data) {
    return RemoteIndustryIdentifier(
      type: data.dec(_f$type),
      identifier: data.dec(_f$identifier),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteIndustryIdentifier fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteIndustryIdentifier>(map);
  }

  static RemoteIndustryIdentifier fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteIndustryIdentifier>(json);
  }
}

mixin RemoteIndustryIdentifierMappable {
  String toJson() {
    return RemoteIndustryIdentifierMapper.ensureInitialized()
        .encodeJson<RemoteIndustryIdentifier>(this as RemoteIndustryIdentifier);
  }

  Map<String, dynamic> toMap() {
    return RemoteIndustryIdentifierMapper.ensureInitialized()
        .encodeMap<RemoteIndustryIdentifier>(this as RemoteIndustryIdentifier);
  }

  RemoteIndustryIdentifierCopyWith<
    RemoteIndustryIdentifier,
    RemoteIndustryIdentifier,
    RemoteIndustryIdentifier
  >
  get copyWith =>
      _RemoteIndustryIdentifierCopyWithImpl<
        RemoteIndustryIdentifier,
        RemoteIndustryIdentifier
      >(this as RemoteIndustryIdentifier, $identity, $identity);
  @override
  String toString() {
    return RemoteIndustryIdentifierMapper.ensureInitialized().stringifyValue(
      this as RemoteIndustryIdentifier,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteIndustryIdentifierMapper.ensureInitialized().equalsValue(
      this as RemoteIndustryIdentifier,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteIndustryIdentifierMapper.ensureInitialized().hashValue(
      this as RemoteIndustryIdentifier,
    );
  }
}

extension RemoteIndustryIdentifierValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteIndustryIdentifier, $Out> {
  RemoteIndustryIdentifierCopyWith<$R, RemoteIndustryIdentifier, $Out>
  get $asRemoteIndustryIdentifier => $base.as(
    (v, t, t2) => _RemoteIndustryIdentifierCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RemoteIndustryIdentifierCopyWith<
  $R,
  $In extends RemoteIndustryIdentifier,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? type, String? identifier});
  RemoteIndustryIdentifierCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteIndustryIdentifierCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteIndustryIdentifier, $Out>
    implements
        RemoteIndustryIdentifierCopyWith<$R, RemoteIndustryIdentifier, $Out> {
  _RemoteIndustryIdentifierCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteIndustryIdentifier> $mapper =
      RemoteIndustryIdentifierMapper.ensureInitialized();
  @override
  $R call({Object? type = $none, Object? identifier = $none}) => $apply(
    FieldCopyWithData({
      if (type != $none) #type: type,
      if (identifier != $none) #identifier: identifier,
    }),
  );
  @override
  RemoteIndustryIdentifier $make(CopyWithData data) => RemoteIndustryIdentifier(
    type: data.get(#type, or: $value.type),
    identifier: data.get(#identifier, or: $value.identifier),
  );

  @override
  RemoteIndustryIdentifierCopyWith<$R2, RemoteIndustryIdentifier, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RemoteIndustryIdentifierCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RemoteImageLinksMapper extends ClassMapperBase<RemoteImageLinks> {
  RemoteImageLinksMapper._();

  static RemoteImageLinksMapper? _instance;
  static RemoteImageLinksMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteImageLinksMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteImageLinks';

  static String? _$thumbnail(RemoteImageLinks v) => v.thumbnail;
  static const Field<RemoteImageLinks, String> _f$thumbnail = Field(
    'thumbnail',
    _$thumbnail,
  );
  static String? _$smallThumbnail(RemoteImageLinks v) => v.smallThumbnail;
  static const Field<RemoteImageLinks, String> _f$smallThumbnail = Field(
    'smallThumbnail',
    _$smallThumbnail,
  );

  @override
  final MappableFields<RemoteImageLinks> fields = const {
    #thumbnail: _f$thumbnail,
    #smallThumbnail: _f$smallThumbnail,
  };

  static RemoteImageLinks _instantiate(DecodingData data) {
    return RemoteImageLinks(
      thumbnail: data.dec(_f$thumbnail),
      smallThumbnail: data.dec(_f$smallThumbnail),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteImageLinks fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteImageLinks>(map);
  }

  static RemoteImageLinks fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteImageLinks>(json);
  }
}

mixin RemoteImageLinksMappable {
  String toJson() {
    return RemoteImageLinksMapper.ensureInitialized()
        .encodeJson<RemoteImageLinks>(this as RemoteImageLinks);
  }

  Map<String, dynamic> toMap() {
    return RemoteImageLinksMapper.ensureInitialized()
        .encodeMap<RemoteImageLinks>(this as RemoteImageLinks);
  }

  RemoteImageLinksCopyWith<RemoteImageLinks, RemoteImageLinks, RemoteImageLinks>
  get copyWith =>
      _RemoteImageLinksCopyWithImpl<RemoteImageLinks, RemoteImageLinks>(
        this as RemoteImageLinks,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return RemoteImageLinksMapper.ensureInitialized().stringifyValue(
      this as RemoteImageLinks,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteImageLinksMapper.ensureInitialized().equalsValue(
      this as RemoteImageLinks,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteImageLinksMapper.ensureInitialized().hashValue(
      this as RemoteImageLinks,
    );
  }
}

extension RemoteImageLinksValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteImageLinks, $Out> {
  RemoteImageLinksCopyWith<$R, RemoteImageLinks, $Out>
  get $asRemoteImageLinks =>
      $base.as((v, t, t2) => _RemoteImageLinksCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RemoteImageLinksCopyWith<$R, $In extends RemoteImageLinks, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? thumbnail, String? smallThumbnail});
  RemoteImageLinksCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteImageLinksCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteImageLinks, $Out>
    implements RemoteImageLinksCopyWith<$R, RemoteImageLinks, $Out> {
  _RemoteImageLinksCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteImageLinks> $mapper =
      RemoteImageLinksMapper.ensureInitialized();
  @override
  $R call({Object? thumbnail = $none, Object? smallThumbnail = $none}) =>
      $apply(
        FieldCopyWithData({
          if (thumbnail != $none) #thumbnail: thumbnail,
          if (smallThumbnail != $none) #smallThumbnail: smallThumbnail,
        }),
      );
  @override
  RemoteImageLinks $make(CopyWithData data) => RemoteImageLinks(
    thumbnail: data.get(#thumbnail, or: $value.thumbnail),
    smallThumbnail: data.get(#smallThumbnail, or: $value.smallThumbnail),
  );

  @override
  RemoteImageLinksCopyWith<$R2, RemoteImageLinks, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _RemoteImageLinksCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

