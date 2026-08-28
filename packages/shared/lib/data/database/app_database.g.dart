// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BooksTable extends Books with TableInfo<$BooksTable, LocalBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> authors =
      GeneratedColumn<String>(
        'authors',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>($BooksTable.$converterauthors);
  static const VerificationMeta _isbnMeta = const VerificationMeta('isbn');
  @override
  late final GeneratedColumn<String> isbn = GeneratedColumn<String>(
    'isbn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _thumbnailUrlMeta = const VerificationMeta(
    'thumbnailUrl',
  );
  @override
  late final GeneratedColumn<String> thumbnailUrl = GeneratedColumn<String>(
    'thumbnail_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(_statusReading),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUsedAtMeta = const VerificationMeta(
    'lastUsedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsedAt = GeneratedColumn<DateTime>(
    'last_used_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    authors,
    isbn,
    thumbnailUrl,
    status,
    createdAt,
    lastUsedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalBook> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('isbn')) {
      context.handle(
        _isbnMeta,
        isbn.isAcceptableOrUnknown(data['isbn']!, _isbnMeta),
      );
    }
    if (data.containsKey('thumbnail_url')) {
      context.handle(
        _thumbnailUrlMeta,
        thumbnailUrl.isAcceptableOrUnknown(
          data['thumbnail_url']!,
          _thumbnailUrlMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_used_at')) {
      context.handle(
        _lastUsedAtMeta,
        lastUsedAt.isAcceptableOrUnknown(
          data['last_used_at']!,
          _lastUsedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUsedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalBook(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      authors: $BooksTable.$converterauthors.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}authors'],
        )!,
      ),
      isbn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isbn'],
      ),
      thumbnailUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_url'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastUsedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used_at'],
      )!,
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterauthors =
      const StringListConverter();
}

class LocalBook extends DataClass implements Insertable<LocalBook> {
  final String id;
  final String title;
  final List<String> authors;
  final String? isbn;
  final String? thumbnailUrl;
  final String status;
  final DateTime createdAt;
  final DateTime lastUsedAt;
  const LocalBook({
    required this.id,
    required this.title,
    required this.authors,
    this.isbn,
    this.thumbnailUrl,
    required this.status,
    required this.createdAt,
    required this.lastUsedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    {
      map['authors'] = Variable<String>(
        $BooksTable.$converterauthors.toSql(authors),
      );
    }
    if (!nullToAbsent || isbn != null) {
      map['isbn'] = Variable<String>(isbn);
    }
    if (!nullToAbsent || thumbnailUrl != null) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_used_at'] = Variable<DateTime>(lastUsedAt);
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      title: Value(title),
      authors: Value(authors),
      isbn: isbn == null && nullToAbsent ? const Value.absent() : Value(isbn),
      thumbnailUrl: thumbnailUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailUrl),
      status: Value(status),
      createdAt: Value(createdAt),
      lastUsedAt: Value(lastUsedAt),
    );
  }

  factory LocalBook.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalBook(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      authors: serializer.fromJson<List<String>>(json['authors']),
      isbn: serializer.fromJson<String?>(json['isbn']),
      thumbnailUrl: serializer.fromJson<String?>(json['thumbnailUrl']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUsedAt: serializer.fromJson<DateTime>(json['lastUsedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'authors': serializer.toJson<List<String>>(authors),
      'isbn': serializer.toJson<String?>(isbn),
      'thumbnailUrl': serializer.toJson<String?>(thumbnailUrl),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUsedAt': serializer.toJson<DateTime>(lastUsedAt),
    };
  }

  LocalBook copyWith({
    String? id,
    String? title,
    List<String>? authors,
    Value<String?> isbn = const Value.absent(),
    Value<String?> thumbnailUrl = const Value.absent(),
    String? status,
    DateTime? createdAt,
    DateTime? lastUsedAt,
  }) => LocalBook(
    id: id ?? this.id,
    title: title ?? this.title,
    authors: authors ?? this.authors,
    isbn: isbn.present ? isbn.value : this.isbn,
    thumbnailUrl: thumbnailUrl.present ? thumbnailUrl.value : this.thumbnailUrl,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    lastUsedAt: lastUsedAt ?? this.lastUsedAt,
  );
  LocalBook copyWithCompanion(BooksCompanion data) {
    return LocalBook(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      authors: data.authors.present ? data.authors.value : this.authors,
      isbn: data.isbn.present ? data.isbn.value : this.isbn,
      thumbnailUrl: data.thumbnailUrl.present
          ? data.thumbnailUrl.value
          : this.thumbnailUrl,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUsedAt: data.lastUsedAt.present
          ? data.lastUsedAt.value
          : this.lastUsedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalBook(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('authors: $authors, ')
          ..write('isbn: $isbn, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUsedAt: $lastUsedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    authors,
    isbn,
    thumbnailUrl,
    status,
    createdAt,
    lastUsedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalBook &&
          other.id == this.id &&
          other.title == this.title &&
          other.authors == this.authors &&
          other.isbn == this.isbn &&
          other.thumbnailUrl == this.thumbnailUrl &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.lastUsedAt == this.lastUsedAt);
}

class BooksCompanion extends UpdateCompanion<LocalBook> {
  final Value<String> id;
  final Value<String> title;
  final Value<List<String>> authors;
  final Value<String?> isbn;
  final Value<String?> thumbnailUrl;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastUsedAt;
  final Value<int> rowid;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.authors = const Value.absent(),
    this.isbn = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BooksCompanion.insert({
    required String id,
    required String title,
    required List<String> authors,
    this.isbn = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime createdAt,
    required DateTime lastUsedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       authors = Value(authors),
       createdAt = Value(createdAt),
       lastUsedAt = Value(lastUsedAt);
  static Insertable<LocalBook> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? authors,
    Expression<String>? isbn,
    Expression<String>? thumbnailUrl,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUsedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (authors != null) 'authors': authors,
      if (isbn != null) 'isbn': isbn,
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BooksCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<List<String>>? authors,
    Value<String?>? isbn,
    Value<String?>? thumbnailUrl,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? lastUsedAt,
    Value<int>? rowid,
  }) {
    return BooksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      isbn: isbn ?? this.isbn,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (authors.present) {
      map['authors'] = Variable<String>(
        $BooksTable.$converterauthors.toSql(authors.value),
      );
    }
    if (isbn.present) {
      map['isbn'] = Variable<String>(isbn.value);
    }
    if (thumbnailUrl.present) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('authors: $authors, ')
          ..write('isbn: $isbn, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, LocalBookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pageNumberMeta = const VerificationMeta(
    'pageNumber',
  );
  @override
  late final GeneratedColumn<int> pageNumber = GeneratedColumn<int>(
    'page_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quoteMeta = const VerificationMeta('quote');
  @override
  late final GeneratedColumn<String> quote = GeneratedColumn<String>(
    'quote',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voicePathMeta = const VerificationMeta(
    'voicePath',
  );
  @override
  late final GeneratedColumn<String> voicePath = GeneratedColumn<String>(
    'voice_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voiceDurationMsMeta = const VerificationMeta(
    'voiceDurationMs',
  );
  @override
  late final GeneratedColumn<int> voiceDurationMs = GeneratedColumn<int>(
    'voice_duration_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageAspectRatioMeta = const VerificationMeta(
    'imageAspectRatio',
  );
  @override
  late final GeneratedColumn<double> imageAspectRatio = GeneratedColumn<double>(
    'image_aspect_ratio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<HighlightRegion>, String>
  highlights = GeneratedColumn<String>(
    'highlights',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<List<HighlightRegion>>($BookmarksTable.$converterhighlights);
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    pageNumber,
    quote,
    note,
    voicePath,
    voiceDurationMs,
    photoPath,
    imageAspectRatio,
    highlights,
    isFavorite,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalBookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('page_number')) {
      context.handle(
        _pageNumberMeta,
        pageNumber.isAcceptableOrUnknown(data['page_number']!, _pageNumberMeta),
      );
    }
    if (data.containsKey('quote')) {
      context.handle(
        _quoteMeta,
        quote.isAcceptableOrUnknown(data['quote']!, _quoteMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('voice_path')) {
      context.handle(
        _voicePathMeta,
        voicePath.isAcceptableOrUnknown(data['voice_path']!, _voicePathMeta),
      );
    }
    if (data.containsKey('voice_duration_ms')) {
      context.handle(
        _voiceDurationMsMeta,
        voiceDurationMs.isAcceptableOrUnknown(
          data['voice_duration_ms']!,
          _voiceDurationMsMeta,
        ),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    } else if (isInserting) {
      context.missing(_photoPathMeta);
    }
    if (data.containsKey('image_aspect_ratio')) {
      context.handle(
        _imageAspectRatioMeta,
        imageAspectRatio.isAcceptableOrUnknown(
          data['image_aspect_ratio']!,
          _imageAspectRatioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_imageAspectRatioMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalBookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalBookmark(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      pageNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_number'],
      ),
      quote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      voicePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}voice_path'],
      ),
      voiceDurationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}voice_duration_ms'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      )!,
      imageAspectRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}image_aspect_ratio'],
      )!,
      highlights: $BookmarksTable.$converterhighlights.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}highlights'],
        )!,
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }

  static TypeConverter<List<HighlightRegion>, String> $converterhighlights =
      const HighlightListConverter();
}

class LocalBookmark extends DataClass implements Insertable<LocalBookmark> {
  final String id;
  final String bookId;
  final int? pageNumber;
  final String quote;
  final String? note;
  final String? voicePath;
  final int? voiceDurationMs;
  final String photoPath;
  final double imageAspectRatio;
  final List<HighlightRegion> highlights;
  final bool isFavorite;
  final DateTime createdAt;
  const LocalBookmark({
    required this.id,
    required this.bookId,
    this.pageNumber,
    required this.quote,
    this.note,
    this.voicePath,
    this.voiceDurationMs,
    required this.photoPath,
    required this.imageAspectRatio,
    required this.highlights,
    required this.isFavorite,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['book_id'] = Variable<String>(bookId);
    if (!nullToAbsent || pageNumber != null) {
      map['page_number'] = Variable<int>(pageNumber);
    }
    map['quote'] = Variable<String>(quote);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || voicePath != null) {
      map['voice_path'] = Variable<String>(voicePath);
    }
    if (!nullToAbsent || voiceDurationMs != null) {
      map['voice_duration_ms'] = Variable<int>(voiceDurationMs);
    }
    map['photo_path'] = Variable<String>(photoPath);
    map['image_aspect_ratio'] = Variable<double>(imageAspectRatio);
    {
      map['highlights'] = Variable<String>(
        $BookmarksTable.$converterhighlights.toSql(highlights),
      );
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      bookId: Value(bookId),
      pageNumber: pageNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(pageNumber),
      quote: Value(quote),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      voicePath: voicePath == null && nullToAbsent
          ? const Value.absent()
          : Value(voicePath),
      voiceDurationMs: voiceDurationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(voiceDurationMs),
      photoPath: Value(photoPath),
      imageAspectRatio: Value(imageAspectRatio),
      highlights: Value(highlights),
      isFavorite: Value(isFavorite),
      createdAt: Value(createdAt),
    );
  }

  factory LocalBookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalBookmark(
      id: serializer.fromJson<String>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      pageNumber: serializer.fromJson<int?>(json['pageNumber']),
      quote: serializer.fromJson<String>(json['quote']),
      note: serializer.fromJson<String?>(json['note']),
      voicePath: serializer.fromJson<String?>(json['voicePath']),
      voiceDurationMs: serializer.fromJson<int?>(json['voiceDurationMs']),
      photoPath: serializer.fromJson<String>(json['photoPath']),
      imageAspectRatio: serializer.fromJson<double>(json['imageAspectRatio']),
      highlights: serializer.fromJson<List<HighlightRegion>>(
        json['highlights'],
      ),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bookId': serializer.toJson<String>(bookId),
      'pageNumber': serializer.toJson<int?>(pageNumber),
      'quote': serializer.toJson<String>(quote),
      'note': serializer.toJson<String?>(note),
      'voicePath': serializer.toJson<String?>(voicePath),
      'voiceDurationMs': serializer.toJson<int?>(voiceDurationMs),
      'photoPath': serializer.toJson<String>(photoPath),
      'imageAspectRatio': serializer.toJson<double>(imageAspectRatio),
      'highlights': serializer.toJson<List<HighlightRegion>>(highlights),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalBookmark copyWith({
    String? id,
    String? bookId,
    Value<int?> pageNumber = const Value.absent(),
    String? quote,
    Value<String?> note = const Value.absent(),
    Value<String?> voicePath = const Value.absent(),
    Value<int?> voiceDurationMs = const Value.absent(),
    String? photoPath,
    double? imageAspectRatio,
    List<HighlightRegion>? highlights,
    bool? isFavorite,
    DateTime? createdAt,
  }) => LocalBookmark(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    pageNumber: pageNumber.present ? pageNumber.value : this.pageNumber,
    quote: quote ?? this.quote,
    note: note.present ? note.value : this.note,
    voicePath: voicePath.present ? voicePath.value : this.voicePath,
    voiceDurationMs: voiceDurationMs.present
        ? voiceDurationMs.value
        : this.voiceDurationMs,
    photoPath: photoPath ?? this.photoPath,
    imageAspectRatio: imageAspectRatio ?? this.imageAspectRatio,
    highlights: highlights ?? this.highlights,
    isFavorite: isFavorite ?? this.isFavorite,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalBookmark copyWithCompanion(BookmarksCompanion data) {
    return LocalBookmark(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      pageNumber: data.pageNumber.present
          ? data.pageNumber.value
          : this.pageNumber,
      quote: data.quote.present ? data.quote.value : this.quote,
      note: data.note.present ? data.note.value : this.note,
      voicePath: data.voicePath.present ? data.voicePath.value : this.voicePath,
      voiceDurationMs: data.voiceDurationMs.present
          ? data.voiceDurationMs.value
          : this.voiceDurationMs,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      imageAspectRatio: data.imageAspectRatio.present
          ? data.imageAspectRatio.value
          : this.imageAspectRatio,
      highlights: data.highlights.present
          ? data.highlights.value
          : this.highlights,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalBookmark(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('quote: $quote, ')
          ..write('note: $note, ')
          ..write('voicePath: $voicePath, ')
          ..write('voiceDurationMs: $voiceDurationMs, ')
          ..write('photoPath: $photoPath, ')
          ..write('imageAspectRatio: $imageAspectRatio, ')
          ..write('highlights: $highlights, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    pageNumber,
    quote,
    note,
    voicePath,
    voiceDurationMs,
    photoPath,
    imageAspectRatio,
    highlights,
    isFavorite,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalBookmark &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.pageNumber == this.pageNumber &&
          other.quote == this.quote &&
          other.note == this.note &&
          other.voicePath == this.voicePath &&
          other.voiceDurationMs == this.voiceDurationMs &&
          other.photoPath == this.photoPath &&
          other.imageAspectRatio == this.imageAspectRatio &&
          other.highlights == this.highlights &&
          other.isFavorite == this.isFavorite &&
          other.createdAt == this.createdAt);
}

class BookmarksCompanion extends UpdateCompanion<LocalBookmark> {
  final Value<String> id;
  final Value<String> bookId;
  final Value<int?> pageNumber;
  final Value<String> quote;
  final Value<String?> note;
  final Value<String?> voicePath;
  final Value<int?> voiceDurationMs;
  final Value<String> photoPath;
  final Value<double> imageAspectRatio;
  final Value<List<HighlightRegion>> highlights;
  final Value<bool> isFavorite;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.pageNumber = const Value.absent(),
    this.quote = const Value.absent(),
    this.note = const Value.absent(),
    this.voicePath = const Value.absent(),
    this.voiceDurationMs = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.imageAspectRatio = const Value.absent(),
    this.highlights = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookmarksCompanion.insert({
    required String id,
    required String bookId,
    this.pageNumber = const Value.absent(),
    required String quote,
    this.note = const Value.absent(),
    this.voicePath = const Value.absent(),
    this.voiceDurationMs = const Value.absent(),
    required String photoPath,
    required double imageAspectRatio,
    required List<HighlightRegion> highlights,
    this.isFavorite = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       bookId = Value(bookId),
       quote = Value(quote),
       photoPath = Value(photoPath),
       imageAspectRatio = Value(imageAspectRatio),
       highlights = Value(highlights),
       createdAt = Value(createdAt);
  static Insertable<LocalBookmark> custom({
    Expression<String>? id,
    Expression<String>? bookId,
    Expression<int>? pageNumber,
    Expression<String>? quote,
    Expression<String>? note,
    Expression<String>? voicePath,
    Expression<int>? voiceDurationMs,
    Expression<String>? photoPath,
    Expression<double>? imageAspectRatio,
    Expression<String>? highlights,
    Expression<bool>? isFavorite,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (pageNumber != null) 'page_number': pageNumber,
      if (quote != null) 'quote': quote,
      if (note != null) 'note': note,
      if (voicePath != null) 'voice_path': voicePath,
      if (voiceDurationMs != null) 'voice_duration_ms': voiceDurationMs,
      if (photoPath != null) 'photo_path': photoPath,
      if (imageAspectRatio != null) 'image_aspect_ratio': imageAspectRatio,
      if (highlights != null) 'highlights': highlights,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookmarksCompanion copyWith({
    Value<String>? id,
    Value<String>? bookId,
    Value<int?>? pageNumber,
    Value<String>? quote,
    Value<String?>? note,
    Value<String?>? voicePath,
    Value<int?>? voiceDurationMs,
    Value<String>? photoPath,
    Value<double>? imageAspectRatio,
    Value<List<HighlightRegion>>? highlights,
    Value<bool>? isFavorite,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return BookmarksCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      pageNumber: pageNumber ?? this.pageNumber,
      quote: quote ?? this.quote,
      note: note ?? this.note,
      voicePath: voicePath ?? this.voicePath,
      voiceDurationMs: voiceDurationMs ?? this.voiceDurationMs,
      photoPath: photoPath ?? this.photoPath,
      imageAspectRatio: imageAspectRatio ?? this.imageAspectRatio,
      highlights: highlights ?? this.highlights,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (pageNumber.present) {
      map['page_number'] = Variable<int>(pageNumber.value);
    }
    if (quote.present) {
      map['quote'] = Variable<String>(quote.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (voicePath.present) {
      map['voice_path'] = Variable<String>(voicePath.value);
    }
    if (voiceDurationMs.present) {
      map['voice_duration_ms'] = Variable<int>(voiceDurationMs.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (imageAspectRatio.present) {
      map['image_aspect_ratio'] = Variable<double>(imageAspectRatio.value);
    }
    if (highlights.present) {
      map['highlights'] = Variable<String>(
        $BookmarksTable.$converterhighlights.toSql(highlights.value),
      );
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('quote: $quote, ')
          ..write('note: $note, ')
          ..write('voicePath: $voicePath, ')
          ..write('voiceDurationMs: $voiceDurationMs, ')
          ..write('photoPath: $photoPath, ')
          ..write('imageAspectRatio: $imageAspectRatio, ')
          ..write('highlights: $highlights, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ThemesTable extends Themes with TableInfo<$ThemesTable, LocalTheme> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThemesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accentMeta = const VerificationMeta('accent');
  @override
  late final GeneratedColumn<String> accent = GeneratedColumn<String>(
    'accent',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, accent, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'themes';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalTheme> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('accent')) {
      context.handle(
        _accentMeta,
        accent.isAcceptableOrUnknown(data['accent']!, _accentMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalTheme map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalTheme(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      accent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accent'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ThemesTable createAlias(String alias) {
    return $ThemesTable(attachedDatabase, alias);
  }
}

class LocalTheme extends DataClass implements Insertable<LocalTheme> {
  final String id;
  final String name;
  final String? accent;
  final DateTime createdAt;
  const LocalTheme({
    required this.id,
    required this.name,
    this.accent,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || accent != null) {
      map['accent'] = Variable<String>(accent);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ThemesCompanion toCompanion(bool nullToAbsent) {
    return ThemesCompanion(
      id: Value(id),
      name: Value(name),
      accent: accent == null && nullToAbsent
          ? const Value.absent()
          : Value(accent),
      createdAt: Value(createdAt),
    );
  }

  factory LocalTheme.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalTheme(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      accent: serializer.fromJson<String?>(json['accent']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'accent': serializer.toJson<String?>(accent),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalTheme copyWith({
    String? id,
    String? name,
    Value<String?> accent = const Value.absent(),
    DateTime? createdAt,
  }) => LocalTheme(
    id: id ?? this.id,
    name: name ?? this.name,
    accent: accent.present ? accent.value : this.accent,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalTheme copyWithCompanion(ThemesCompanion data) {
    return LocalTheme(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      accent: data.accent.present ? data.accent.value : this.accent,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalTheme(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('accent: $accent, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, accent, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalTheme &&
          other.id == this.id &&
          other.name == this.name &&
          other.accent == this.accent &&
          other.createdAt == this.createdAt);
}

class ThemesCompanion extends UpdateCompanion<LocalTheme> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> accent;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ThemesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.accent = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ThemesCompanion.insert({
    required String id,
    required String name,
    this.accent = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<LocalTheme> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? accent,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (accent != null) 'accent': accent,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ThemesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? accent,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ThemesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      accent: accent ?? this.accent,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (accent.present) {
      map['accent'] = Variable<String>(accent.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThemesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('accent: $accent, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ThemeMarksTable extends ThemeMarks
    with TableInfo<$ThemeMarksTable, LocalThemeMark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThemeMarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _themeIdMeta = const VerificationMeta(
    'themeId',
  );
  @override
  late final GeneratedColumn<String> themeId = GeneratedColumn<String>(
    'theme_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES themes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _bookmarkIdMeta = const VerificationMeta(
    'bookmarkId',
  );
  @override
  late final GeneratedColumn<String> bookmarkId = GeneratedColumn<String>(
    'bookmark_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bookmarks (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [themeId, bookmarkId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'theme_marks';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalThemeMark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('theme_id')) {
      context.handle(
        _themeIdMeta,
        themeId.isAcceptableOrUnknown(data['theme_id']!, _themeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_themeIdMeta);
    }
    if (data.containsKey('bookmark_id')) {
      context.handle(
        _bookmarkIdMeta,
        bookmarkId.isAcceptableOrUnknown(data['bookmark_id']!, _bookmarkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookmarkIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {themeId, bookmarkId};
  @override
  LocalThemeMark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalThemeMark(
      themeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_id'],
      )!,
      bookmarkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bookmark_id'],
      )!,
    );
  }

  @override
  $ThemeMarksTable createAlias(String alias) {
    return $ThemeMarksTable(attachedDatabase, alias);
  }
}

class LocalThemeMark extends DataClass implements Insertable<LocalThemeMark> {
  final String themeId;
  final String bookmarkId;
  const LocalThemeMark({required this.themeId, required this.bookmarkId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['theme_id'] = Variable<String>(themeId);
    map['bookmark_id'] = Variable<String>(bookmarkId);
    return map;
  }

  ThemeMarksCompanion toCompanion(bool nullToAbsent) {
    return ThemeMarksCompanion(
      themeId: Value(themeId),
      bookmarkId: Value(bookmarkId),
    );
  }

  factory LocalThemeMark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalThemeMark(
      themeId: serializer.fromJson<String>(json['themeId']),
      bookmarkId: serializer.fromJson<String>(json['bookmarkId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'themeId': serializer.toJson<String>(themeId),
      'bookmarkId': serializer.toJson<String>(bookmarkId),
    };
  }

  LocalThemeMark copyWith({String? themeId, String? bookmarkId}) =>
      LocalThemeMark(
        themeId: themeId ?? this.themeId,
        bookmarkId: bookmarkId ?? this.bookmarkId,
      );
  LocalThemeMark copyWithCompanion(ThemeMarksCompanion data) {
    return LocalThemeMark(
      themeId: data.themeId.present ? data.themeId.value : this.themeId,
      bookmarkId: data.bookmarkId.present
          ? data.bookmarkId.value
          : this.bookmarkId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalThemeMark(')
          ..write('themeId: $themeId, ')
          ..write('bookmarkId: $bookmarkId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(themeId, bookmarkId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalThemeMark &&
          other.themeId == this.themeId &&
          other.bookmarkId == this.bookmarkId);
}

class ThemeMarksCompanion extends UpdateCompanion<LocalThemeMark> {
  final Value<String> themeId;
  final Value<String> bookmarkId;
  final Value<int> rowid;
  const ThemeMarksCompanion({
    this.themeId = const Value.absent(),
    this.bookmarkId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ThemeMarksCompanion.insert({
    required String themeId,
    required String bookmarkId,
    this.rowid = const Value.absent(),
  }) : themeId = Value(themeId),
       bookmarkId = Value(bookmarkId);
  static Insertable<LocalThemeMark> custom({
    Expression<String>? themeId,
    Expression<String>? bookmarkId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (themeId != null) 'theme_id': themeId,
      if (bookmarkId != null) 'bookmark_id': bookmarkId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ThemeMarksCompanion copyWith({
    Value<String>? themeId,
    Value<String>? bookmarkId,
    Value<int>? rowid,
  }) {
    return ThemeMarksCompanion(
      themeId: themeId ?? this.themeId,
      bookmarkId: bookmarkId ?? this.bookmarkId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (themeId.present) {
      map['theme_id'] = Variable<String>(themeId.value);
    }
    if (bookmarkId.present) {
      map['bookmark_id'] = Variable<String>(bookmarkId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThemeMarksCompanion(')
          ..write('themeId: $themeId, ')
          ..write('bookmarkId: $bookmarkId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShelvesTable extends Shelves with TableInfo<$ShelvesTable, LocalShelf> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShelvesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accentMeta = const VerificationMeta('accent');
  @override
  late final GeneratedColumn<String> accent = GeneratedColumn<String>(
    'accent',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, accent, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shelves';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalShelf> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('accent')) {
      context.handle(
        _accentMeta,
        accent.isAcceptableOrUnknown(data['accent']!, _accentMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalShelf map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalShelf(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      accent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accent'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ShelvesTable createAlias(String alias) {
    return $ShelvesTable(attachedDatabase, alias);
  }
}

class LocalShelf extends DataClass implements Insertable<LocalShelf> {
  final String id;
  final String name;
  final String? accent;
  final DateTime createdAt;
  const LocalShelf({
    required this.id,
    required this.name,
    this.accent,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || accent != null) {
      map['accent'] = Variable<String>(accent);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ShelvesCompanion toCompanion(bool nullToAbsent) {
    return ShelvesCompanion(
      id: Value(id),
      name: Value(name),
      accent: accent == null && nullToAbsent
          ? const Value.absent()
          : Value(accent),
      createdAt: Value(createdAt),
    );
  }

  factory LocalShelf.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalShelf(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      accent: serializer.fromJson<String?>(json['accent']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'accent': serializer.toJson<String?>(accent),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalShelf copyWith({
    String? id,
    String? name,
    Value<String?> accent = const Value.absent(),
    DateTime? createdAt,
  }) => LocalShelf(
    id: id ?? this.id,
    name: name ?? this.name,
    accent: accent.present ? accent.value : this.accent,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalShelf copyWithCompanion(ShelvesCompanion data) {
    return LocalShelf(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      accent: data.accent.present ? data.accent.value : this.accent,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalShelf(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('accent: $accent, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, accent, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalShelf &&
          other.id == this.id &&
          other.name == this.name &&
          other.accent == this.accent &&
          other.createdAt == this.createdAt);
}

class ShelvesCompanion extends UpdateCompanion<LocalShelf> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> accent;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ShelvesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.accent = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShelvesCompanion.insert({
    required String id,
    required String name,
    this.accent = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<LocalShelf> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? accent,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (accent != null) 'accent': accent,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShelvesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? accent,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ShelvesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      accent: accent ?? this.accent,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (accent.present) {
      map['accent'] = Variable<String>(accent.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShelvesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('accent: $accent, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShelfBooksTable extends ShelfBooks
    with TableInfo<$ShelfBooksTable, LocalShelfBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShelfBooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _shelfIdMeta = const VerificationMeta(
    'shelfId',
  );
  @override
  late final GeneratedColumn<String> shelfId = GeneratedColumn<String>(
    'shelf_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shelves (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [shelfId, bookId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shelf_books';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalShelfBook> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('shelf_id')) {
      context.handle(
        _shelfIdMeta,
        shelfId.isAcceptableOrUnknown(data['shelf_id']!, _shelfIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shelfIdMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {shelfId, bookId};
  @override
  LocalShelfBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalShelfBook(
      shelfId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shelf_id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
    );
  }

  @override
  $ShelfBooksTable createAlias(String alias) {
    return $ShelfBooksTable(attachedDatabase, alias);
  }
}

class LocalShelfBook extends DataClass implements Insertable<LocalShelfBook> {
  final String shelfId;
  final String bookId;
  const LocalShelfBook({required this.shelfId, required this.bookId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shelf_id'] = Variable<String>(shelfId);
    map['book_id'] = Variable<String>(bookId);
    return map;
  }

  ShelfBooksCompanion toCompanion(bool nullToAbsent) {
    return ShelfBooksCompanion(shelfId: Value(shelfId), bookId: Value(bookId));
  }

  factory LocalShelfBook.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalShelfBook(
      shelfId: serializer.fromJson<String>(json['shelfId']),
      bookId: serializer.fromJson<String>(json['bookId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shelfId': serializer.toJson<String>(shelfId),
      'bookId': serializer.toJson<String>(bookId),
    };
  }

  LocalShelfBook copyWith({String? shelfId, String? bookId}) => LocalShelfBook(
    shelfId: shelfId ?? this.shelfId,
    bookId: bookId ?? this.bookId,
  );
  LocalShelfBook copyWithCompanion(ShelfBooksCompanion data) {
    return LocalShelfBook(
      shelfId: data.shelfId.present ? data.shelfId.value : this.shelfId,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalShelfBook(')
          ..write('shelfId: $shelfId, ')
          ..write('bookId: $bookId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(shelfId, bookId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalShelfBook &&
          other.shelfId == this.shelfId &&
          other.bookId == this.bookId);
}

class ShelfBooksCompanion extends UpdateCompanion<LocalShelfBook> {
  final Value<String> shelfId;
  final Value<String> bookId;
  final Value<int> rowid;
  const ShelfBooksCompanion({
    this.shelfId = const Value.absent(),
    this.bookId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShelfBooksCompanion.insert({
    required String shelfId,
    required String bookId,
    this.rowid = const Value.absent(),
  }) : shelfId = Value(shelfId),
       bookId = Value(bookId);
  static Insertable<LocalShelfBook> custom({
    Expression<String>? shelfId,
    Expression<String>? bookId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shelfId != null) 'shelf_id': shelfId,
      if (bookId != null) 'book_id': bookId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShelfBooksCompanion copyWith({
    Value<String>? shelfId,
    Value<String>? bookId,
    Value<int>? rowid,
  }) {
    return ShelfBooksCompanion(
      shelfId: shelfId ?? this.shelfId,
      bookId: bookId ?? this.bookId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shelfId.present) {
      map['shelf_id'] = Variable<String>(shelfId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShelfBooksCompanion(')
          ..write('shelfId: $shelfId, ')
          ..write('bookId: $bookId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTableTable extends SettingsTable
    with TableInfo<$SettingsTableTable, LocalSettings> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localePreferenceMeta = const VerificationMeta(
    'localePreference',
  );
  @override
  late final GeneratedColumn<String> localePreference = GeneratedColumn<String>(
    'locale_preference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, displayName, localePreference];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSettings> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('locale_preference')) {
      context.handle(
        _localePreferenceMeta,
        localePreference.isAcceptableOrUnknown(
          data['locale_preference']!,
          _localePreferenceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSettings map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSettings(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      localePreference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale_preference'],
      ),
    );
  }

  @override
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }
}

class LocalSettings extends DataClass implements Insertable<LocalSettings> {
  final int id;
  final String? displayName;
  final String? localePreference;
  const LocalSettings({
    required this.id,
    this.displayName,
    this.localePreference,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || localePreference != null) {
      map['locale_preference'] = Variable<String>(localePreference);
    }
    return map;
  }

  SettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SettingsTableCompanion(
      id: Value(id),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      localePreference: localePreference == null && nullToAbsent
          ? const Value.absent()
          : Value(localePreference),
    );
  }

  factory LocalSettings.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSettings(
      id: serializer.fromJson<int>(json['id']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      localePreference: serializer.fromJson<String?>(json['localePreference']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'displayName': serializer.toJson<String?>(displayName),
      'localePreference': serializer.toJson<String?>(localePreference),
    };
  }

  LocalSettings copyWith({
    int? id,
    Value<String?> displayName = const Value.absent(),
    Value<String?> localePreference = const Value.absent(),
  }) => LocalSettings(
    id: id ?? this.id,
    displayName: displayName.present ? displayName.value : this.displayName,
    localePreference: localePreference.present
        ? localePreference.value
        : this.localePreference,
  );
  LocalSettings copyWithCompanion(SettingsTableCompanion data) {
    return LocalSettings(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      localePreference: data.localePreference.present
          ? data.localePreference.value
          : this.localePreference,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSettings(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('localePreference: $localePreference')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, displayName, localePreference);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSettings &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.localePreference == this.localePreference);
}

class SettingsTableCompanion extends UpdateCompanion<LocalSettings> {
  final Value<int> id;
  final Value<String?> displayName;
  final Value<String?> localePreference;
  const SettingsTableCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.localePreference = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.localePreference = const Value.absent(),
  });
  static Insertable<LocalSettings> custom({
    Expression<int>? id,
    Expression<String>? displayName,
    Expression<String>? localePreference,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (localePreference != null) 'locale_preference': localePreference,
    });
  }

  SettingsTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? displayName,
    Value<String?>? localePreference,
  }) {
    return SettingsTableCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      localePreference: localePreference ?? this.localePreference,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (localePreference.present) {
      map['locale_preference'] = Variable<String>(localePreference.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('localePreference: $localePreference')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BooksTable books = $BooksTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $ThemesTable themes = $ThemesTable(this);
  late final $ThemeMarksTable themeMarks = $ThemeMarksTable(this);
  late final $ShelvesTable shelves = $ShelvesTable(this);
  late final $ShelfBooksTable shelfBooks = $ShelfBooksTable(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    books,
    bookmarks,
    themes,
    themeMarks,
    shelves,
    shelfBooks,
    settingsTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'books',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('bookmarks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'themes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('theme_marks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'bookmarks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('theme_marks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'shelves',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('shelf_books', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'books',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('shelf_books', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$BooksTableCreateCompanionBuilder = BooksCompanion Function({
  required String id,
  required String title,
  required List<String> authors,
  Value<String?> isbn,
  Value<String?> thumbnailUrl,
  Value<String> status,
  required DateTime createdAt,
  required DateTime lastUsedAt,
  Value<int> rowid,
});
typedef $$BooksTableUpdateCompanionBuilder = BooksCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<List<String>> authors,
  Value<String?> isbn,
  Value<String?> thumbnailUrl,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> lastUsedAt,
  Value<int> rowid,
});

final class $$BooksTableReferences
    extends BaseReferences<_$AppDatabase, $BooksTable, LocalBook> {
  $$BooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BookmarksTable, List<LocalBookmark>>
  _bookmarksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bookmarks,
    aliasName: 'books__id__bookmarks__book_id',
  );

  $$BookmarksTableProcessedTableManager get bookmarksRefs {
    final manager = $$BookmarksTableTableManager(
      $_db,
      $_db.bookmarks,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookmarksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ShelfBooksTable, List<LocalShelfBook>>
  _shelfBooksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.shelfBooks,
    aliasName: 'books__id__shelf_books__book_id',
  );

  $$ShelfBooksTableProcessedTableManager get shelfBooksRefs {
    final manager = $$ShelfBooksTableTableManager(
      $_db,
      $_db.shelfBooks,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_shelfBooksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BooksTableFilterComposer extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get authors => $composableBuilder(
    column: $table.authors,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get isbn => $composableBuilder(
    column: $table.isbn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> bookmarksRefs(
    Expression<bool> Function($$BookmarksTableFilterComposer f) f,
  ) {
    final $$BookmarksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableFilterComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> shelfBooksRefs(
    Expression<bool> Function($$ShelfBooksTableFilterComposer f) f,
  ) {
    final $$ShelfBooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shelfBooks,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShelfBooksTableFilterComposer(
            $db: $db,
            $table: $db.shelfBooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authors => $composableBuilder(
    column: $table.authors,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get isbn => $composableBuilder(
    column: $table.isbn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get authors =>
      $composableBuilder(column: $table.authors, builder: (column) => column);

  GeneratedColumn<String> get isbn =>
      $composableBuilder(column: $table.isbn, builder: (column) => column);

  GeneratedColumn<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => column,
  );

  Expression<T> bookmarksRefs<T extends Object>(
    Expression<T> Function($$BookmarksTableAnnotationComposer a) f,
  ) {
    final $$BookmarksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableAnnotationComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> shelfBooksRefs<T extends Object>(
    Expression<T> Function($$ShelfBooksTableAnnotationComposer a) f,
  ) {
    final $$ShelfBooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shelfBooks,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShelfBooksTableAnnotationComposer(
            $db: $db,
            $table: $db.shelfBooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BooksTable,
          LocalBook,
          $$BooksTableFilterComposer,
          $$BooksTableOrderingComposer,
          $$BooksTableAnnotationComposer,
          $$BooksTableCreateCompanionBuilder,
          $$BooksTableUpdateCompanionBuilder,
          (LocalBook, $$BooksTableReferences),
          LocalBook,
          PrefetchHooks Function({bool bookmarksRefs, bool shelfBooksRefs})
        > {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<List<String>> authors = const Value.absent(),
                Value<String?> isbn = const Value.absent(),
                Value<String?> thumbnailUrl = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> lastUsedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion(
                id: id,
                title: title,
                authors: authors,
                isbn: isbn,
                thumbnailUrl: thumbnailUrl,
                status: status,
                createdAt: createdAt,
                lastUsedAt: lastUsedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required List<String> authors,
                Value<String?> isbn = const Value.absent(),
                Value<String?> thumbnailUrl = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime createdAt,
                required DateTime lastUsedAt,
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion.insert(
                id: id,
                title: title,
                authors: authors,
                isbn: isbn,
                thumbnailUrl: thumbnailUrl,
                status: status,
                createdAt: createdAt,
                lastUsedAt: lastUsedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$BooksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({bookmarksRefs = false, shelfBooksRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (bookmarksRefs) db.bookmarks,
                    if (shelfBooksRefs) db.shelfBooks,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (bookmarksRefs)
                        await $_getPrefetchedData<
                          LocalBook,
                          $BooksTable,
                          LocalBookmark
                        >(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._bookmarksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(
                                db,
                                table,
                                p0,
                              ).bookmarksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (shelfBooksRefs)
                        await $_getPrefetchedData<
                          LocalBook,
                          $BooksTable,
                          LocalShelfBook
                        >(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._shelfBooksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(
                                db,
                                table,
                                p0,
                              ).shelfBooksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BooksTable,
      LocalBook,
      $$BooksTableFilterComposer,
      $$BooksTableOrderingComposer,
      $$BooksTableAnnotationComposer,
      $$BooksTableCreateCompanionBuilder,
      $$BooksTableUpdateCompanionBuilder,
      (LocalBook, $$BooksTableReferences),
      LocalBook,
      PrefetchHooks Function({bool bookmarksRefs, bool shelfBooksRefs})
    >;
typedef $$BookmarksTableCreateCompanionBuilder = BookmarksCompanion Function({
  required String id,
  required String bookId,
  Value<int?> pageNumber,
  required String quote,
  Value<String?> note,
  Value<String?> voicePath,
  Value<int?> voiceDurationMs,
  required String photoPath,
  required double imageAspectRatio,
  required List<HighlightRegion> highlights,
  Value<bool> isFavorite,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$BookmarksTableUpdateCompanionBuilder = BookmarksCompanion Function({
  Value<String> id,
  Value<String> bookId,
  Value<int?> pageNumber,
  Value<String> quote,
  Value<String?> note,
  Value<String?> voicePath,
  Value<int?> voiceDurationMs,
  Value<String> photoPath,
  Value<double> imageAspectRatio,
  Value<List<HighlightRegion>> highlights,
  Value<bool> isFavorite,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$BookmarksTableReferences
    extends BaseReferences<_$AppDatabase, $BookmarksTable, LocalBookmark> {
  $$BookmarksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) =>
      db.books.createAlias('bookmarks__book_id__books__id');

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ThemeMarksTable, List<LocalThemeMark>>
  _themeMarksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.themeMarks,
    aliasName: 'bookmarks__id__theme_marks__bookmark_id',
  );

  $$ThemeMarksTableProcessedTableManager get themeMarksRefs {
    final manager = $$ThemeMarksTableTableManager(
      $_db,
      $_db.themeMarks,
    ).filter((f) => f.bookmarkId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_themeMarksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quote => $composableBuilder(
    column: $table.quote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get voicePath => $composableBuilder(
    column: $table.voicePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get voiceDurationMs => $composableBuilder(
    column: $table.voiceDurationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get imageAspectRatio => $composableBuilder(
    column: $table.imageAspectRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    List<HighlightRegion>,
    List<HighlightRegion>,
    String
  >
  get highlights => $composableBuilder(
    column: $table.highlights,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> themeMarksRefs(
    Expression<bool> Function($$ThemeMarksTableFilterComposer f) f,
  ) {
    final $$ThemeMarksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.themeMarks,
      getReferencedColumn: (t) => t.bookmarkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThemeMarksTableFilterComposer(
            $db: $db,
            $table: $db.themeMarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quote => $composableBuilder(
    column: $table.quote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get voicePath => $composableBuilder(
    column: $table.voicePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get voiceDurationMs => $composableBuilder(
    column: $table.voiceDurationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get imageAspectRatio => $composableBuilder(
    column: $table.imageAspectRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get highlights => $composableBuilder(
    column: $table.highlights,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quote =>
      $composableBuilder(column: $table.quote, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get voicePath =>
      $composableBuilder(column: $table.voicePath, builder: (column) => column);

  GeneratedColumn<int> get voiceDurationMs => $composableBuilder(
    column: $table.voiceDurationMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<double> get imageAspectRatio => $composableBuilder(
    column: $table.imageAspectRatio,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<HighlightRegion>, String>
  get highlights => $composableBuilder(
    column: $table.highlights,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> themeMarksRefs<T extends Object>(
    Expression<T> Function($$ThemeMarksTableAnnotationComposer a) f,
  ) {
    final $$ThemeMarksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.themeMarks,
      getReferencedColumn: (t) => t.bookmarkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThemeMarksTableAnnotationComposer(
            $db: $db,
            $table: $db.themeMarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTable,
          LocalBookmark,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (LocalBookmark, $$BookmarksTableReferences),
          LocalBookmark,
          PrefetchHooks Function({bool bookId, bool themeMarksRefs})
        > {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<int?> pageNumber = const Value.absent(),
                Value<String> quote = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> voicePath = const Value.absent(),
                Value<int?> voiceDurationMs = const Value.absent(),
                Value<String> photoPath = const Value.absent(),
                Value<double> imageAspectRatio = const Value.absent(),
                Value<List<HighlightRegion>> highlights = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookmarksCompanion(
                id: id,
                bookId: bookId,
                pageNumber: pageNumber,
                quote: quote,
                note: note,
                voicePath: voicePath,
                voiceDurationMs: voiceDurationMs,
                photoPath: photoPath,
                imageAspectRatio: imageAspectRatio,
                highlights: highlights,
                isFavorite: isFavorite,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String bookId,
                Value<int?> pageNumber = const Value.absent(),
                required String quote,
                Value<String?> note = const Value.absent(),
                Value<String?> voicePath = const Value.absent(),
                Value<int?> voiceDurationMs = const Value.absent(),
                required String photoPath,
                required double imageAspectRatio,
                required List<HighlightRegion> highlights,
                Value<bool> isFavorite = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => BookmarksCompanion.insert(
                id: id,
                bookId: bookId,
                pageNumber: pageNumber,
                quote: quote,
                note: note,
                voicePath: voicePath,
                voiceDurationMs: voiceDurationMs,
                photoPath: photoPath,
                imageAspectRatio: imageAspectRatio,
                highlights: highlights,
                isFavorite: isFavorite,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BookmarksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false, themeMarksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (themeMarksRefs) db.themeMarks],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bookId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.bookId,
                        referencedTable: $$BookmarksTableReferences
                            ._bookIdTable(db),
                        referencedColumn: $$BookmarksTableReferences
                            ._bookIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (themeMarksRefs)
                    await $_getPrefetchedData<
                      LocalBookmark,
                      $BookmarksTable,
                      LocalThemeMark
                    >(
                      currentTable: table,
                      referencedTable: $$BookmarksTableReferences
                          ._themeMarksRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BookmarksTableReferences(
                            db,
                            table,
                            p0,
                          ).themeMarksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.bookmarkId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTable,
      LocalBookmark,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (LocalBookmark, $$BookmarksTableReferences),
      LocalBookmark,
      PrefetchHooks Function({bool bookId, bool themeMarksRefs})
    >;
typedef $$ThemesTableCreateCompanionBuilder = ThemesCompanion Function({
  required String id,
  required String name,
  Value<String?> accent,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$ThemesTableUpdateCompanionBuilder = ThemesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> accent,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$ThemesTableReferences
    extends BaseReferences<_$AppDatabase, $ThemesTable, LocalTheme> {
  $$ThemesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ThemeMarksTable, List<LocalThemeMark>>
  _themeMarksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.themeMarks,
    aliasName: 'themes__id__theme_marks__theme_id',
  );

  $$ThemeMarksTableProcessedTableManager get themeMarksRefs {
    final manager = $$ThemeMarksTableTableManager(
      $_db,
      $_db.themeMarks,
    ).filter((f) => f.themeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_themeMarksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ThemesTableFilterComposer
    extends Composer<_$AppDatabase, $ThemesTable> {
  $$ThemesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accent => $composableBuilder(
    column: $table.accent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> themeMarksRefs(
    Expression<bool> Function($$ThemeMarksTableFilterComposer f) f,
  ) {
    final $$ThemeMarksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.themeMarks,
      getReferencedColumn: (t) => t.themeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThemeMarksTableFilterComposer(
            $db: $db,
            $table: $db.themeMarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ThemesTableOrderingComposer
    extends Composer<_$AppDatabase, $ThemesTable> {
  $$ThemesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accent => $composableBuilder(
    column: $table.accent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ThemesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ThemesTable> {
  $$ThemesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get accent =>
      $composableBuilder(column: $table.accent, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> themeMarksRefs<T extends Object>(
    Expression<T> Function($$ThemeMarksTableAnnotationComposer a) f,
  ) {
    final $$ThemeMarksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.themeMarks,
      getReferencedColumn: (t) => t.themeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThemeMarksTableAnnotationComposer(
            $db: $db,
            $table: $db.themeMarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ThemesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ThemesTable,
          LocalTheme,
          $$ThemesTableFilterComposer,
          $$ThemesTableOrderingComposer,
          $$ThemesTableAnnotationComposer,
          $$ThemesTableCreateCompanionBuilder,
          $$ThemesTableUpdateCompanionBuilder,
          (LocalTheme, $$ThemesTableReferences),
          LocalTheme,
          PrefetchHooks Function({bool themeMarksRefs})
        > {
  $$ThemesTableTableManager(_$AppDatabase db, $ThemesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ThemesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ThemesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThemesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> accent = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ThemesCompanion(
                id: id,
                name: name,
                accent: accent,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> accent = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ThemesCompanion.insert(
                id: id,
                name: name,
                accent: accent,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ThemesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({themeMarksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (themeMarksRefs) db.themeMarks],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (themeMarksRefs)
                    await $_getPrefetchedData<
                      LocalTheme,
                      $ThemesTable,
                      LocalThemeMark
                    >(
                      currentTable: table,
                      referencedTable: $$ThemesTableReferences
                          ._themeMarksRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ThemesTableReferences(db, table, p0).themeMarksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.themeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ThemesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ThemesTable,
      LocalTheme,
      $$ThemesTableFilterComposer,
      $$ThemesTableOrderingComposer,
      $$ThemesTableAnnotationComposer,
      $$ThemesTableCreateCompanionBuilder,
      $$ThemesTableUpdateCompanionBuilder,
      (LocalTheme, $$ThemesTableReferences),
      LocalTheme,
      PrefetchHooks Function({bool themeMarksRefs})
    >;
typedef $$ThemeMarksTableCreateCompanionBuilder = ThemeMarksCompanion Function({
  required String themeId,
  required String bookmarkId,
  Value<int> rowid,
});
typedef $$ThemeMarksTableUpdateCompanionBuilder = ThemeMarksCompanion Function({
  Value<String> themeId,
  Value<String> bookmarkId,
  Value<int> rowid,
});

final class $$ThemeMarksTableReferences
    extends BaseReferences<_$AppDatabase, $ThemeMarksTable, LocalThemeMark> {
  $$ThemeMarksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ThemesTable _themeIdTable(_$AppDatabase db) =>
      db.themes.createAlias('theme_marks__theme_id__themes__id');

  $$ThemesTableProcessedTableManager get themeId {
    final $_column = $_itemColumn<String>('theme_id')!;

    final manager = $$ThemesTableTableManager(
      $_db,
      $_db.themes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_themeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BookmarksTable _bookmarkIdTable(_$AppDatabase db) =>
      db.bookmarks.createAlias('theme_marks__bookmark_id__bookmarks__id');

  $$BookmarksTableProcessedTableManager get bookmarkId {
    final $_column = $_itemColumn<String>('bookmark_id')!;

    final manager = $$BookmarksTableTableManager(
      $_db,
      $_db.bookmarks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookmarkIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ThemeMarksTableFilterComposer
    extends Composer<_$AppDatabase, $ThemeMarksTable> {
  $$ThemeMarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ThemesTableFilterComposer get themeId {
    final $$ThemesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.themeId,
      referencedTable: $db.themes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThemesTableFilterComposer(
            $db: $db,
            $table: $db.themes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BookmarksTableFilterComposer get bookmarkId {
    final $$BookmarksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookmarkId,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableFilterComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ThemeMarksTableOrderingComposer
    extends Composer<_$AppDatabase, $ThemeMarksTable> {
  $$ThemeMarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ThemesTableOrderingComposer get themeId {
    final $$ThemesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.themeId,
      referencedTable: $db.themes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThemesTableOrderingComposer(
            $db: $db,
            $table: $db.themes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BookmarksTableOrderingComposer get bookmarkId {
    final $$BookmarksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookmarkId,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableOrderingComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ThemeMarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $ThemeMarksTable> {
  $$ThemeMarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ThemesTableAnnotationComposer get themeId {
    final $$ThemesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.themeId,
      referencedTable: $db.themes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThemesTableAnnotationComposer(
            $db: $db,
            $table: $db.themes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BookmarksTableAnnotationComposer get bookmarkId {
    final $$BookmarksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookmarkId,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableAnnotationComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ThemeMarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ThemeMarksTable,
          LocalThemeMark,
          $$ThemeMarksTableFilterComposer,
          $$ThemeMarksTableOrderingComposer,
          $$ThemeMarksTableAnnotationComposer,
          $$ThemeMarksTableCreateCompanionBuilder,
          $$ThemeMarksTableUpdateCompanionBuilder,
          (LocalThemeMark, $$ThemeMarksTableReferences),
          LocalThemeMark,
          PrefetchHooks Function({bool themeId, bool bookmarkId})
        > {
  $$ThemeMarksTableTableManager(_$AppDatabase db, $ThemeMarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ThemeMarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ThemeMarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThemeMarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> themeId = const Value.absent(),
                Value<String> bookmarkId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ThemeMarksCompanion(
                themeId: themeId,
                bookmarkId: bookmarkId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String themeId,
                required String bookmarkId,
                Value<int> rowid = const Value.absent(),
              }) => ThemeMarksCompanion.insert(
                themeId: themeId,
                bookmarkId: bookmarkId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ThemeMarksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({themeId = false, bookmarkId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (themeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.themeId,
                        referencedTable: $$ThemeMarksTableReferences
                            ._themeIdTable(db),
                        referencedColumn: $$ThemeMarksTableReferences
                            ._themeIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (bookmarkId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.bookmarkId,
                        referencedTable: $$ThemeMarksTableReferences
                            ._bookmarkIdTable(db),
                        referencedColumn: $$ThemeMarksTableReferences
                            ._bookmarkIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ThemeMarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ThemeMarksTable,
      LocalThemeMark,
      $$ThemeMarksTableFilterComposer,
      $$ThemeMarksTableOrderingComposer,
      $$ThemeMarksTableAnnotationComposer,
      $$ThemeMarksTableCreateCompanionBuilder,
      $$ThemeMarksTableUpdateCompanionBuilder,
      (LocalThemeMark, $$ThemeMarksTableReferences),
      LocalThemeMark,
      PrefetchHooks Function({bool themeId, bool bookmarkId})
    >;
typedef $$ShelvesTableCreateCompanionBuilder = ShelvesCompanion Function({
  required String id,
  required String name,
  Value<String?> accent,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$ShelvesTableUpdateCompanionBuilder = ShelvesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> accent,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$ShelvesTableReferences
    extends BaseReferences<_$AppDatabase, $ShelvesTable, LocalShelf> {
  $$ShelvesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ShelfBooksTable, List<LocalShelfBook>>
  _shelfBooksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.shelfBooks,
    aliasName: 'shelves__id__shelf_books__shelf_id',
  );

  $$ShelfBooksTableProcessedTableManager get shelfBooksRefs {
    final manager = $$ShelfBooksTableTableManager(
      $_db,
      $_db.shelfBooks,
    ).filter((f) => f.shelfId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_shelfBooksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ShelvesTableFilterComposer
    extends Composer<_$AppDatabase, $ShelvesTable> {
  $$ShelvesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accent => $composableBuilder(
    column: $table.accent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> shelfBooksRefs(
    Expression<bool> Function($$ShelfBooksTableFilterComposer f) f,
  ) {
    final $$ShelfBooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shelfBooks,
      getReferencedColumn: (t) => t.shelfId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShelfBooksTableFilterComposer(
            $db: $db,
            $table: $db.shelfBooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShelvesTableOrderingComposer
    extends Composer<_$AppDatabase, $ShelvesTable> {
  $$ShelvesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accent => $composableBuilder(
    column: $table.accent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShelvesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShelvesTable> {
  $$ShelvesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get accent =>
      $composableBuilder(column: $table.accent, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> shelfBooksRefs<T extends Object>(
    Expression<T> Function($$ShelfBooksTableAnnotationComposer a) f,
  ) {
    final $$ShelfBooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shelfBooks,
      getReferencedColumn: (t) => t.shelfId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShelfBooksTableAnnotationComposer(
            $db: $db,
            $table: $db.shelfBooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShelvesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShelvesTable,
          LocalShelf,
          $$ShelvesTableFilterComposer,
          $$ShelvesTableOrderingComposer,
          $$ShelvesTableAnnotationComposer,
          $$ShelvesTableCreateCompanionBuilder,
          $$ShelvesTableUpdateCompanionBuilder,
          (LocalShelf, $$ShelvesTableReferences),
          LocalShelf,
          PrefetchHooks Function({bool shelfBooksRefs})
        > {
  $$ShelvesTableTableManager(_$AppDatabase db, $ShelvesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShelvesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShelvesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShelvesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> accent = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShelvesCompanion(
                id: id,
                name: name,
                accent: accent,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> accent = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ShelvesCompanion.insert(
                id: id,
                name: name,
                accent: accent,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ShelvesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shelfBooksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (shelfBooksRefs) db.shelfBooks],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (shelfBooksRefs)
                    await $_getPrefetchedData<
                      LocalShelf,
                      $ShelvesTable,
                      LocalShelfBook
                    >(
                      currentTable: table,
                      referencedTable: $$ShelvesTableReferences
                          ._shelfBooksRefsTable(db),
                      managerFromTypedResult: (p0) => $$ShelvesTableReferences(
                        db,
                        table,
                        p0,
                      ).shelfBooksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.shelfId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ShelvesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShelvesTable,
      LocalShelf,
      $$ShelvesTableFilterComposer,
      $$ShelvesTableOrderingComposer,
      $$ShelvesTableAnnotationComposer,
      $$ShelvesTableCreateCompanionBuilder,
      $$ShelvesTableUpdateCompanionBuilder,
      (LocalShelf, $$ShelvesTableReferences),
      LocalShelf,
      PrefetchHooks Function({bool shelfBooksRefs})
    >;
typedef $$ShelfBooksTableCreateCompanionBuilder = ShelfBooksCompanion Function({
  required String shelfId,
  required String bookId,
  Value<int> rowid,
});
typedef $$ShelfBooksTableUpdateCompanionBuilder = ShelfBooksCompanion Function({
  Value<String> shelfId,
  Value<String> bookId,
  Value<int> rowid,
});

final class $$ShelfBooksTableReferences
    extends BaseReferences<_$AppDatabase, $ShelfBooksTable, LocalShelfBook> {
  $$ShelfBooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShelvesTable _shelfIdTable(_$AppDatabase db) =>
      db.shelves.createAlias('shelf_books__shelf_id__shelves__id');

  $$ShelvesTableProcessedTableManager get shelfId {
    final $_column = $_itemColumn<String>('shelf_id')!;

    final manager = $$ShelvesTableTableManager(
      $_db,
      $_db.shelves,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shelfIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BooksTable _bookIdTable(_$AppDatabase db) =>
      db.books.createAlias('shelf_books__book_id__books__id');

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ShelfBooksTableFilterComposer
    extends Composer<_$AppDatabase, $ShelfBooksTable> {
  $$ShelfBooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ShelvesTableFilterComposer get shelfId {
    final $$ShelvesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shelfId,
      referencedTable: $db.shelves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShelvesTableFilterComposer(
            $db: $db,
            $table: $db.shelves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShelfBooksTableOrderingComposer
    extends Composer<_$AppDatabase, $ShelfBooksTable> {
  $$ShelfBooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ShelvesTableOrderingComposer get shelfId {
    final $$ShelvesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shelfId,
      referencedTable: $db.shelves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShelvesTableOrderingComposer(
            $db: $db,
            $table: $db.shelves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShelfBooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShelfBooksTable> {
  $$ShelfBooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ShelvesTableAnnotationComposer get shelfId {
    final $$ShelvesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shelfId,
      referencedTable: $db.shelves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShelvesTableAnnotationComposer(
            $db: $db,
            $table: $db.shelves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShelfBooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShelfBooksTable,
          LocalShelfBook,
          $$ShelfBooksTableFilterComposer,
          $$ShelfBooksTableOrderingComposer,
          $$ShelfBooksTableAnnotationComposer,
          $$ShelfBooksTableCreateCompanionBuilder,
          $$ShelfBooksTableUpdateCompanionBuilder,
          (LocalShelfBook, $$ShelfBooksTableReferences),
          LocalShelfBook,
          PrefetchHooks Function({bool shelfId, bool bookId})
        > {
  $$ShelfBooksTableTableManager(_$AppDatabase db, $ShelfBooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShelfBooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShelfBooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShelfBooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> shelfId = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShelfBooksCompanion(
                shelfId: shelfId,
                bookId: bookId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shelfId,
                required String bookId,
                Value<int> rowid = const Value.absent(),
              }) => ShelfBooksCompanion.insert(
                shelfId: shelfId,
                bookId: bookId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ShelfBooksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shelfId = false, bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (shelfId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.shelfId,
                        referencedTable: $$ShelfBooksTableReferences
                            ._shelfIdTable(db),
                        referencedColumn: $$ShelfBooksTableReferences
                            ._shelfIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (bookId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.bookId,
                        referencedTable: $$ShelfBooksTableReferences
                            ._bookIdTable(db),
                        referencedColumn: $$ShelfBooksTableReferences
                            ._bookIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ShelfBooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShelfBooksTable,
      LocalShelfBook,
      $$ShelfBooksTableFilterComposer,
      $$ShelfBooksTableOrderingComposer,
      $$ShelfBooksTableAnnotationComposer,
      $$ShelfBooksTableCreateCompanionBuilder,
      $$ShelfBooksTableUpdateCompanionBuilder,
      (LocalShelfBook, $$ShelfBooksTableReferences),
      LocalShelfBook,
      PrefetchHooks Function({bool shelfId, bool bookId})
    >;
typedef $$SettingsTableTableCreateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<int> id,
      Value<String?> displayName,
      Value<String?> localePreference,
    });
typedef $$SettingsTableTableUpdateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<int> id,
      Value<String?> displayName,
      Value<String?> localePreference,
    });

class $$SettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localePreference => $composableBuilder(
    column: $table.localePreference,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localePreference => $composableBuilder(
    column: $table.localePreference,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localePreference => $composableBuilder(
    column: $table.localePreference,
    builder: (column) => column,
  );
}

class $$SettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTableTable,
          LocalSettings,
          $$SettingsTableTableFilterComposer,
          $$SettingsTableTableOrderingComposer,
          $$SettingsTableTableAnnotationComposer,
          $$SettingsTableTableCreateCompanionBuilder,
          $$SettingsTableTableUpdateCompanionBuilder,
          (
            LocalSettings,
            BaseReferences<_$AppDatabase, $SettingsTableTable, LocalSettings>,
          ),
          LocalSettings,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableTableManager(_$AppDatabase db, $SettingsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> localePreference = const Value.absent(),
              }) => SettingsTableCompanion(
                id: id,
                displayName: displayName,
                localePreference: localePreference,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> localePreference = const Value.absent(),
              }) => SettingsTableCompanion.insert(
                id: id,
                displayName: displayName,
                localePreference: localePreference,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTableTable,
      LocalSettings,
      $$SettingsTableTableFilterComposer,
      $$SettingsTableTableOrderingComposer,
      $$SettingsTableTableAnnotationComposer,
      $$SettingsTableTableCreateCompanionBuilder,
      $$SettingsTableTableUpdateCompanionBuilder,
      (
        LocalSettings,
        BaseReferences<_$AppDatabase, $SettingsTableTable, LocalSettings>,
      ),
      LocalSettings,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$ThemesTableTableManager get themes =>
      $$ThemesTableTableManager(_db, _db.themes);
  $$ThemeMarksTableTableManager get themeMarks =>
      $$ThemeMarksTableTableManager(_db, _db.themeMarks);
  $$ShelvesTableTableManager get shelves =>
      $$ShelvesTableTableManager(_db, _db.shelves);
  $$ShelfBooksTableTableManager get shelfBooks =>
      $$ShelfBooksTableTableManager(_db, _db.shelfBooks);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
}
