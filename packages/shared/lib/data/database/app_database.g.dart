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

class $QuotesTable extends Quotes with TableInfo<$QuotesTable, LocalQuote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuotesTable(this.attachedDatabase, [this._alias]);
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
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String> pageNumbers =
      GeneratedColumn<String>(
        'page_numbers',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<int>>($QuotesTable.$converterpageNumbers);
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
  static const VerificationMeta _voiceNotePathMeta = const VerificationMeta(
    'voiceNotePath',
  );
  @override
  late final GeneratedColumn<String> voiceNotePath = GeneratedColumn<String>(
    'voice_note_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voiceNoteDurationMsMeta =
      const VerificationMeta('voiceNoteDurationMs');
  @override
  late final GeneratedColumn<int> voiceNoteDurationMs = GeneratedColumn<int>(
    'voice_note_duration_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<QuotePage>, String> pages =
      GeneratedColumn<String>(
        'pages',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<QuotePage>>($QuotesTable.$converterpages);
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
    pageNumbers,
    quote,
    note,
    voiceNotePath,
    voiceNoteDurationMs,
    pages,
    isFavorite,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalQuote> instance, {
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
    if (data.containsKey('voice_note_path')) {
      context.handle(
        _voiceNotePathMeta,
        voiceNotePath.isAcceptableOrUnknown(
          data['voice_note_path']!,
          _voiceNotePathMeta,
        ),
      );
    }
    if (data.containsKey('voice_note_duration_ms')) {
      context.handle(
        _voiceNoteDurationMsMeta,
        voiceNoteDurationMs.isAcceptableOrUnknown(
          data['voice_note_duration_ms']!,
          _voiceNoteDurationMsMeta,
        ),
      );
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
  LocalQuote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalQuote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      pageNumbers: $QuotesTable.$converterpageNumbers.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}page_numbers'],
        )!,
      ),
      quote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      voiceNotePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}voice_note_path'],
      ),
      voiceNoteDurationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}voice_note_duration_ms'],
      ),
      pages: $QuotesTable.$converterpages.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}pages'],
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
  $QuotesTable createAlias(String alias) {
    return $QuotesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<int>, String> $converterpageNumbers =
      const IntListConverter();
  static TypeConverter<List<QuotePage>, String> $converterpages =
      const QuotePageListConverter();
}

class LocalQuote extends DataClass implements Insertable<LocalQuote> {
  final String id;
  final String bookId;
  final List<int> pageNumbers;
  final String quote;
  final String? note;
  final String? voiceNotePath;
  final int? voiceNoteDurationMs;
  final List<QuotePage> pages;
  final bool isFavorite;
  final DateTime createdAt;
  const LocalQuote({
    required this.id,
    required this.bookId,
    required this.pageNumbers,
    required this.quote,
    this.note,
    this.voiceNotePath,
    this.voiceNoteDurationMs,
    required this.pages,
    required this.isFavorite,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['book_id'] = Variable<String>(bookId);
    {
      map['page_numbers'] = Variable<String>(
        $QuotesTable.$converterpageNumbers.toSql(pageNumbers),
      );
    }
    map['quote'] = Variable<String>(quote);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || voiceNotePath != null) {
      map['voice_note_path'] = Variable<String>(voiceNotePath);
    }
    if (!nullToAbsent || voiceNoteDurationMs != null) {
      map['voice_note_duration_ms'] = Variable<int>(voiceNoteDurationMs);
    }
    {
      map['pages'] = Variable<String>(
        $QuotesTable.$converterpages.toSql(pages),
      );
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  QuotesCompanion toCompanion(bool nullToAbsent) {
    return QuotesCompanion(
      id: Value(id),
      bookId: Value(bookId),
      pageNumbers: Value(pageNumbers),
      quote: Value(quote),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      voiceNotePath: voiceNotePath == null && nullToAbsent
          ? const Value.absent()
          : Value(voiceNotePath),
      voiceNoteDurationMs: voiceNoteDurationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(voiceNoteDurationMs),
      pages: Value(pages),
      isFavorite: Value(isFavorite),
      createdAt: Value(createdAt),
    );
  }

  factory LocalQuote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalQuote(
      id: serializer.fromJson<String>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      pageNumbers: serializer.fromJson<List<int>>(json['pageNumbers']),
      quote: serializer.fromJson<String>(json['quote']),
      note: serializer.fromJson<String?>(json['note']),
      voiceNotePath: serializer.fromJson<String?>(json['voiceNotePath']),
      voiceNoteDurationMs: serializer.fromJson<int?>(
        json['voiceNoteDurationMs'],
      ),
      pages: serializer.fromJson<List<QuotePage>>(json['pages']),
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
      'pageNumbers': serializer.toJson<List<int>>(pageNumbers),
      'quote': serializer.toJson<String>(quote),
      'note': serializer.toJson<String?>(note),
      'voiceNotePath': serializer.toJson<String?>(voiceNotePath),
      'voiceNoteDurationMs': serializer.toJson<int?>(voiceNoteDurationMs),
      'pages': serializer.toJson<List<QuotePage>>(pages),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalQuote copyWith({
    String? id,
    String? bookId,
    List<int>? pageNumbers,
    String? quote,
    Value<String?> note = const Value.absent(),
    Value<String?> voiceNotePath = const Value.absent(),
    Value<int?> voiceNoteDurationMs = const Value.absent(),
    List<QuotePage>? pages,
    bool? isFavorite,
    DateTime? createdAt,
  }) => LocalQuote(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    pageNumbers: pageNumbers ?? this.pageNumbers,
    quote: quote ?? this.quote,
    note: note.present ? note.value : this.note,
    voiceNotePath: voiceNotePath.present
        ? voiceNotePath.value
        : this.voiceNotePath,
    voiceNoteDurationMs: voiceNoteDurationMs.present
        ? voiceNoteDurationMs.value
        : this.voiceNoteDurationMs,
    pages: pages ?? this.pages,
    isFavorite: isFavorite ?? this.isFavorite,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalQuote copyWithCompanion(QuotesCompanion data) {
    return LocalQuote(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      pageNumbers: data.pageNumbers.present
          ? data.pageNumbers.value
          : this.pageNumbers,
      quote: data.quote.present ? data.quote.value : this.quote,
      note: data.note.present ? data.note.value : this.note,
      voiceNotePath: data.voiceNotePath.present
          ? data.voiceNotePath.value
          : this.voiceNotePath,
      voiceNoteDurationMs: data.voiceNoteDurationMs.present
          ? data.voiceNoteDurationMs.value
          : this.voiceNoteDurationMs,
      pages: data.pages.present ? data.pages.value : this.pages,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalQuote(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('pageNumbers: $pageNumbers, ')
          ..write('quote: $quote, ')
          ..write('note: $note, ')
          ..write('voiceNotePath: $voiceNotePath, ')
          ..write('voiceNoteDurationMs: $voiceNoteDurationMs, ')
          ..write('pages: $pages, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    pageNumbers,
    quote,
    note,
    voiceNotePath,
    voiceNoteDurationMs,
    pages,
    isFavorite,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalQuote &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.pageNumbers == this.pageNumbers &&
          other.quote == this.quote &&
          other.note == this.note &&
          other.voiceNotePath == this.voiceNotePath &&
          other.voiceNoteDurationMs == this.voiceNoteDurationMs &&
          other.pages == this.pages &&
          other.isFavorite == this.isFavorite &&
          other.createdAt == this.createdAt);
}

class QuotesCompanion extends UpdateCompanion<LocalQuote> {
  final Value<String> id;
  final Value<String> bookId;
  final Value<List<int>> pageNumbers;
  final Value<String> quote;
  final Value<String?> note;
  final Value<String?> voiceNotePath;
  final Value<int?> voiceNoteDurationMs;
  final Value<List<QuotePage>> pages;
  final Value<bool> isFavorite;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const QuotesCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.pageNumbers = const Value.absent(),
    this.quote = const Value.absent(),
    this.note = const Value.absent(),
    this.voiceNotePath = const Value.absent(),
    this.voiceNoteDurationMs = const Value.absent(),
    this.pages = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuotesCompanion.insert({
    required String id,
    required String bookId,
    required List<int> pageNumbers,
    required String quote,
    this.note = const Value.absent(),
    this.voiceNotePath = const Value.absent(),
    this.voiceNoteDurationMs = const Value.absent(),
    required List<QuotePage> pages,
    this.isFavorite = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       bookId = Value(bookId),
       pageNumbers = Value(pageNumbers),
       quote = Value(quote),
       pages = Value(pages),
       createdAt = Value(createdAt);
  static Insertable<LocalQuote> custom({
    Expression<String>? id,
    Expression<String>? bookId,
    Expression<String>? pageNumbers,
    Expression<String>? quote,
    Expression<String>? note,
    Expression<String>? voiceNotePath,
    Expression<int>? voiceNoteDurationMs,
    Expression<String>? pages,
    Expression<bool>? isFavorite,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (pageNumbers != null) 'page_numbers': pageNumbers,
      if (quote != null) 'quote': quote,
      if (note != null) 'note': note,
      if (voiceNotePath != null) 'voice_note_path': voiceNotePath,
      if (voiceNoteDurationMs != null)
        'voice_note_duration_ms': voiceNoteDurationMs,
      if (pages != null) 'pages': pages,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuotesCompanion copyWith({
    Value<String>? id,
    Value<String>? bookId,
    Value<List<int>>? pageNumbers,
    Value<String>? quote,
    Value<String?>? note,
    Value<String?>? voiceNotePath,
    Value<int?>? voiceNoteDurationMs,
    Value<List<QuotePage>>? pages,
    Value<bool>? isFavorite,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return QuotesCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      pageNumbers: pageNumbers ?? this.pageNumbers,
      quote: quote ?? this.quote,
      note: note ?? this.note,
      voiceNotePath: voiceNotePath ?? this.voiceNotePath,
      voiceNoteDurationMs: voiceNoteDurationMs ?? this.voiceNoteDurationMs,
      pages: pages ?? this.pages,
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
    if (pageNumbers.present) {
      map['page_numbers'] = Variable<String>(
        $QuotesTable.$converterpageNumbers.toSql(pageNumbers.value),
      );
    }
    if (quote.present) {
      map['quote'] = Variable<String>(quote.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (voiceNotePath.present) {
      map['voice_note_path'] = Variable<String>(voiceNotePath.value);
    }
    if (voiceNoteDurationMs.present) {
      map['voice_note_duration_ms'] = Variable<int>(voiceNoteDurationMs.value);
    }
    if (pages.present) {
      map['pages'] = Variable<String>(
        $QuotesTable.$converterpages.toSql(pages.value),
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
    return (StringBuffer('QuotesCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('pageNumbers: $pageNumbers, ')
          ..write('quote: $quote, ')
          ..write('note: $note, ')
          ..write('voiceNotePath: $voiceNotePath, ')
          ..write('voiceNoteDurationMs: $voiceNoteDurationMs, ')
          ..write('pages: $pages, ')
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
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
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
  List<GeneratedColumn> get $columns => [id, name, accent, symbol, createdAt];
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
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
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
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
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
  final String? symbol;
  final DateTime createdAt;
  const LocalTheme({
    required this.id,
    required this.name,
    this.accent,
    this.symbol,
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
    if (!nullToAbsent || symbol != null) {
      map['symbol'] = Variable<String>(symbol);
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
      symbol: symbol == null && nullToAbsent
          ? const Value.absent()
          : Value(symbol),
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
      symbol: serializer.fromJson<String?>(json['symbol']),
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
      'symbol': serializer.toJson<String?>(symbol),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalTheme copyWith({
    String? id,
    String? name,
    Value<String?> accent = const Value.absent(),
    Value<String?> symbol = const Value.absent(),
    DateTime? createdAt,
  }) => LocalTheme(
    id: id ?? this.id,
    name: name ?? this.name,
    accent: accent.present ? accent.value : this.accent,
    symbol: symbol.present ? symbol.value : this.symbol,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalTheme copyWithCompanion(ThemesCompanion data) {
    return LocalTheme(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      accent: data.accent.present ? data.accent.value : this.accent,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalTheme(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('accent: $accent, ')
          ..write('symbol: $symbol, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, accent, symbol, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalTheme &&
          other.id == this.id &&
          other.name == this.name &&
          other.accent == this.accent &&
          other.symbol == this.symbol &&
          other.createdAt == this.createdAt);
}

class ThemesCompanion extends UpdateCompanion<LocalTheme> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> accent;
  final Value<String?> symbol;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ThemesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.accent = const Value.absent(),
    this.symbol = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ThemesCompanion.insert({
    required String id,
    required String name,
    this.accent = const Value.absent(),
    this.symbol = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<LocalTheme> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? accent,
    Expression<String>? symbol,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (accent != null) 'accent': accent,
      if (symbol != null) 'symbol': symbol,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ThemesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? accent,
    Value<String?>? symbol,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ThemesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      accent: accent ?? this.accent,
      symbol: symbol ?? this.symbol,
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
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
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
          ..write('symbol: $symbol, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ThemeQuotesTable extends ThemeQuotes
    with TableInfo<$ThemeQuotesTable, LocalThemeQuote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThemeQuotesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _quoteIdMeta = const VerificationMeta(
    'quoteId',
  );
  @override
  late final GeneratedColumn<String> quoteId = GeneratedColumn<String>(
    'quote_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES quotes (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [themeId, quoteId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'theme_quotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalThemeQuote> instance, {
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
    if (data.containsKey('quote_id')) {
      context.handle(
        _quoteIdMeta,
        quoteId.isAcceptableOrUnknown(data['quote_id']!, _quoteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {themeId, quoteId};
  @override
  LocalThemeQuote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalThemeQuote(
      themeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_id'],
      )!,
      quoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote_id'],
      )!,
    );
  }

  @override
  $ThemeQuotesTable createAlias(String alias) {
    return $ThemeQuotesTable(attachedDatabase, alias);
  }
}

class LocalThemeQuote extends DataClass implements Insertable<LocalThemeQuote> {
  final String themeId;
  final String quoteId;
  const LocalThemeQuote({required this.themeId, required this.quoteId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['theme_id'] = Variable<String>(themeId);
    map['quote_id'] = Variable<String>(quoteId);
    return map;
  }

  ThemeQuotesCompanion toCompanion(bool nullToAbsent) {
    return ThemeQuotesCompanion(
      themeId: Value(themeId),
      quoteId: Value(quoteId),
    );
  }

  factory LocalThemeQuote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalThemeQuote(
      themeId: serializer.fromJson<String>(json['themeId']),
      quoteId: serializer.fromJson<String>(json['quoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'themeId': serializer.toJson<String>(themeId),
      'quoteId': serializer.toJson<String>(quoteId),
    };
  }

  LocalThemeQuote copyWith({String? themeId, String? quoteId}) =>
      LocalThemeQuote(
        themeId: themeId ?? this.themeId,
        quoteId: quoteId ?? this.quoteId,
      );
  LocalThemeQuote copyWithCompanion(ThemeQuotesCompanion data) {
    return LocalThemeQuote(
      themeId: data.themeId.present ? data.themeId.value : this.themeId,
      quoteId: data.quoteId.present ? data.quoteId.value : this.quoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalThemeQuote(')
          ..write('themeId: $themeId, ')
          ..write('quoteId: $quoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(themeId, quoteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalThemeQuote &&
          other.themeId == this.themeId &&
          other.quoteId == this.quoteId);
}

class ThemeQuotesCompanion extends UpdateCompanion<LocalThemeQuote> {
  final Value<String> themeId;
  final Value<String> quoteId;
  final Value<int> rowid;
  const ThemeQuotesCompanion({
    this.themeId = const Value.absent(),
    this.quoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ThemeQuotesCompanion.insert({
    required String themeId,
    required String quoteId,
    this.rowid = const Value.absent(),
  }) : themeId = Value(themeId),
       quoteId = Value(quoteId);
  static Insertable<LocalThemeQuote> custom({
    Expression<String>? themeId,
    Expression<String>? quoteId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (themeId != null) 'theme_id': themeId,
      if (quoteId != null) 'quote_id': quoteId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ThemeQuotesCompanion copyWith({
    Value<String>? themeId,
    Value<String>? quoteId,
    Value<int>? rowid,
  }) {
    return ThemeQuotesCompanion(
      themeId: themeId ?? this.themeId,
      quoteId: quoteId ?? this.quoteId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (themeId.present) {
      map['theme_id'] = Variable<String>(themeId.value);
    }
    if (quoteId.present) {
      map['quote_id'] = Variable<String>(quoteId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThemeQuotesCompanion(')
          ..write('themeId: $themeId, ')
          ..write('quoteId: $quoteId, ')
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
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
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
  List<GeneratedColumn> get $columns => [id, name, accent, symbol, createdAt];
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
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
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
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
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
  final String? symbol;
  final DateTime createdAt;
  const LocalShelf({
    required this.id,
    required this.name,
    this.accent,
    this.symbol,
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
    if (!nullToAbsent || symbol != null) {
      map['symbol'] = Variable<String>(symbol);
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
      symbol: symbol == null && nullToAbsent
          ? const Value.absent()
          : Value(symbol),
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
      symbol: serializer.fromJson<String?>(json['symbol']),
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
      'symbol': serializer.toJson<String?>(symbol),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalShelf copyWith({
    String? id,
    String? name,
    Value<String?> accent = const Value.absent(),
    Value<String?> symbol = const Value.absent(),
    DateTime? createdAt,
  }) => LocalShelf(
    id: id ?? this.id,
    name: name ?? this.name,
    accent: accent.present ? accent.value : this.accent,
    symbol: symbol.present ? symbol.value : this.symbol,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalShelf copyWithCompanion(ShelvesCompanion data) {
    return LocalShelf(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      accent: data.accent.present ? data.accent.value : this.accent,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalShelf(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('accent: $accent, ')
          ..write('symbol: $symbol, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, accent, symbol, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalShelf &&
          other.id == this.id &&
          other.name == this.name &&
          other.accent == this.accent &&
          other.symbol == this.symbol &&
          other.createdAt == this.createdAt);
}

class ShelvesCompanion extends UpdateCompanion<LocalShelf> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> accent;
  final Value<String?> symbol;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ShelvesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.accent = const Value.absent(),
    this.symbol = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShelvesCompanion.insert({
    required String id,
    required String name,
    this.accent = const Value.absent(),
    this.symbol = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<LocalShelf> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? accent,
    Expression<String>? symbol,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (accent != null) 'accent': accent,
      if (symbol != null) 'symbol': symbol,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShelvesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? accent,
    Value<String?>? symbol,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ShelvesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      accent: accent ?? this.accent,
      symbol: symbol ?? this.symbol,
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
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
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
          ..write('symbol: $symbol, ')
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
  static const VerificationMeta _themePreferenceMeta = const VerificationMeta(
    'themePreference',
  );
  @override
  late final GeneratedColumn<String> themePreference = GeneratedColumn<String>(
    'theme_preference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contrastPreferenceMeta =
      const VerificationMeta('contrastPreference');
  @override
  late final GeneratedColumn<String> contrastPreference =
      GeneratedColumn<String>(
        'contrast_preference',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    localePreference,
    themePreference,
    contrastPreference,
  ];
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
    if (data.containsKey('theme_preference')) {
      context.handle(
        _themePreferenceMeta,
        themePreference.isAcceptableOrUnknown(
          data['theme_preference']!,
          _themePreferenceMeta,
        ),
      );
    }
    if (data.containsKey('contrast_preference')) {
      context.handle(
        _contrastPreferenceMeta,
        contrastPreference.isAcceptableOrUnknown(
          data['contrast_preference']!,
          _contrastPreferenceMeta,
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
      themePreference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_preference'],
      ),
      contrastPreference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contrast_preference'],
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
  final String? themePreference;
  final String? contrastPreference;
  const LocalSettings({
    required this.id,
    this.displayName,
    this.localePreference,
    this.themePreference,
    this.contrastPreference,
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
    if (!nullToAbsent || themePreference != null) {
      map['theme_preference'] = Variable<String>(themePreference);
    }
    if (!nullToAbsent || contrastPreference != null) {
      map['contrast_preference'] = Variable<String>(contrastPreference);
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
      themePreference: themePreference == null && nullToAbsent
          ? const Value.absent()
          : Value(themePreference),
      contrastPreference: contrastPreference == null && nullToAbsent
          ? const Value.absent()
          : Value(contrastPreference),
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
      themePreference: serializer.fromJson<String?>(json['themePreference']),
      contrastPreference: serializer.fromJson<String?>(
        json['contrastPreference'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'displayName': serializer.toJson<String?>(displayName),
      'localePreference': serializer.toJson<String?>(localePreference),
      'themePreference': serializer.toJson<String?>(themePreference),
      'contrastPreference': serializer.toJson<String?>(contrastPreference),
    };
  }

  LocalSettings copyWith({
    int? id,
    Value<String?> displayName = const Value.absent(),
    Value<String?> localePreference = const Value.absent(),
    Value<String?> themePreference = const Value.absent(),
    Value<String?> contrastPreference = const Value.absent(),
  }) => LocalSettings(
    id: id ?? this.id,
    displayName: displayName.present ? displayName.value : this.displayName,
    localePreference: localePreference.present
        ? localePreference.value
        : this.localePreference,
    themePreference: themePreference.present
        ? themePreference.value
        : this.themePreference,
    contrastPreference: contrastPreference.present
        ? contrastPreference.value
        : this.contrastPreference,
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
      themePreference: data.themePreference.present
          ? data.themePreference.value
          : this.themePreference,
      contrastPreference: data.contrastPreference.present
          ? data.contrastPreference.value
          : this.contrastPreference,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSettings(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('localePreference: $localePreference, ')
          ..write('themePreference: $themePreference, ')
          ..write('contrastPreference: $contrastPreference')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    localePreference,
    themePreference,
    contrastPreference,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSettings &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.localePreference == this.localePreference &&
          other.themePreference == this.themePreference &&
          other.contrastPreference == this.contrastPreference);
}

class SettingsTableCompanion extends UpdateCompanion<LocalSettings> {
  final Value<int> id;
  final Value<String?> displayName;
  final Value<String?> localePreference;
  final Value<String?> themePreference;
  final Value<String?> contrastPreference;
  const SettingsTableCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.localePreference = const Value.absent(),
    this.themePreference = const Value.absent(),
    this.contrastPreference = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.localePreference = const Value.absent(),
    this.themePreference = const Value.absent(),
    this.contrastPreference = const Value.absent(),
  });
  static Insertable<LocalSettings> custom({
    Expression<int>? id,
    Expression<String>? displayName,
    Expression<String>? localePreference,
    Expression<String>? themePreference,
    Expression<String>? contrastPreference,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (localePreference != null) 'locale_preference': localePreference,
      if (themePreference != null) 'theme_preference': themePreference,
      if (contrastPreference != null) 'contrast_preference': contrastPreference,
    });
  }

  SettingsTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? displayName,
    Value<String?>? localePreference,
    Value<String?>? themePreference,
    Value<String?>? contrastPreference,
  }) {
    return SettingsTableCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      localePreference: localePreference ?? this.localePreference,
      themePreference: themePreference ?? this.themePreference,
      contrastPreference: contrastPreference ?? this.contrastPreference,
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
    if (themePreference.present) {
      map['theme_preference'] = Variable<String>(themePreference.value);
    }
    if (contrastPreference.present) {
      map['contrast_preference'] = Variable<String>(contrastPreference.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('localePreference: $localePreference, ')
          ..write('themePreference: $themePreference, ')
          ..write('contrastPreference: $contrastPreference')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BooksTable books = $BooksTable(this);
  late final $QuotesTable quotes = $QuotesTable(this);
  late final $ThemesTable themes = $ThemesTable(this);
  late final $ThemeQuotesTable themeQuotes = $ThemeQuotesTable(this);
  late final $ShelvesTable shelves = $ShelvesTable(this);
  late final $ShelfBooksTable shelfBooks = $ShelfBooksTable(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    books,
    quotes,
    themes,
    themeQuotes,
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
      result: [TableUpdate('quotes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'themes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('theme_quotes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'quotes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('theme_quotes', kind: UpdateKind.delete)],
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

  static MultiTypedResultKey<$QuotesTable, List<LocalQuote>> _quotesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.quotes,
    aliasName: 'books__id__quotes__book_id',
  );

  $$QuotesTableProcessedTableManager get quotesRefs {
    final manager = $$QuotesTableTableManager(
      $_db,
      $_db.quotes,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_quotesRefsTable($_db));
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

  Expression<bool> quotesRefs(
    Expression<bool> Function($$QuotesTableFilterComposer f) f,
  ) {
    final $$QuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableFilterComposer(
            $db: $db,
            $table: $db.quotes,
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

  Expression<T> quotesRefs<T extends Object>(
    Expression<T> Function($$QuotesTableAnnotationComposer a) f,
  ) {
    final $$QuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.quotes,
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
          PrefetchHooks Function({bool quotesRefs, bool shelfBooksRefs})
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
              ({quotesRefs = false, shelfBooksRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (quotesRefs) db.quotes,
                    if (shelfBooksRefs) db.shelfBooks,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (quotesRefs)
                        await $_getPrefetchedData<
                          LocalBook,
                          $BooksTable,
                          LocalQuote
                        >(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._quotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(db, table, p0).quotesRefs,
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
      PrefetchHooks Function({bool quotesRefs, bool shelfBooksRefs})
    >;
typedef $$QuotesTableCreateCompanionBuilder = QuotesCompanion Function({
  required String id,
  required String bookId,
  required List<int> pageNumbers,
  required String quote,
  Value<String?> note,
  Value<String?> voiceNotePath,
  Value<int?> voiceNoteDurationMs,
  required List<QuotePage> pages,
  Value<bool> isFavorite,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$QuotesTableUpdateCompanionBuilder = QuotesCompanion Function({
  Value<String> id,
  Value<String> bookId,
  Value<List<int>> pageNumbers,
  Value<String> quote,
  Value<String?> note,
  Value<String?> voiceNotePath,
  Value<int?> voiceNoteDurationMs,
  Value<List<QuotePage>> pages,
  Value<bool> isFavorite,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$QuotesTableReferences
    extends BaseReferences<_$AppDatabase, $QuotesTable, LocalQuote> {
  $$QuotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) =>
      db.books.createAlias('quotes__book_id__books__id');

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

  static MultiTypedResultKey<$ThemeQuotesTable, List<LocalThemeQuote>>
  _themeQuotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.themeQuotes,
    aliasName: 'quotes__id__theme_quotes__quote_id',
  );

  $$ThemeQuotesTableProcessedTableManager get themeQuotesRefs {
    final manager = $$ThemeQuotesTableTableManager(
      $_db,
      $_db.themeQuotes,
    ).filter((f) => f.quoteId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_themeQuotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuotesTableFilterComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableFilterComposer({
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

  ColumnWithTypeConverterFilters<List<int>, List<int>, String>
  get pageNumbers => $composableBuilder(
    column: $table.pageNumbers,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get quote => $composableBuilder(
    column: $table.quote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get voiceNotePath => $composableBuilder(
    column: $table.voiceNotePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get voiceNoteDurationMs => $composableBuilder(
    column: $table.voiceNoteDurationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<QuotePage>, List<QuotePage>, String>
  get pages => $composableBuilder(
    column: $table.pages,
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

  Expression<bool> themeQuotesRefs(
    Expression<bool> Function($$ThemeQuotesTableFilterComposer f) f,
  ) {
    final $$ThemeQuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.themeQuotes,
      getReferencedColumn: (t) => t.quoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThemeQuotesTableFilterComposer(
            $db: $db,
            $table: $db.themeQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuotesTableOrderingComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableOrderingComposer({
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

  ColumnOrderings<String> get pageNumbers => $composableBuilder(
    column: $table.pageNumbers,
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

  ColumnOrderings<String> get voiceNotePath => $composableBuilder(
    column: $table.voiceNotePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get voiceNoteDurationMs => $composableBuilder(
    column: $table.voiceNoteDurationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pages => $composableBuilder(
    column: $table.pages,
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

class $$QuotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<int>, String> get pageNumbers =>
      $composableBuilder(
        column: $table.pageNumbers,
        builder: (column) => column,
      );

  GeneratedColumn<String> get quote =>
      $composableBuilder(column: $table.quote, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get voiceNotePath => $composableBuilder(
    column: $table.voiceNotePath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get voiceNoteDurationMs => $composableBuilder(
    column: $table.voiceNoteDurationMs,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<QuotePage>, String> get pages =>
      $composableBuilder(column: $table.pages, builder: (column) => column);

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

  Expression<T> themeQuotesRefs<T extends Object>(
    Expression<T> Function($$ThemeQuotesTableAnnotationComposer a) f,
  ) {
    final $$ThemeQuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.themeQuotes,
      getReferencedColumn: (t) => t.quoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThemeQuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.themeQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuotesTable,
          LocalQuote,
          $$QuotesTableFilterComposer,
          $$QuotesTableOrderingComposer,
          $$QuotesTableAnnotationComposer,
          $$QuotesTableCreateCompanionBuilder,
          $$QuotesTableUpdateCompanionBuilder,
          (LocalQuote, $$QuotesTableReferences),
          LocalQuote,
          PrefetchHooks Function({bool bookId, bool themeQuotesRefs})
        > {
  $$QuotesTableTableManager(_$AppDatabase db, $QuotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<List<int>> pageNumbers = const Value.absent(),
                Value<String> quote = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> voiceNotePath = const Value.absent(),
                Value<int?> voiceNoteDurationMs = const Value.absent(),
                Value<List<QuotePage>> pages = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuotesCompanion(
                id: id,
                bookId: bookId,
                pageNumbers: pageNumbers,
                quote: quote,
                note: note,
                voiceNotePath: voiceNotePath,
                voiceNoteDurationMs: voiceNoteDurationMs,
                pages: pages,
                isFavorite: isFavorite,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String bookId,
                required List<int> pageNumbers,
                required String quote,
                Value<String?> note = const Value.absent(),
                Value<String?> voiceNotePath = const Value.absent(),
                Value<int?> voiceNoteDurationMs = const Value.absent(),
                required List<QuotePage> pages,
                Value<bool> isFavorite = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => QuotesCompanion.insert(
                id: id,
                bookId: bookId,
                pageNumbers: pageNumbers,
                quote: quote,
                note: note,
                voiceNotePath: voiceNotePath,
                voiceNoteDurationMs: voiceNoteDurationMs,
                pages: pages,
                isFavorite: isFavorite,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$QuotesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false, themeQuotesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (themeQuotesRefs) db.themeQuotes],
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
                        referencedTable: $$QuotesTableReferences._bookIdTable(
                          db,
                        ),
                        referencedColumn: $$QuotesTableReferences
                            ._bookIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (themeQuotesRefs)
                    await $_getPrefetchedData<
                      LocalQuote,
                      $QuotesTable,
                      LocalThemeQuote
                    >(
                      currentTable: table,
                      referencedTable: $$QuotesTableReferences
                          ._themeQuotesRefsTable(db),
                      managerFromTypedResult: (p0) => $$QuotesTableReferences(
                        db,
                        table,
                        p0,
                      ).themeQuotesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.quoteId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$QuotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuotesTable,
      LocalQuote,
      $$QuotesTableFilterComposer,
      $$QuotesTableOrderingComposer,
      $$QuotesTableAnnotationComposer,
      $$QuotesTableCreateCompanionBuilder,
      $$QuotesTableUpdateCompanionBuilder,
      (LocalQuote, $$QuotesTableReferences),
      LocalQuote,
      PrefetchHooks Function({bool bookId, bool themeQuotesRefs})
    >;
typedef $$ThemesTableCreateCompanionBuilder = ThemesCompanion Function({
  required String id,
  required String name,
  Value<String?> accent,
  Value<String?> symbol,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$ThemesTableUpdateCompanionBuilder = ThemesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> accent,
  Value<String?> symbol,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$ThemesTableReferences
    extends BaseReferences<_$AppDatabase, $ThemesTable, LocalTheme> {
  $$ThemesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ThemeQuotesTable, List<LocalThemeQuote>>
  _themeQuotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.themeQuotes,
    aliasName: 'themes__id__theme_quotes__theme_id',
  );

  $$ThemeQuotesTableProcessedTableManager get themeQuotesRefs {
    final manager = $$ThemeQuotesTableTableManager(
      $_db,
      $_db.themeQuotes,
    ).filter((f) => f.themeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_themeQuotesRefsTable($_db));
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

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> themeQuotesRefs(
    Expression<bool> Function($$ThemeQuotesTableFilterComposer f) f,
  ) {
    final $$ThemeQuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.themeQuotes,
      getReferencedColumn: (t) => t.themeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThemeQuotesTableFilterComposer(
            $db: $db,
            $table: $db.themeQuotes,
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

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
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

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> themeQuotesRefs<T extends Object>(
    Expression<T> Function($$ThemeQuotesTableAnnotationComposer a) f,
  ) {
    final $$ThemeQuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.themeQuotes,
      getReferencedColumn: (t) => t.themeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThemeQuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.themeQuotes,
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
          PrefetchHooks Function({bool themeQuotesRefs})
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
                Value<String?> symbol = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ThemesCompanion(
                id: id,
                name: name,
                accent: accent,
                symbol: symbol,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> accent = const Value.absent(),
                Value<String?> symbol = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ThemesCompanion.insert(
                id: id,
                name: name,
                accent: accent,
                symbol: symbol,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ThemesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({themeQuotesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (themeQuotesRefs) db.themeQuotes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (themeQuotesRefs)
                    await $_getPrefetchedData<
                      LocalTheme,
                      $ThemesTable,
                      LocalThemeQuote
                    >(
                      currentTable: table,
                      referencedTable: $$ThemesTableReferences
                          ._themeQuotesRefsTable(db),
                      managerFromTypedResult: (p0) => $$ThemesTableReferences(
                        db,
                        table,
                        p0,
                      ).themeQuotesRefs,
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
      PrefetchHooks Function({bool themeQuotesRefs})
    >;
typedef $$ThemeQuotesTableCreateCompanionBuilder =
    ThemeQuotesCompanion Function({
      required String themeId,
      required String quoteId,
      Value<int> rowid,
    });
typedef $$ThemeQuotesTableUpdateCompanionBuilder =
    ThemeQuotesCompanion Function({
      Value<String> themeId,
      Value<String> quoteId,
      Value<int> rowid,
    });

final class $$ThemeQuotesTableReferences
    extends BaseReferences<_$AppDatabase, $ThemeQuotesTable, LocalThemeQuote> {
  $$ThemeQuotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ThemesTable _themeIdTable(_$AppDatabase db) =>
      db.themes.createAlias('theme_quotes__theme_id__themes__id');

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

  static $QuotesTable _quoteIdTable(_$AppDatabase db) =>
      db.quotes.createAlias('theme_quotes__quote_id__quotes__id');

  $$QuotesTableProcessedTableManager get quoteId {
    final $_column = $_itemColumn<String>('quote_id')!;

    final manager = $$QuotesTableTableManager(
      $_db,
      $_db.quotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_quoteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ThemeQuotesTableFilterComposer
    extends Composer<_$AppDatabase, $ThemeQuotesTable> {
  $$ThemeQuotesTableFilterComposer({
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

  $$QuotesTableFilterComposer get quoteId {
    final $$QuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableFilterComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ThemeQuotesTableOrderingComposer
    extends Composer<_$AppDatabase, $ThemeQuotesTable> {
  $$ThemeQuotesTableOrderingComposer({
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

  $$QuotesTableOrderingComposer get quoteId {
    final $$QuotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableOrderingComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ThemeQuotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ThemeQuotesTable> {
  $$ThemeQuotesTableAnnotationComposer({
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

  $$QuotesTableAnnotationComposer get quoteId {
    final $$QuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ThemeQuotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ThemeQuotesTable,
          LocalThemeQuote,
          $$ThemeQuotesTableFilterComposer,
          $$ThemeQuotesTableOrderingComposer,
          $$ThemeQuotesTableAnnotationComposer,
          $$ThemeQuotesTableCreateCompanionBuilder,
          $$ThemeQuotesTableUpdateCompanionBuilder,
          (LocalThemeQuote, $$ThemeQuotesTableReferences),
          LocalThemeQuote,
          PrefetchHooks Function({bool themeId, bool quoteId})
        > {
  $$ThemeQuotesTableTableManager(_$AppDatabase db, $ThemeQuotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ThemeQuotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ThemeQuotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThemeQuotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> themeId = const Value.absent(),
                Value<String> quoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ThemeQuotesCompanion(
                themeId: themeId,
                quoteId: quoteId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String themeId,
                required String quoteId,
                Value<int> rowid = const Value.absent(),
              }) => ThemeQuotesCompanion.insert(
                themeId: themeId,
                quoteId: quoteId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ThemeQuotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({themeId = false, quoteId = false}) {
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
                        referencedTable: $$ThemeQuotesTableReferences
                            ._themeIdTable(db),
                        referencedColumn: $$ThemeQuotesTableReferences
                            ._themeIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (quoteId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.quoteId,
                        referencedTable: $$ThemeQuotesTableReferences
                            ._quoteIdTable(db),
                        referencedColumn: $$ThemeQuotesTableReferences
                            ._quoteIdTable(db)
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

typedef $$ThemeQuotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ThemeQuotesTable,
      LocalThemeQuote,
      $$ThemeQuotesTableFilterComposer,
      $$ThemeQuotesTableOrderingComposer,
      $$ThemeQuotesTableAnnotationComposer,
      $$ThemeQuotesTableCreateCompanionBuilder,
      $$ThemeQuotesTableUpdateCompanionBuilder,
      (LocalThemeQuote, $$ThemeQuotesTableReferences),
      LocalThemeQuote,
      PrefetchHooks Function({bool themeId, bool quoteId})
    >;
typedef $$ShelvesTableCreateCompanionBuilder = ShelvesCompanion Function({
  required String id,
  required String name,
  Value<String?> accent,
  Value<String?> symbol,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$ShelvesTableUpdateCompanionBuilder = ShelvesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> accent,
  Value<String?> symbol,
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

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
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

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
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

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

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
                Value<String?> symbol = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShelvesCompanion(
                id: id,
                name: name,
                accent: accent,
                symbol: symbol,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> accent = const Value.absent(),
                Value<String?> symbol = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ShelvesCompanion.insert(
                id: id,
                name: name,
                accent: accent,
                symbol: symbol,
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
      Value<String?> themePreference,
      Value<String?> contrastPreference,
    });
typedef $$SettingsTableTableUpdateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<int> id,
      Value<String?> displayName,
      Value<String?> localePreference,
      Value<String?> themePreference,
      Value<String?> contrastPreference,
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

  ColumnFilters<String> get themePreference => $composableBuilder(
    column: $table.themePreference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contrastPreference => $composableBuilder(
    column: $table.contrastPreference,
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

  ColumnOrderings<String> get themePreference => $composableBuilder(
    column: $table.themePreference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contrastPreference => $composableBuilder(
    column: $table.contrastPreference,
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

  GeneratedColumn<String> get themePreference => $composableBuilder(
    column: $table.themePreference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contrastPreference => $composableBuilder(
    column: $table.contrastPreference,
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
                Value<String?> themePreference = const Value.absent(),
                Value<String?> contrastPreference = const Value.absent(),
              }) => SettingsTableCompanion(
                id: id,
                displayName: displayName,
                localePreference: localePreference,
                themePreference: themePreference,
                contrastPreference: contrastPreference,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> localePreference = const Value.absent(),
                Value<String?> themePreference = const Value.absent(),
                Value<String?> contrastPreference = const Value.absent(),
              }) => SettingsTableCompanion.insert(
                id: id,
                displayName: displayName,
                localePreference: localePreference,
                themePreference: themePreference,
                contrastPreference: contrastPreference,
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
  $$QuotesTableTableManager get quotes =>
      $$QuotesTableTableManager(_db, _db.quotes);
  $$ThemesTableTableManager get themes =>
      $$ThemesTableTableManager(_db, _db.themes);
  $$ThemeQuotesTableTableManager get themeQuotes =>
      $$ThemeQuotesTableTableManager(_db, _db.themeQuotes);
  $$ShelvesTableTableManager get shelves =>
      $$ShelvesTableTableManager(_db, _db.shelves);
  $$ShelfBooksTableTableManager get shelfBooks =>
      $$ShelfBooksTableTableManager(_db, _db.shelfBooks);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
}
