// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'remote_open_library_book.dart';

class RemoteOpenLibraryBookMapper
    extends ClassMapperBase<RemoteOpenLibraryBook> {
  RemoteOpenLibraryBookMapper._();

  static RemoteOpenLibraryBookMapper? _instance;
  static RemoteOpenLibraryBookMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteOpenLibraryBookMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteOpenLibraryBook';

  static String? _$title(RemoteOpenLibraryBook v) => v.title;
  static const Field<RemoteOpenLibraryBook, String> _f$title = Field(
    'title',
    _$title,
  );
  static List<String>? _$authorNames(RemoteOpenLibraryBook v) => v.authorNames;
  static const Field<RemoteOpenLibraryBook, List<String>> _f$authorNames =
      Field('authorNames', _$authorNames, key: r'author_name');
  static List<String>? _$isbn(RemoteOpenLibraryBook v) => v.isbn;
  static const Field<RemoteOpenLibraryBook, List<String>> _f$isbn = Field(
    'isbn',
    _$isbn,
  );
  static int? _$coverId(RemoteOpenLibraryBook v) => v.coverId;
  static const Field<RemoteOpenLibraryBook, int> _f$coverId = Field(
    'coverId',
    _$coverId,
    key: r'cover_i',
  );

  @override
  final MappableFields<RemoteOpenLibraryBook> fields = const {
    #title: _f$title,
    #authorNames: _f$authorNames,
    #isbn: _f$isbn,
    #coverId: _f$coverId,
  };

  static RemoteOpenLibraryBook _instantiate(DecodingData data) {
    return RemoteOpenLibraryBook(
      title: data.dec(_f$title),
      authorNames: data.dec(_f$authorNames),
      isbn: data.dec(_f$isbn),
      coverId: data.dec(_f$coverId),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteOpenLibraryBook fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteOpenLibraryBook>(map);
  }

  static RemoteOpenLibraryBook fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteOpenLibraryBook>(json);
  }
}

mixin RemoteOpenLibraryBookMappable {
  String toJson() {
    return RemoteOpenLibraryBookMapper.ensureInitialized()
        .encodeJson<RemoteOpenLibraryBook>(this as RemoteOpenLibraryBook);
  }

  Map<String, dynamic> toMap() {
    return RemoteOpenLibraryBookMapper.ensureInitialized()
        .encodeMap<RemoteOpenLibraryBook>(this as RemoteOpenLibraryBook);
  }

  RemoteOpenLibraryBookCopyWith<
    RemoteOpenLibraryBook,
    RemoteOpenLibraryBook,
    RemoteOpenLibraryBook
  >
  get copyWith =>
      _RemoteOpenLibraryBookCopyWithImpl<
        RemoteOpenLibraryBook,
        RemoteOpenLibraryBook
      >(this as RemoteOpenLibraryBook, $identity, $identity);
  @override
  String toString() {
    return RemoteOpenLibraryBookMapper.ensureInitialized().stringifyValue(
      this as RemoteOpenLibraryBook,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteOpenLibraryBookMapper.ensureInitialized().equalsValue(
      this as RemoteOpenLibraryBook,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteOpenLibraryBookMapper.ensureInitialized().hashValue(
      this as RemoteOpenLibraryBook,
    );
  }
}

extension RemoteOpenLibraryBookValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteOpenLibraryBook, $Out> {
  RemoteOpenLibraryBookCopyWith<$R, RemoteOpenLibraryBook, $Out>
  get $asRemoteOpenLibraryBook => $base.as(
    (v, t, t2) => _RemoteOpenLibraryBookCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RemoteOpenLibraryBookCopyWith<
  $R,
  $In extends RemoteOpenLibraryBook,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get authorNames;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get isbn;
  $R call({
    String? title,
    List<String>? authorNames,
    List<String>? isbn,
    int? coverId,
  });
  RemoteOpenLibraryBookCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteOpenLibraryBookCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteOpenLibraryBook, $Out>
    implements RemoteOpenLibraryBookCopyWith<$R, RemoteOpenLibraryBook, $Out> {
  _RemoteOpenLibraryBookCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteOpenLibraryBook> $mapper =
      RemoteOpenLibraryBookMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get authorNames => $value.authorNames != null
      ? ListCopyWith(
          $value.authorNames!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(authorNames: v),
        )
      : null;
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get isbn =>
      $value.isbn != null
      ? ListCopyWith(
          $value.isbn!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(isbn: v),
        )
      : null;
  @override
  $R call({
    Object? title = $none,
    Object? authorNames = $none,
    Object? isbn = $none,
    Object? coverId = $none,
  }) => $apply(
    FieldCopyWithData({
      if (title != $none) #title: title,
      if (authorNames != $none) #authorNames: authorNames,
      if (isbn != $none) #isbn: isbn,
      if (coverId != $none) #coverId: coverId,
    }),
  );
  @override
  RemoteOpenLibraryBook $make(CopyWithData data) => RemoteOpenLibraryBook(
    title: data.get(#title, or: $value.title),
    authorNames: data.get(#authorNames, or: $value.authorNames),
    isbn: data.get(#isbn, or: $value.isbn),
    coverId: data.get(#coverId, or: $value.coverId),
  );

  @override
  RemoteOpenLibraryBookCopyWith<$R2, RemoteOpenLibraryBook, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RemoteOpenLibraryBookCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

