// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'remote_google_book.dart';

class RemoteGoogleBookMapper extends ClassMapperBase<RemoteGoogleBook> {
  RemoteGoogleBookMapper._();

  static RemoteGoogleBookMapper? _instance;
  static RemoteGoogleBookMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteGoogleBookMapper._());
      RemoteGoogleVolumeInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteGoogleBook';

  static RemoteGoogleVolumeInfo? _$volumeInfo(RemoteGoogleBook v) =>
      v.volumeInfo;
  static const Field<RemoteGoogleBook, RemoteGoogleVolumeInfo> _f$volumeInfo =
      Field('volumeInfo', _$volumeInfo);

  @override
  final MappableFields<RemoteGoogleBook> fields = const {
    #volumeInfo: _f$volumeInfo,
  };

  static RemoteGoogleBook _instantiate(DecodingData data) {
    return RemoteGoogleBook(volumeInfo: data.dec(_f$volumeInfo));
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteGoogleBook fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteGoogleBook>(map);
  }

  static RemoteGoogleBook fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteGoogleBook>(json);
  }
}

mixin RemoteGoogleBookMappable {
  String toJson() {
    return RemoteGoogleBookMapper.ensureInitialized()
        .encodeJson<RemoteGoogleBook>(this as RemoteGoogleBook);
  }

  Map<String, dynamic> toMap() {
    return RemoteGoogleBookMapper.ensureInitialized()
        .encodeMap<RemoteGoogleBook>(this as RemoteGoogleBook);
  }

  RemoteGoogleBookCopyWith<RemoteGoogleBook, RemoteGoogleBook, RemoteGoogleBook>
  get copyWith =>
      _RemoteGoogleBookCopyWithImpl<RemoteGoogleBook, RemoteGoogleBook>(
        this as RemoteGoogleBook,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return RemoteGoogleBookMapper.ensureInitialized().stringifyValue(
      this as RemoteGoogleBook,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteGoogleBookMapper.ensureInitialized().equalsValue(
      this as RemoteGoogleBook,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteGoogleBookMapper.ensureInitialized().hashValue(
      this as RemoteGoogleBook,
    );
  }
}

extension RemoteGoogleBookValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteGoogleBook, $Out> {
  RemoteGoogleBookCopyWith<$R, RemoteGoogleBook, $Out>
  get $asRemoteGoogleBook =>
      $base.as((v, t, t2) => _RemoteGoogleBookCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RemoteGoogleBookCopyWith<$R, $In extends RemoteGoogleBook, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  RemoteGoogleVolumeInfoCopyWith<
    $R,
    RemoteGoogleVolumeInfo,
    RemoteGoogleVolumeInfo
  >?
  get volumeInfo;
  $R call({RemoteGoogleVolumeInfo? volumeInfo});
  RemoteGoogleBookCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteGoogleBookCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteGoogleBook, $Out>
    implements RemoteGoogleBookCopyWith<$R, RemoteGoogleBook, $Out> {
  _RemoteGoogleBookCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteGoogleBook> $mapper =
      RemoteGoogleBookMapper.ensureInitialized();
  @override
  RemoteGoogleVolumeInfoCopyWith<
    $R,
    RemoteGoogleVolumeInfo,
    RemoteGoogleVolumeInfo
  >?
  get volumeInfo =>
      $value.volumeInfo?.copyWith.$chain((v) => call(volumeInfo: v));
  @override
  $R call({Object? volumeInfo = $none}) => $apply(
    FieldCopyWithData({if (volumeInfo != $none) #volumeInfo: volumeInfo}),
  );
  @override
  RemoteGoogleBook $make(CopyWithData data) => RemoteGoogleBook(
    volumeInfo: data.get(#volumeInfo, or: $value.volumeInfo),
  );

  @override
  RemoteGoogleBookCopyWith<$R2, RemoteGoogleBook, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _RemoteGoogleBookCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RemoteGoogleVolumeInfoMapper
    extends ClassMapperBase<RemoteGoogleVolumeInfo> {
  RemoteGoogleVolumeInfoMapper._();

  static RemoteGoogleVolumeInfoMapper? _instance;
  static RemoteGoogleVolumeInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteGoogleVolumeInfoMapper._());
      RemoteGoogleIndustryIdentifierMapper.ensureInitialized();
      RemoteGoogleImageLinksMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteGoogleVolumeInfo';

  static String? _$title(RemoteGoogleVolumeInfo v) => v.title;
  static const Field<RemoteGoogleVolumeInfo, String> _f$title = Field(
    'title',
    _$title,
  );
  static List<String>? _$authors(RemoteGoogleVolumeInfo v) => v.authors;
  static const Field<RemoteGoogleVolumeInfo, List<String>> _f$authors = Field(
    'authors',
    _$authors,
  );
  static List<RemoteGoogleIndustryIdentifier>? _$industryIdentifiers(
    RemoteGoogleVolumeInfo v,
  ) => v.industryIdentifiers;
  static const Field<
    RemoteGoogleVolumeInfo,
    List<RemoteGoogleIndustryIdentifier>
  >
  _f$industryIdentifiers = Field('industryIdentifiers', _$industryIdentifiers);
  static RemoteGoogleImageLinks? _$imageLinks(RemoteGoogleVolumeInfo v) =>
      v.imageLinks;
  static const Field<RemoteGoogleVolumeInfo, RemoteGoogleImageLinks>
  _f$imageLinks = Field('imageLinks', _$imageLinks);

  @override
  final MappableFields<RemoteGoogleVolumeInfo> fields = const {
    #title: _f$title,
    #authors: _f$authors,
    #industryIdentifiers: _f$industryIdentifiers,
    #imageLinks: _f$imageLinks,
  };

  static RemoteGoogleVolumeInfo _instantiate(DecodingData data) {
    return RemoteGoogleVolumeInfo(
      title: data.dec(_f$title),
      authors: data.dec(_f$authors),
      industryIdentifiers: data.dec(_f$industryIdentifiers),
      imageLinks: data.dec(_f$imageLinks),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteGoogleVolumeInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteGoogleVolumeInfo>(map);
  }

  static RemoteGoogleVolumeInfo fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteGoogleVolumeInfo>(json);
  }
}

mixin RemoteGoogleVolumeInfoMappable {
  String toJson() {
    return RemoteGoogleVolumeInfoMapper.ensureInitialized()
        .encodeJson<RemoteGoogleVolumeInfo>(this as RemoteGoogleVolumeInfo);
  }

  Map<String, dynamic> toMap() {
    return RemoteGoogleVolumeInfoMapper.ensureInitialized()
        .encodeMap<RemoteGoogleVolumeInfo>(this as RemoteGoogleVolumeInfo);
  }

  RemoteGoogleVolumeInfoCopyWith<
    RemoteGoogleVolumeInfo,
    RemoteGoogleVolumeInfo,
    RemoteGoogleVolumeInfo
  >
  get copyWith =>
      _RemoteGoogleVolumeInfoCopyWithImpl<
        RemoteGoogleVolumeInfo,
        RemoteGoogleVolumeInfo
      >(this as RemoteGoogleVolumeInfo, $identity, $identity);
  @override
  String toString() {
    return RemoteGoogleVolumeInfoMapper.ensureInitialized().stringifyValue(
      this as RemoteGoogleVolumeInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteGoogleVolumeInfoMapper.ensureInitialized().equalsValue(
      this as RemoteGoogleVolumeInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteGoogleVolumeInfoMapper.ensureInitialized().hashValue(
      this as RemoteGoogleVolumeInfo,
    );
  }
}

extension RemoteGoogleVolumeInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteGoogleVolumeInfo, $Out> {
  RemoteGoogleVolumeInfoCopyWith<$R, RemoteGoogleVolumeInfo, $Out>
  get $asRemoteGoogleVolumeInfo => $base.as(
    (v, t, t2) => _RemoteGoogleVolumeInfoCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RemoteGoogleVolumeInfoCopyWith<
  $R,
  $In extends RemoteGoogleVolumeInfo,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get authors;
  ListCopyWith<
    $R,
    RemoteGoogleIndustryIdentifier,
    RemoteGoogleIndustryIdentifierCopyWith<
      $R,
      RemoteGoogleIndustryIdentifier,
      RemoteGoogleIndustryIdentifier
    >
  >?
  get industryIdentifiers;
  RemoteGoogleImageLinksCopyWith<
    $R,
    RemoteGoogleImageLinks,
    RemoteGoogleImageLinks
  >?
  get imageLinks;
  $R call({
    String? title,
    List<String>? authors,
    List<RemoteGoogleIndustryIdentifier>? industryIdentifiers,
    RemoteGoogleImageLinks? imageLinks,
  });
  RemoteGoogleVolumeInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteGoogleVolumeInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteGoogleVolumeInfo, $Out>
    implements
        RemoteGoogleVolumeInfoCopyWith<$R, RemoteGoogleVolumeInfo, $Out> {
  _RemoteGoogleVolumeInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteGoogleVolumeInfo> $mapper =
      RemoteGoogleVolumeInfoMapper.ensureInitialized();
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
    RemoteGoogleIndustryIdentifier,
    RemoteGoogleIndustryIdentifierCopyWith<
      $R,
      RemoteGoogleIndustryIdentifier,
      RemoteGoogleIndustryIdentifier
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
  RemoteGoogleImageLinksCopyWith<
    $R,
    RemoteGoogleImageLinks,
    RemoteGoogleImageLinks
  >?
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
  RemoteGoogleVolumeInfo $make(CopyWithData data) => RemoteGoogleVolumeInfo(
    title: data.get(#title, or: $value.title),
    authors: data.get(#authors, or: $value.authors),
    industryIdentifiers: data.get(
      #industryIdentifiers,
      or: $value.industryIdentifiers,
    ),
    imageLinks: data.get(#imageLinks, or: $value.imageLinks),
  );

  @override
  RemoteGoogleVolumeInfoCopyWith<$R2, RemoteGoogleVolumeInfo, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RemoteGoogleVolumeInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RemoteGoogleIndustryIdentifierMapper
    extends ClassMapperBase<RemoteGoogleIndustryIdentifier> {
  RemoteGoogleIndustryIdentifierMapper._();

  static RemoteGoogleIndustryIdentifierMapper? _instance;
  static RemoteGoogleIndustryIdentifierMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = RemoteGoogleIndustryIdentifierMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteGoogleIndustryIdentifier';

  static String? _$type(RemoteGoogleIndustryIdentifier v) => v.type;
  static const Field<RemoteGoogleIndustryIdentifier, String> _f$type = Field(
    'type',
    _$type,
  );
  static String? _$identifier(RemoteGoogleIndustryIdentifier v) => v.identifier;
  static const Field<RemoteGoogleIndustryIdentifier, String> _f$identifier =
      Field('identifier', _$identifier);

  @override
  final MappableFields<RemoteGoogleIndustryIdentifier> fields = const {
    #type: _f$type,
    #identifier: _f$identifier,
  };

  static RemoteGoogleIndustryIdentifier _instantiate(DecodingData data) {
    return RemoteGoogleIndustryIdentifier(
      type: data.dec(_f$type),
      identifier: data.dec(_f$identifier),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteGoogleIndustryIdentifier fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteGoogleIndustryIdentifier>(map);
  }

  static RemoteGoogleIndustryIdentifier fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteGoogleIndustryIdentifier>(json);
  }
}

mixin RemoteGoogleIndustryIdentifierMappable {
  String toJson() {
    return RemoteGoogleIndustryIdentifierMapper.ensureInitialized()
        .encodeJson<RemoteGoogleIndustryIdentifier>(
          this as RemoteGoogleIndustryIdentifier,
        );
  }

  Map<String, dynamic> toMap() {
    return RemoteGoogleIndustryIdentifierMapper.ensureInitialized()
        .encodeMap<RemoteGoogleIndustryIdentifier>(
          this as RemoteGoogleIndustryIdentifier,
        );
  }

  RemoteGoogleIndustryIdentifierCopyWith<
    RemoteGoogleIndustryIdentifier,
    RemoteGoogleIndustryIdentifier,
    RemoteGoogleIndustryIdentifier
  >
  get copyWith =>
      _RemoteGoogleIndustryIdentifierCopyWithImpl<
        RemoteGoogleIndustryIdentifier,
        RemoteGoogleIndustryIdentifier
      >(this as RemoteGoogleIndustryIdentifier, $identity, $identity);
  @override
  String toString() {
    return RemoteGoogleIndustryIdentifierMapper.ensureInitialized()
        .stringifyValue(this as RemoteGoogleIndustryIdentifier);
  }

  @override
  bool operator ==(Object other) {
    return RemoteGoogleIndustryIdentifierMapper.ensureInitialized().equalsValue(
      this as RemoteGoogleIndustryIdentifier,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteGoogleIndustryIdentifierMapper.ensureInitialized().hashValue(
      this as RemoteGoogleIndustryIdentifier,
    );
  }
}

extension RemoteGoogleIndustryIdentifierValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteGoogleIndustryIdentifier, $Out> {
  RemoteGoogleIndustryIdentifierCopyWith<
    $R,
    RemoteGoogleIndustryIdentifier,
    $Out
  >
  get $asRemoteGoogleIndustryIdentifier => $base.as(
    (v, t, t2) =>
        _RemoteGoogleIndustryIdentifierCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RemoteGoogleIndustryIdentifierCopyWith<
  $R,
  $In extends RemoteGoogleIndustryIdentifier,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? type, String? identifier});
  RemoteGoogleIndustryIdentifierCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteGoogleIndustryIdentifierCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteGoogleIndustryIdentifier, $Out>
    implements
        RemoteGoogleIndustryIdentifierCopyWith<
          $R,
          RemoteGoogleIndustryIdentifier,
          $Out
        > {
  _RemoteGoogleIndustryIdentifierCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<RemoteGoogleIndustryIdentifier> $mapper =
      RemoteGoogleIndustryIdentifierMapper.ensureInitialized();
  @override
  $R call({Object? type = $none, Object? identifier = $none}) => $apply(
    FieldCopyWithData({
      if (type != $none) #type: type,
      if (identifier != $none) #identifier: identifier,
    }),
  );
  @override
  RemoteGoogleIndustryIdentifier $make(CopyWithData data) =>
      RemoteGoogleIndustryIdentifier(
        type: data.get(#type, or: $value.type),
        identifier: data.get(#identifier, or: $value.identifier),
      );

  @override
  RemoteGoogleIndustryIdentifierCopyWith<
    $R2,
    RemoteGoogleIndustryIdentifier,
    $Out2
  >
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RemoteGoogleIndustryIdentifierCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RemoteGoogleImageLinksMapper
    extends ClassMapperBase<RemoteGoogleImageLinks> {
  RemoteGoogleImageLinksMapper._();

  static RemoteGoogleImageLinksMapper? _instance;
  static RemoteGoogleImageLinksMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteGoogleImageLinksMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteGoogleImageLinks';

  static String? _$thumbnail(RemoteGoogleImageLinks v) => v.thumbnail;
  static const Field<RemoteGoogleImageLinks, String> _f$thumbnail = Field(
    'thumbnail',
    _$thumbnail,
  );
  static String? _$smallThumbnail(RemoteGoogleImageLinks v) => v.smallThumbnail;
  static const Field<RemoteGoogleImageLinks, String> _f$smallThumbnail = Field(
    'smallThumbnail',
    _$smallThumbnail,
  );

  @override
  final MappableFields<RemoteGoogleImageLinks> fields = const {
    #thumbnail: _f$thumbnail,
    #smallThumbnail: _f$smallThumbnail,
  };

  static RemoteGoogleImageLinks _instantiate(DecodingData data) {
    return RemoteGoogleImageLinks(
      thumbnail: data.dec(_f$thumbnail),
      smallThumbnail: data.dec(_f$smallThumbnail),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteGoogleImageLinks fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteGoogleImageLinks>(map);
  }

  static RemoteGoogleImageLinks fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteGoogleImageLinks>(json);
  }
}

mixin RemoteGoogleImageLinksMappable {
  String toJson() {
    return RemoteGoogleImageLinksMapper.ensureInitialized()
        .encodeJson<RemoteGoogleImageLinks>(this as RemoteGoogleImageLinks);
  }

  Map<String, dynamic> toMap() {
    return RemoteGoogleImageLinksMapper.ensureInitialized()
        .encodeMap<RemoteGoogleImageLinks>(this as RemoteGoogleImageLinks);
  }

  RemoteGoogleImageLinksCopyWith<
    RemoteGoogleImageLinks,
    RemoteGoogleImageLinks,
    RemoteGoogleImageLinks
  >
  get copyWith =>
      _RemoteGoogleImageLinksCopyWithImpl<
        RemoteGoogleImageLinks,
        RemoteGoogleImageLinks
      >(this as RemoteGoogleImageLinks, $identity, $identity);
  @override
  String toString() {
    return RemoteGoogleImageLinksMapper.ensureInitialized().stringifyValue(
      this as RemoteGoogleImageLinks,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteGoogleImageLinksMapper.ensureInitialized().equalsValue(
      this as RemoteGoogleImageLinks,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteGoogleImageLinksMapper.ensureInitialized().hashValue(
      this as RemoteGoogleImageLinks,
    );
  }
}

extension RemoteGoogleImageLinksValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteGoogleImageLinks, $Out> {
  RemoteGoogleImageLinksCopyWith<$R, RemoteGoogleImageLinks, $Out>
  get $asRemoteGoogleImageLinks => $base.as(
    (v, t, t2) => _RemoteGoogleImageLinksCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RemoteGoogleImageLinksCopyWith<
  $R,
  $In extends RemoteGoogleImageLinks,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? thumbnail, String? smallThumbnail});
  RemoteGoogleImageLinksCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteGoogleImageLinksCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteGoogleImageLinks, $Out>
    implements
        RemoteGoogleImageLinksCopyWith<$R, RemoteGoogleImageLinks, $Out> {
  _RemoteGoogleImageLinksCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteGoogleImageLinks> $mapper =
      RemoteGoogleImageLinksMapper.ensureInitialized();
  @override
  $R call({Object? thumbnail = $none, Object? smallThumbnail = $none}) =>
      $apply(
        FieldCopyWithData({
          if (thumbnail != $none) #thumbnail: thumbnail,
          if (smallThumbnail != $none) #smallThumbnail: smallThumbnail,
        }),
      );
  @override
  RemoteGoogleImageLinks $make(CopyWithData data) => RemoteGoogleImageLinks(
    thumbnail: data.get(#thumbnail, or: $value.thumbnail),
    smallThumbnail: data.get(#smallThumbnail, or: $value.smallThumbnail),
  );

  @override
  RemoteGoogleImageLinksCopyWith<$R2, RemoteGoogleImageLinks, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RemoteGoogleImageLinksCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

