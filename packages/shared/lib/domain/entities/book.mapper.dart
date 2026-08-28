// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'book.dart';

class BookStatusMapper extends EnumMapper<BookStatus> {
  BookStatusMapper._();

  static BookStatusMapper? _instance;
  static BookStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookStatusMapper._());
    }
    return _instance!;
  }

  static BookStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BookStatus decode(dynamic value) {
    switch (value) {
      case r'reading':
        return BookStatus.reading;
      case r'finished':
        return BookStatus.finished;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BookStatus self) {
    switch (self) {
      case BookStatus.reading:
        return r'reading';
      case BookStatus.finished:
        return r'finished';
    }
  }
}

extension BookStatusMapperExtension on BookStatus {
  String toValue() {
    BookStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BookStatus>(this) as String;
  }
}

class BookMapper extends ClassMapperBase<Book> {
  BookMapper._();

  static BookMapper? _instance;
  static BookMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookMapper._());
      BookStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Book';

  static String _$id(Book v) => v.id;
  static const Field<Book, String> _f$id = Field('id', _$id);
  static String _$title(Book v) => v.title;
  static const Field<Book, String> _f$title = Field('title', _$title);
  static List<String> _$authors(Book v) => v.authors;
  static const Field<Book, List<String>> _f$authors = Field(
    'authors',
    _$authors,
  );
  static String? _$isbn(Book v) => v.isbn;
  static const Field<Book, String> _f$isbn = Field('isbn', _$isbn);
  static String? _$thumbnailUrl(Book v) => v.thumbnailUrl;
  static const Field<Book, String> _f$thumbnailUrl = Field(
    'thumbnailUrl',
    _$thumbnailUrl,
  );
  static BookStatus _$status(Book v) => v.status;
  static const Field<Book, BookStatus> _f$status = Field('status', _$status);
  static DateTime _$createdAt(Book v) => v.createdAt;
  static const Field<Book, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static DateTime _$lastUsedAt(Book v) => v.lastUsedAt;
  static const Field<Book, DateTime> _f$lastUsedAt = Field(
    'lastUsedAt',
    _$lastUsedAt,
  );

  @override
  final MappableFields<Book> fields = const {
    #id: _f$id,
    #title: _f$title,
    #authors: _f$authors,
    #isbn: _f$isbn,
    #thumbnailUrl: _f$thumbnailUrl,
    #status: _f$status,
    #createdAt: _f$createdAt,
    #lastUsedAt: _f$lastUsedAt,
  };

  static Book _instantiate(DecodingData data) {
    return Book(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      authors: data.dec(_f$authors),
      isbn: data.dec(_f$isbn),
      thumbnailUrl: data.dec(_f$thumbnailUrl),
      status: data.dec(_f$status),
      createdAt: data.dec(_f$createdAt),
      lastUsedAt: data.dec(_f$lastUsedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Book fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Book>(map);
  }

  static Book fromJson(String json) {
    return ensureInitialized().decodeJson<Book>(json);
  }
}

mixin BookMappable {
  String toJson() {
    return BookMapper.ensureInitialized().encodeJson<Book>(this as Book);
  }

  Map<String, dynamic> toMap() {
    return BookMapper.ensureInitialized().encodeMap<Book>(this as Book);
  }

  BookCopyWith<Book, Book, Book> get copyWith =>
      _BookCopyWithImpl<Book, Book>(this as Book, $identity, $identity);
  @override
  String toString() {
    return BookMapper.ensureInitialized().stringifyValue(this as Book);
  }

  @override
  bool operator ==(Object other) {
    return BookMapper.ensureInitialized().equalsValue(this as Book, other);
  }

  @override
  int get hashCode {
    return BookMapper.ensureInitialized().hashValue(this as Book);
  }
}

extension BookValueCopy<$R, $Out> on ObjectCopyWith<$R, Book, $Out> {
  BookCopyWith<$R, Book, $Out> get $asBook =>
      $base.as((v, t, t2) => _BookCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BookCopyWith<$R, $In extends Book, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get authors;
  $R call({
    String? id,
    String? title,
    List<String>? authors,
    String? isbn,
    String? thumbnailUrl,
    BookStatus? status,
    DateTime? createdAt,
    DateTime? lastUsedAt,
  });
  BookCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BookCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Book, $Out>
    implements BookCopyWith<$R, Book, $Out> {
  _BookCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Book> $mapper = BookMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get authors =>
      ListCopyWith(
        $value.authors,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(authors: v),
      );
  @override
  $R call({
    String? id,
    String? title,
    List<String>? authors,
    Object? isbn = $none,
    Object? thumbnailUrl = $none,
    BookStatus? status,
    DateTime? createdAt,
    DateTime? lastUsedAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (authors != null) #authors: authors,
      if (isbn != $none) #isbn: isbn,
      if (thumbnailUrl != $none) #thumbnailUrl: thumbnailUrl,
      if (status != null) #status: status,
      if (createdAt != null) #createdAt: createdAt,
      if (lastUsedAt != null) #lastUsedAt: lastUsedAt,
    }),
  );
  @override
  Book $make(CopyWithData data) => Book(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    authors: data.get(#authors, or: $value.authors),
    isbn: data.get(#isbn, or: $value.isbn),
    thumbnailUrl: data.get(#thumbnailUrl, or: $value.thumbnailUrl),
    status: data.get(#status, or: $value.status),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    lastUsedAt: data.get(#lastUsedAt, or: $value.lastUsedAt),
  );

  @override
  BookCopyWith<$R2, Book, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BookCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

