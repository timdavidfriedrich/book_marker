// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BooksTable extends Books with TableInfo<$BooksTable, BookRow> {
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
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUsedAtMeta = const VerificationMeta(
    'lastUsedAt',
  );
  @override
  late final GeneratedColumn<String> lastUsedAt = GeneratedColumn<String>(
    'last_used_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyVersionMeta = const VerificationMeta(
    'keyVersion',
  );
  @override
  late final GeneratedColumn<int> keyVersion = GeneratedColumn<int>(
    'key_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleCipherMeta = const VerificationMeta(
    'titleCipher',
  );
  @override
  late final GeneratedColumn<String> titleCipher = GeneratedColumn<String>(
    'title_cipher',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorsCipherMeta = const VerificationMeta(
    'authorsCipher',
  );
  @override
  late final GeneratedColumn<String> authorsCipher = GeneratedColumn<String>(
    'authors_cipher',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isbnCipherMeta = const VerificationMeta(
    'isbnCipher',
  );
  @override
  late final GeneratedColumn<String> isbnCipher = GeneratedColumn<String>(
    'isbn_cipher',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverCipherMeta = const VerificationMeta(
    'coverCipher',
  );
  @override
  late final GeneratedColumn<String> coverCipher = GeneratedColumn<String>(
    'cover_cipher',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    status,
    createdAt,
    lastUsedAt,
    updatedAt,
    keyVersion,
    titleCipher,
    authorsCipher,
    isbnCipher,
    coverCipher,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('key_version')) {
      context.handle(
        _keyVersionMeta,
        keyVersion.isAcceptableOrUnknown(data['key_version']!, _keyVersionMeta),
      );
    } else if (isInserting) {
      context.missing(_keyVersionMeta);
    }
    if (data.containsKey('title_cipher')) {
      context.handle(
        _titleCipherMeta,
        titleCipher.isAcceptableOrUnknown(
          data['title_cipher']!,
          _titleCipherMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_titleCipherMeta);
    }
    if (data.containsKey('authors_cipher')) {
      context.handle(
        _authorsCipherMeta,
        authorsCipher.isAcceptableOrUnknown(
          data['authors_cipher']!,
          _authorsCipherMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_authorsCipherMeta);
    }
    if (data.containsKey('isbn_cipher')) {
      context.handle(
        _isbnCipherMeta,
        isbnCipher.isAcceptableOrUnknown(data['isbn_cipher']!, _isbnCipherMeta),
      );
    }
    if (data.containsKey('cover_cipher')) {
      context.handle(
        _coverCipherMeta,
        coverCipher.isAcceptableOrUnknown(
          data['cover_cipher']!,
          _coverCipherMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BookRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      lastUsedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_used_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      keyVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}key_version'],
      )!,
      titleCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_cipher'],
      )!,
      authorsCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}authors_cipher'],
      )!,
      isbnCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isbn_cipher'],
      ),
      coverCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_cipher'],
      ),
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class BookRow extends DataClass implements Insertable<BookRow> {
  final String id;
  final String ownerId;
  final String status;
  final String createdAt;
  final String lastUsedAt;
  final String updatedAt;
  final int keyVersion;
  final String titleCipher;
  final String authorsCipher;
  final String? isbnCipher;
  final String? coverCipher;
  const BookRow({
    required this.id,
    required this.ownerId,
    required this.status,
    required this.createdAt,
    required this.lastUsedAt,
    required this.updatedAt,
    required this.keyVersion,
    required this.titleCipher,
    required this.authorsCipher,
    this.isbnCipher,
    this.coverCipher,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<String>(createdAt);
    map['last_used_at'] = Variable<String>(lastUsedAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['key_version'] = Variable<int>(keyVersion);
    map['title_cipher'] = Variable<String>(titleCipher);
    map['authors_cipher'] = Variable<String>(authorsCipher);
    if (!nullToAbsent || isbnCipher != null) {
      map['isbn_cipher'] = Variable<String>(isbnCipher);
    }
    if (!nullToAbsent || coverCipher != null) {
      map['cover_cipher'] = Variable<String>(coverCipher);
    }
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      status: Value(status),
      createdAt: Value(createdAt),
      lastUsedAt: Value(lastUsedAt),
      updatedAt: Value(updatedAt),
      keyVersion: Value(keyVersion),
      titleCipher: Value(titleCipher),
      authorsCipher: Value(authorsCipher),
      isbnCipher: isbnCipher == null && nullToAbsent ? const Value.absent() : Value(isbnCipher),
      coverCipher: coverCipher == null && nullToAbsent ? const Value.absent() : Value(coverCipher),
    );
  }

  factory BookRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookRow(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      lastUsedAt: serializer.fromJson<String>(json['lastUsedAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      keyVersion: serializer.fromJson<int>(json['keyVersion']),
      titleCipher: serializer.fromJson<String>(json['titleCipher']),
      authorsCipher: serializer.fromJson<String>(json['authorsCipher']),
      isbnCipher: serializer.fromJson<String?>(json['isbnCipher']),
      coverCipher: serializer.fromJson<String?>(json['coverCipher']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<String>(createdAt),
      'lastUsedAt': serializer.toJson<String>(lastUsedAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'keyVersion': serializer.toJson<int>(keyVersion),
      'titleCipher': serializer.toJson<String>(titleCipher),
      'authorsCipher': serializer.toJson<String>(authorsCipher),
      'isbnCipher': serializer.toJson<String?>(isbnCipher),
      'coverCipher': serializer.toJson<String?>(coverCipher),
    };
  }

  BookRow copyWith({
    String? id,
    String? ownerId,
    String? status,
    String? createdAt,
    String? lastUsedAt,
    String? updatedAt,
    int? keyVersion,
    String? titleCipher,
    String? authorsCipher,
    Value<String?> isbnCipher = const Value.absent(),
    Value<String?> coverCipher = const Value.absent(),
  }) => BookRow(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    lastUsedAt: lastUsedAt ?? this.lastUsedAt,
    updatedAt: updatedAt ?? this.updatedAt,
    keyVersion: keyVersion ?? this.keyVersion,
    titleCipher: titleCipher ?? this.titleCipher,
    authorsCipher: authorsCipher ?? this.authorsCipher,
    isbnCipher: isbnCipher.present ? isbnCipher.value : this.isbnCipher,
    coverCipher: coverCipher.present ? coverCipher.value : this.coverCipher,
  );
  BookRow copyWithCompanion(BooksCompanion data) {
    return BookRow(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUsedAt: data.lastUsedAt.present ? data.lastUsedAt.value : this.lastUsedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      keyVersion: data.keyVersion.present ? data.keyVersion.value : this.keyVersion,
      titleCipher: data.titleCipher.present ? data.titleCipher.value : this.titleCipher,
      authorsCipher: data.authorsCipher.present ? data.authorsCipher.value : this.authorsCipher,
      isbnCipher: data.isbnCipher.present ? data.isbnCipher.value : this.isbnCipher,
      coverCipher: data.coverCipher.present ? data.coverCipher.value : this.coverCipher,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookRow(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('keyVersion: $keyVersion, ')
          ..write('titleCipher: $titleCipher, ')
          ..write('authorsCipher: $authorsCipher, ')
          ..write('isbnCipher: $isbnCipher, ')
          ..write('coverCipher: $coverCipher')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerId,
    status,
    createdAt,
    lastUsedAt,
    updatedAt,
    keyVersion,
    titleCipher,
    authorsCipher,
    isbnCipher,
    coverCipher,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookRow &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.lastUsedAt == this.lastUsedAt &&
          other.updatedAt == this.updatedAt &&
          other.keyVersion == this.keyVersion &&
          other.titleCipher == this.titleCipher &&
          other.authorsCipher == this.authorsCipher &&
          other.isbnCipher == this.isbnCipher &&
          other.coverCipher == this.coverCipher);
}

class BooksCompanion extends UpdateCompanion<BookRow> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> status;
  final Value<String> createdAt;
  final Value<String> lastUsedAt;
  final Value<String> updatedAt;
  final Value<int> keyVersion;
  final Value<String> titleCipher;
  final Value<String> authorsCipher;
  final Value<String?> isbnCipher;
  final Value<String?> coverCipher;
  final Value<int> rowid;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.keyVersion = const Value.absent(),
    this.titleCipher = const Value.absent(),
    this.authorsCipher = const Value.absent(),
    this.isbnCipher = const Value.absent(),
    this.coverCipher = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BooksCompanion.insert({
    required String id,
    required String ownerId,
    required String status,
    required String createdAt,
    required String lastUsedAt,
    required String updatedAt,
    required int keyVersion,
    required String titleCipher,
    required String authorsCipher,
    this.isbnCipher = const Value.absent(),
    this.coverCipher = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       status = Value(status),
       createdAt = Value(createdAt),
       lastUsedAt = Value(lastUsedAt),
       updatedAt = Value(updatedAt),
       keyVersion = Value(keyVersion),
       titleCipher = Value(titleCipher),
       authorsCipher = Value(authorsCipher);
  static Insertable<BookRow> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? status,
    Expression<String>? createdAt,
    Expression<String>? lastUsedAt,
    Expression<String>? updatedAt,
    Expression<int>? keyVersion,
    Expression<String>? titleCipher,
    Expression<String>? authorsCipher,
    Expression<String>? isbnCipher,
    Expression<String>? coverCipher,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (keyVersion != null) 'key_version': keyVersion,
      if (titleCipher != null) 'title_cipher': titleCipher,
      if (authorsCipher != null) 'authors_cipher': authorsCipher,
      if (isbnCipher != null) 'isbn_cipher': isbnCipher,
      if (coverCipher != null) 'cover_cipher': coverCipher,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BooksCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? status,
    Value<String>? createdAt,
    Value<String>? lastUsedAt,
    Value<String>? updatedAt,
    Value<int>? keyVersion,
    Value<String>? titleCipher,
    Value<String>? authorsCipher,
    Value<String?>? isbnCipher,
    Value<String?>? coverCipher,
    Value<int>? rowid,
  }) {
    return BooksCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      keyVersion: keyVersion ?? this.keyVersion,
      titleCipher: titleCipher ?? this.titleCipher,
      authorsCipher: authorsCipher ?? this.authorsCipher,
      isbnCipher: isbnCipher ?? this.isbnCipher,
      coverCipher: coverCipher ?? this.coverCipher,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<String>(lastUsedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (keyVersion.present) {
      map['key_version'] = Variable<int>(keyVersion.value);
    }
    if (titleCipher.present) {
      map['title_cipher'] = Variable<String>(titleCipher.value);
    }
    if (authorsCipher.present) {
      map['authors_cipher'] = Variable<String>(authorsCipher.value);
    }
    if (isbnCipher.present) {
      map['isbn_cipher'] = Variable<String>(isbnCipher.value);
    }
    if (coverCipher.present) {
      map['cover_cipher'] = Variable<String>(coverCipher.value);
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
          ..write('ownerId: $ownerId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('keyVersion: $keyVersion, ')
          ..write('titleCipher: $titleCipher, ')
          ..write('authorsCipher: $authorsCipher, ')
          ..write('isbnCipher: $isbnCipher, ')
          ..write('coverCipher: $coverCipher, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuotesTable extends Quotes with TableInfo<$QuotesTable, QuoteRow> {
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
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
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
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<int> isFavorite = GeneratedColumn<int>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyVersionMeta = const VerificationMeta(
    'keyVersion',
  );
  @override
  late final GeneratedColumn<int> keyVersion = GeneratedColumn<int>(
    'key_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quoteCipherMeta = const VerificationMeta(
    'quoteCipher',
  );
  @override
  late final GeneratedColumn<String> quoteCipher = GeneratedColumn<String>(
    'quote_cipher',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteCipherMeta = const VerificationMeta(
    'noteCipher',
  );
  @override
  late final GeneratedColumn<String> noteCipher = GeneratedColumn<String>(
    'note_cipher',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pageNumbersCipherMeta = const VerificationMeta(
    'pageNumbersCipher',
  );
  @override
  late final GeneratedColumn<String> pageNumbersCipher = GeneratedColumn<String>(
    'page_numbers_cipher',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pagesCipherMeta = const VerificationMeta(
    'pagesCipher',
  );
  @override
  late final GeneratedColumn<String> pagesCipher = GeneratedColumn<String>(
    'pages_cipher',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordsCipherMeta = const VerificationMeta(
    'wordsCipher',
  );
  @override
  late final GeneratedColumn<String> wordsCipher = GeneratedColumn<String>(
    'words_cipher',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _markedWordIndexesCipherMeta = const VerificationMeta(
    'markedWordIndexesCipher',
  );
  @override
  late final GeneratedColumn<String> markedWordIndexesCipher = GeneratedColumn<String>(
    'marked_word_indexes_cipher',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _voiceNoteCipherMeta = const VerificationMeta(
    'voiceNoteCipher',
  );
  @override
  late final GeneratedColumn<String> voiceNoteCipher = GeneratedColumn<String>(
    'voice_note_cipher',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    bookId,
    isFavorite,
    createdAt,
    updatedAt,
    keyVersion,
    quoteCipher,
    noteCipher,
    pageNumbersCipher,
    pagesCipher,
    wordsCipher,
    markedWordIndexesCipher,
    voiceNoteCipher,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuoteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('key_version')) {
      context.handle(
        _keyVersionMeta,
        keyVersion.isAcceptableOrUnknown(data['key_version']!, _keyVersionMeta),
      );
    } else if (isInserting) {
      context.missing(_keyVersionMeta);
    }
    if (data.containsKey('quote_cipher')) {
      context.handle(
        _quoteCipherMeta,
        quoteCipher.isAcceptableOrUnknown(
          data['quote_cipher']!,
          _quoteCipherMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quoteCipherMeta);
    }
    if (data.containsKey('note_cipher')) {
      context.handle(
        _noteCipherMeta,
        noteCipher.isAcceptableOrUnknown(data['note_cipher']!, _noteCipherMeta),
      );
    }
    if (data.containsKey('page_numbers_cipher')) {
      context.handle(
        _pageNumbersCipherMeta,
        pageNumbersCipher.isAcceptableOrUnknown(
          data['page_numbers_cipher']!,
          _pageNumbersCipherMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pageNumbersCipherMeta);
    }
    if (data.containsKey('pages_cipher')) {
      context.handle(
        _pagesCipherMeta,
        pagesCipher.isAcceptableOrUnknown(
          data['pages_cipher']!,
          _pagesCipherMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pagesCipherMeta);
    }
    if (data.containsKey('words_cipher')) {
      context.handle(
        _wordsCipherMeta,
        wordsCipher.isAcceptableOrUnknown(
          data['words_cipher']!,
          _wordsCipherMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wordsCipherMeta);
    }
    if (data.containsKey('marked_word_indexes_cipher')) {
      context.handle(
        _markedWordIndexesCipherMeta,
        markedWordIndexesCipher.isAcceptableOrUnknown(
          data['marked_word_indexes_cipher']!,
          _markedWordIndexesCipherMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_markedWordIndexesCipherMeta);
    }
    if (data.containsKey('voice_note_cipher')) {
      context.handle(
        _voiceNoteCipherMeta,
        voiceNoteCipher.isAcceptableOrUnknown(
          data['voice_note_cipher']!,
          _voiceNoteCipherMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuoteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuoteRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_favorite'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      keyVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}key_version'],
      )!,
      quoteCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote_cipher'],
      )!,
      noteCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note_cipher'],
      ),
      pageNumbersCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}page_numbers_cipher'],
      )!,
      pagesCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pages_cipher'],
      )!,
      wordsCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}words_cipher'],
      )!,
      markedWordIndexesCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marked_word_indexes_cipher'],
      )!,
      voiceNoteCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}voice_note_cipher'],
      ),
    );
  }

  @override
  $QuotesTable createAlias(String alias) {
    return $QuotesTable(attachedDatabase, alias);
  }
}

class QuoteRow extends DataClass implements Insertable<QuoteRow> {
  final String id;
  final String ownerId;
  final String bookId;
  final int isFavorite;
  final String createdAt;
  final String updatedAt;
  final int keyVersion;
  final String quoteCipher;
  final String? noteCipher;
  final String pageNumbersCipher;
  final String pagesCipher;
  final String wordsCipher;
  final String markedWordIndexesCipher;
  final String? voiceNoteCipher;
  const QuoteRow({
    required this.id,
    required this.ownerId,
    required this.bookId,
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
    required this.keyVersion,
    required this.quoteCipher,
    this.noteCipher,
    required this.pageNumbersCipher,
    required this.pagesCipher,
    required this.wordsCipher,
    required this.markedWordIndexesCipher,
    this.voiceNoteCipher,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['book_id'] = Variable<String>(bookId);
    map['is_favorite'] = Variable<int>(isFavorite);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['key_version'] = Variable<int>(keyVersion);
    map['quote_cipher'] = Variable<String>(quoteCipher);
    if (!nullToAbsent || noteCipher != null) {
      map['note_cipher'] = Variable<String>(noteCipher);
    }
    map['page_numbers_cipher'] = Variable<String>(pageNumbersCipher);
    map['pages_cipher'] = Variable<String>(pagesCipher);
    map['words_cipher'] = Variable<String>(wordsCipher);
    map['marked_word_indexes_cipher'] = Variable<String>(
      markedWordIndexesCipher,
    );
    if (!nullToAbsent || voiceNoteCipher != null) {
      map['voice_note_cipher'] = Variable<String>(voiceNoteCipher);
    }
    return map;
  }

  QuotesCompanion toCompanion(bool nullToAbsent) {
    return QuotesCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      bookId: Value(bookId),
      isFavorite: Value(isFavorite),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      keyVersion: Value(keyVersion),
      quoteCipher: Value(quoteCipher),
      noteCipher: noteCipher == null && nullToAbsent ? const Value.absent() : Value(noteCipher),
      pageNumbersCipher: Value(pageNumbersCipher),
      pagesCipher: Value(pagesCipher),
      wordsCipher: Value(wordsCipher),
      markedWordIndexesCipher: Value(markedWordIndexesCipher),
      voiceNoteCipher: voiceNoteCipher == null && nullToAbsent
          ? const Value.absent()
          : Value(voiceNoteCipher),
    );
  }

  factory QuoteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuoteRow(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      bookId: serializer.fromJson<String>(json['bookId']),
      isFavorite: serializer.fromJson<int>(json['isFavorite']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      keyVersion: serializer.fromJson<int>(json['keyVersion']),
      quoteCipher: serializer.fromJson<String>(json['quoteCipher']),
      noteCipher: serializer.fromJson<String?>(json['noteCipher']),
      pageNumbersCipher: serializer.fromJson<String>(json['pageNumbersCipher']),
      pagesCipher: serializer.fromJson<String>(json['pagesCipher']),
      wordsCipher: serializer.fromJson<String>(json['wordsCipher']),
      markedWordIndexesCipher: serializer.fromJson<String>(
        json['markedWordIndexesCipher'],
      ),
      voiceNoteCipher: serializer.fromJson<String?>(json['voiceNoteCipher']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'bookId': serializer.toJson<String>(bookId),
      'isFavorite': serializer.toJson<int>(isFavorite),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'keyVersion': serializer.toJson<int>(keyVersion),
      'quoteCipher': serializer.toJson<String>(quoteCipher),
      'noteCipher': serializer.toJson<String?>(noteCipher),
      'pageNumbersCipher': serializer.toJson<String>(pageNumbersCipher),
      'pagesCipher': serializer.toJson<String>(pagesCipher),
      'wordsCipher': serializer.toJson<String>(wordsCipher),
      'markedWordIndexesCipher': serializer.toJson<String>(
        markedWordIndexesCipher,
      ),
      'voiceNoteCipher': serializer.toJson<String?>(voiceNoteCipher),
    };
  }

  QuoteRow copyWith({
    String? id,
    String? ownerId,
    String? bookId,
    int? isFavorite,
    String? createdAt,
    String? updatedAt,
    int? keyVersion,
    String? quoteCipher,
    Value<String?> noteCipher = const Value.absent(),
    String? pageNumbersCipher,
    String? pagesCipher,
    String? wordsCipher,
    String? markedWordIndexesCipher,
    Value<String?> voiceNoteCipher = const Value.absent(),
  }) => QuoteRow(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    bookId: bookId ?? this.bookId,
    isFavorite: isFavorite ?? this.isFavorite,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    keyVersion: keyVersion ?? this.keyVersion,
    quoteCipher: quoteCipher ?? this.quoteCipher,
    noteCipher: noteCipher.present ? noteCipher.value : this.noteCipher,
    pageNumbersCipher: pageNumbersCipher ?? this.pageNumbersCipher,
    pagesCipher: pagesCipher ?? this.pagesCipher,
    wordsCipher: wordsCipher ?? this.wordsCipher,
    markedWordIndexesCipher: markedWordIndexesCipher ?? this.markedWordIndexesCipher,
    voiceNoteCipher: voiceNoteCipher.present ? voiceNoteCipher.value : this.voiceNoteCipher,
  );
  QuoteRow copyWithCompanion(QuotesCompanion data) {
    return QuoteRow(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      isFavorite: data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      keyVersion: data.keyVersion.present ? data.keyVersion.value : this.keyVersion,
      quoteCipher: data.quoteCipher.present ? data.quoteCipher.value : this.quoteCipher,
      noteCipher: data.noteCipher.present ? data.noteCipher.value : this.noteCipher,
      pageNumbersCipher: data.pageNumbersCipher.present
          ? data.pageNumbersCipher.value
          : this.pageNumbersCipher,
      pagesCipher: data.pagesCipher.present ? data.pagesCipher.value : this.pagesCipher,
      wordsCipher: data.wordsCipher.present ? data.wordsCipher.value : this.wordsCipher,
      markedWordIndexesCipher: data.markedWordIndexesCipher.present
          ? data.markedWordIndexesCipher.value
          : this.markedWordIndexesCipher,
      voiceNoteCipher: data.voiceNoteCipher.present
          ? data.voiceNoteCipher.value
          : this.voiceNoteCipher,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuoteRow(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('bookId: $bookId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('keyVersion: $keyVersion, ')
          ..write('quoteCipher: $quoteCipher, ')
          ..write('noteCipher: $noteCipher, ')
          ..write('pageNumbersCipher: $pageNumbersCipher, ')
          ..write('pagesCipher: $pagesCipher, ')
          ..write('wordsCipher: $wordsCipher, ')
          ..write('markedWordIndexesCipher: $markedWordIndexesCipher, ')
          ..write('voiceNoteCipher: $voiceNoteCipher')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerId,
    bookId,
    isFavorite,
    createdAt,
    updatedAt,
    keyVersion,
    quoteCipher,
    noteCipher,
    pageNumbersCipher,
    pagesCipher,
    wordsCipher,
    markedWordIndexesCipher,
    voiceNoteCipher,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuoteRow &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.bookId == this.bookId &&
          other.isFavorite == this.isFavorite &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.keyVersion == this.keyVersion &&
          other.quoteCipher == this.quoteCipher &&
          other.noteCipher == this.noteCipher &&
          other.pageNumbersCipher == this.pageNumbersCipher &&
          other.pagesCipher == this.pagesCipher &&
          other.wordsCipher == this.wordsCipher &&
          other.markedWordIndexesCipher == this.markedWordIndexesCipher &&
          other.voiceNoteCipher == this.voiceNoteCipher);
}

class QuotesCompanion extends UpdateCompanion<QuoteRow> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> bookId;
  final Value<int> isFavorite;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> keyVersion;
  final Value<String> quoteCipher;
  final Value<String?> noteCipher;
  final Value<String> pageNumbersCipher;
  final Value<String> pagesCipher;
  final Value<String> wordsCipher;
  final Value<String> markedWordIndexesCipher;
  final Value<String?> voiceNoteCipher;
  final Value<int> rowid;
  const QuotesCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.bookId = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.keyVersion = const Value.absent(),
    this.quoteCipher = const Value.absent(),
    this.noteCipher = const Value.absent(),
    this.pageNumbersCipher = const Value.absent(),
    this.pagesCipher = const Value.absent(),
    this.wordsCipher = const Value.absent(),
    this.markedWordIndexesCipher = const Value.absent(),
    this.voiceNoteCipher = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuotesCompanion.insert({
    required String id,
    required String ownerId,
    required String bookId,
    required int isFavorite,
    required String createdAt,
    required String updatedAt,
    required int keyVersion,
    required String quoteCipher,
    this.noteCipher = const Value.absent(),
    required String pageNumbersCipher,
    required String pagesCipher,
    required String wordsCipher,
    required String markedWordIndexesCipher,
    this.voiceNoteCipher = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       bookId = Value(bookId),
       isFavorite = Value(isFavorite),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       keyVersion = Value(keyVersion),
       quoteCipher = Value(quoteCipher),
       pageNumbersCipher = Value(pageNumbersCipher),
       pagesCipher = Value(pagesCipher),
       wordsCipher = Value(wordsCipher),
       markedWordIndexesCipher = Value(markedWordIndexesCipher);
  static Insertable<QuoteRow> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? bookId,
    Expression<int>? isFavorite,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? keyVersion,
    Expression<String>? quoteCipher,
    Expression<String>? noteCipher,
    Expression<String>? pageNumbersCipher,
    Expression<String>? pagesCipher,
    Expression<String>? wordsCipher,
    Expression<String>? markedWordIndexesCipher,
    Expression<String>? voiceNoteCipher,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (bookId != null) 'book_id': bookId,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (keyVersion != null) 'key_version': keyVersion,
      if (quoteCipher != null) 'quote_cipher': quoteCipher,
      if (noteCipher != null) 'note_cipher': noteCipher,
      if (pageNumbersCipher != null) 'page_numbers_cipher': pageNumbersCipher,
      if (pagesCipher != null) 'pages_cipher': pagesCipher,
      if (wordsCipher != null) 'words_cipher': wordsCipher,
      if (markedWordIndexesCipher != null) 'marked_word_indexes_cipher': markedWordIndexesCipher,
      if (voiceNoteCipher != null) 'voice_note_cipher': voiceNoteCipher,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuotesCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? bookId,
    Value<int>? isFavorite,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? keyVersion,
    Value<String>? quoteCipher,
    Value<String?>? noteCipher,
    Value<String>? pageNumbersCipher,
    Value<String>? pagesCipher,
    Value<String>? wordsCipher,
    Value<String>? markedWordIndexesCipher,
    Value<String?>? voiceNoteCipher,
    Value<int>? rowid,
  }) {
    return QuotesCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      bookId: bookId ?? this.bookId,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      keyVersion: keyVersion ?? this.keyVersion,
      quoteCipher: quoteCipher ?? this.quoteCipher,
      noteCipher: noteCipher ?? this.noteCipher,
      pageNumbersCipher: pageNumbersCipher ?? this.pageNumbersCipher,
      pagesCipher: pagesCipher ?? this.pagesCipher,
      wordsCipher: wordsCipher ?? this.wordsCipher,
      markedWordIndexesCipher: markedWordIndexesCipher ?? this.markedWordIndexesCipher,
      voiceNoteCipher: voiceNoteCipher ?? this.voiceNoteCipher,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<int>(isFavorite.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (keyVersion.present) {
      map['key_version'] = Variable<int>(keyVersion.value);
    }
    if (quoteCipher.present) {
      map['quote_cipher'] = Variable<String>(quoteCipher.value);
    }
    if (noteCipher.present) {
      map['note_cipher'] = Variable<String>(noteCipher.value);
    }
    if (pageNumbersCipher.present) {
      map['page_numbers_cipher'] = Variable<String>(pageNumbersCipher.value);
    }
    if (pagesCipher.present) {
      map['pages_cipher'] = Variable<String>(pagesCipher.value);
    }
    if (wordsCipher.present) {
      map['words_cipher'] = Variable<String>(wordsCipher.value);
    }
    if (markedWordIndexesCipher.present) {
      map['marked_word_indexes_cipher'] = Variable<String>(
        markedWordIndexesCipher.value,
      );
    }
    if (voiceNoteCipher.present) {
      map['voice_note_cipher'] = Variable<String>(voiceNoteCipher.value);
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
          ..write('ownerId: $ownerId, ')
          ..write('bookId: $bookId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('keyVersion: $keyVersion, ')
          ..write('quoteCipher: $quoteCipher, ')
          ..write('noteCipher: $noteCipher, ')
          ..write('pageNumbersCipher: $pageNumbersCipher, ')
          ..write('pagesCipher: $pagesCipher, ')
          ..write('wordsCipher: $wordsCipher, ')
          ..write('markedWordIndexesCipher: $markedWordIndexesCipher, ')
          ..write('voiceNoteCipher: $voiceNoteCipher, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ThemesTable extends Themes with TableInfo<$ThemesTable, ThemeRow> {
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
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
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
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyVersionMeta = const VerificationMeta(
    'keyVersion',
  );
  @override
  late final GeneratedColumn<int> keyVersion = GeneratedColumn<int>(
    'key_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameCipherMeta = const VerificationMeta(
    'nameCipher',
  );
  @override
  late final GeneratedColumn<String> nameCipher = GeneratedColumn<String>(
    'name_cipher',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    accent,
    symbol,
    createdAt,
    updatedAt,
    keyVersion,
    nameCipher,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'themes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ThemeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('key_version')) {
      context.handle(
        _keyVersionMeta,
        keyVersion.isAcceptableOrUnknown(data['key_version']!, _keyVersionMeta),
      );
    } else if (isInserting) {
      context.missing(_keyVersionMeta);
    }
    if (data.containsKey('name_cipher')) {
      context.handle(
        _nameCipherMeta,
        nameCipher.isAcceptableOrUnknown(data['name_cipher']!, _nameCipherMeta),
      );
    } else if (isInserting) {
      context.missing(_nameCipherMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ThemeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ThemeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
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
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      keyVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}key_version'],
      )!,
      nameCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_cipher'],
      )!,
    );
  }

  @override
  $ThemesTable createAlias(String alias) {
    return $ThemesTable(attachedDatabase, alias);
  }
}

class ThemeRow extends DataClass implements Insertable<ThemeRow> {
  final String id;
  final String ownerId;
  final String? accent;
  final String? symbol;
  final String createdAt;
  final String updatedAt;
  final int keyVersion;
  final String nameCipher;
  const ThemeRow({
    required this.id,
    required this.ownerId,
    this.accent,
    this.symbol,
    required this.createdAt,
    required this.updatedAt,
    required this.keyVersion,
    required this.nameCipher,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    if (!nullToAbsent || accent != null) {
      map['accent'] = Variable<String>(accent);
    }
    if (!nullToAbsent || symbol != null) {
      map['symbol'] = Variable<String>(symbol);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['key_version'] = Variable<int>(keyVersion);
    map['name_cipher'] = Variable<String>(nameCipher);
    return map;
  }

  ThemesCompanion toCompanion(bool nullToAbsent) {
    return ThemesCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      accent: accent == null && nullToAbsent ? const Value.absent() : Value(accent),
      symbol: symbol == null && nullToAbsent ? const Value.absent() : Value(symbol),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      keyVersion: Value(keyVersion),
      nameCipher: Value(nameCipher),
    );
  }

  factory ThemeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ThemeRow(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      accent: serializer.fromJson<String?>(json['accent']),
      symbol: serializer.fromJson<String?>(json['symbol']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      keyVersion: serializer.fromJson<int>(json['keyVersion']),
      nameCipher: serializer.fromJson<String>(json['nameCipher']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'accent': serializer.toJson<String?>(accent),
      'symbol': serializer.toJson<String?>(symbol),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'keyVersion': serializer.toJson<int>(keyVersion),
      'nameCipher': serializer.toJson<String>(nameCipher),
    };
  }

  ThemeRow copyWith({
    String? id,
    String? ownerId,
    Value<String?> accent = const Value.absent(),
    Value<String?> symbol = const Value.absent(),
    String? createdAt,
    String? updatedAt,
    int? keyVersion,
    String? nameCipher,
  }) => ThemeRow(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    accent: accent.present ? accent.value : this.accent,
    symbol: symbol.present ? symbol.value : this.symbol,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    keyVersion: keyVersion ?? this.keyVersion,
    nameCipher: nameCipher ?? this.nameCipher,
  );
  ThemeRow copyWithCompanion(ThemesCompanion data) {
    return ThemeRow(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      accent: data.accent.present ? data.accent.value : this.accent,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      keyVersion: data.keyVersion.present ? data.keyVersion.value : this.keyVersion,
      nameCipher: data.nameCipher.present ? data.nameCipher.value : this.nameCipher,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ThemeRow(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('accent: $accent, ')
          ..write('symbol: $symbol, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('keyVersion: $keyVersion, ')
          ..write('nameCipher: $nameCipher')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerId,
    accent,
    symbol,
    createdAt,
    updatedAt,
    keyVersion,
    nameCipher,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ThemeRow &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.accent == this.accent &&
          other.symbol == this.symbol &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.keyVersion == this.keyVersion &&
          other.nameCipher == this.nameCipher);
}

class ThemesCompanion extends UpdateCompanion<ThemeRow> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String?> accent;
  final Value<String?> symbol;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> keyVersion;
  final Value<String> nameCipher;
  final Value<int> rowid;
  const ThemesCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.accent = const Value.absent(),
    this.symbol = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.keyVersion = const Value.absent(),
    this.nameCipher = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ThemesCompanion.insert({
    required String id,
    required String ownerId,
    this.accent = const Value.absent(),
    this.symbol = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    required int keyVersion,
    required String nameCipher,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       keyVersion = Value(keyVersion),
       nameCipher = Value(nameCipher);
  static Insertable<ThemeRow> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? accent,
    Expression<String>? symbol,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? keyVersion,
    Expression<String>? nameCipher,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (accent != null) 'accent': accent,
      if (symbol != null) 'symbol': symbol,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (keyVersion != null) 'key_version': keyVersion,
      if (nameCipher != null) 'name_cipher': nameCipher,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ThemesCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String?>? accent,
    Value<String?>? symbol,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? keyVersion,
    Value<String>? nameCipher,
    Value<int>? rowid,
  }) {
    return ThemesCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      accent: accent ?? this.accent,
      symbol: symbol ?? this.symbol,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      keyVersion: keyVersion ?? this.keyVersion,
      nameCipher: nameCipher ?? this.nameCipher,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (accent.present) {
      map['accent'] = Variable<String>(accent.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (keyVersion.present) {
      map['key_version'] = Variable<int>(keyVersion.value);
    }
    if (nameCipher.present) {
      map['name_cipher'] = Variable<String>(nameCipher.value);
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
          ..write('ownerId: $ownerId, ')
          ..write('accent: $accent, ')
          ..write('symbol: $symbol, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('keyVersion: $keyVersion, ')
          ..write('nameCipher: $nameCipher, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ThemeQuotesTable extends ThemeQuotes with TableInfo<$ThemeQuotesTable, ThemeQuoteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThemeQuotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    themeId,
    quoteId,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'theme_quotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ThemeQuoteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ThemeQuoteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ThemeQuoteRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      themeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_id'],
      )!,
      quoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ThemeQuotesTable createAlias(String alias) {
    return $ThemeQuotesTable(attachedDatabase, alias);
  }
}

class ThemeQuoteRow extends DataClass implements Insertable<ThemeQuoteRow> {
  final String id;
  final String ownerId;
  final String themeId;
  final String quoteId;
  final String updatedAt;
  const ThemeQuoteRow({
    required this.id,
    required this.ownerId,
    required this.themeId,
    required this.quoteId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['theme_id'] = Variable<String>(themeId);
    map['quote_id'] = Variable<String>(quoteId);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  ThemeQuotesCompanion toCompanion(bool nullToAbsent) {
    return ThemeQuotesCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      themeId: Value(themeId),
      quoteId: Value(quoteId),
      updatedAt: Value(updatedAt),
    );
  }

  factory ThemeQuoteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ThemeQuoteRow(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      themeId: serializer.fromJson<String>(json['themeId']),
      quoteId: serializer.fromJson<String>(json['quoteId']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'themeId': serializer.toJson<String>(themeId),
      'quoteId': serializer.toJson<String>(quoteId),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  ThemeQuoteRow copyWith({
    String? id,
    String? ownerId,
    String? themeId,
    String? quoteId,
    String? updatedAt,
  }) => ThemeQuoteRow(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    themeId: themeId ?? this.themeId,
    quoteId: quoteId ?? this.quoteId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ThemeQuoteRow copyWithCompanion(ThemeQuotesCompanion data) {
    return ThemeQuoteRow(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      themeId: data.themeId.present ? data.themeId.value : this.themeId,
      quoteId: data.quoteId.present ? data.quoteId.value : this.quoteId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ThemeQuoteRow(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('themeId: $themeId, ')
          ..write('quoteId: $quoteId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ownerId, themeId, quoteId, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ThemeQuoteRow &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.themeId == this.themeId &&
          other.quoteId == this.quoteId &&
          other.updatedAt == this.updatedAt);
}

class ThemeQuotesCompanion extends UpdateCompanion<ThemeQuoteRow> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> themeId;
  final Value<String> quoteId;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const ThemeQuotesCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.themeId = const Value.absent(),
    this.quoteId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ThemeQuotesCompanion.insert({
    required String id,
    required String ownerId,
    required String themeId,
    required String quoteId,
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       themeId = Value(themeId),
       quoteId = Value(quoteId),
       updatedAt = Value(updatedAt);
  static Insertable<ThemeQuoteRow> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? themeId,
    Expression<String>? quoteId,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (themeId != null) 'theme_id': themeId,
      if (quoteId != null) 'quote_id': quoteId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ThemeQuotesCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? themeId,
    Value<String>? quoteId,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return ThemeQuotesCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      themeId: themeId ?? this.themeId,
      quoteId: quoteId ?? this.quoteId,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (themeId.present) {
      map['theme_id'] = Variable<String>(themeId.value);
    }
    if (quoteId.present) {
      map['quote_id'] = Variable<String>(quoteId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThemeQuotesCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('themeId: $themeId, ')
          ..write('quoteId: $quoteId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShelvesTable extends Shelves with TableInfo<$ShelvesTable, ShelfRow> {
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
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
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
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyVersionMeta = const VerificationMeta(
    'keyVersion',
  );
  @override
  late final GeneratedColumn<int> keyVersion = GeneratedColumn<int>(
    'key_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameCipherMeta = const VerificationMeta(
    'nameCipher',
  );
  @override
  late final GeneratedColumn<String> nameCipher = GeneratedColumn<String>(
    'name_cipher',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    accent,
    symbol,
    createdAt,
    updatedAt,
    keyVersion,
    nameCipher,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shelves';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShelfRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('key_version')) {
      context.handle(
        _keyVersionMeta,
        keyVersion.isAcceptableOrUnknown(data['key_version']!, _keyVersionMeta),
      );
    } else if (isInserting) {
      context.missing(_keyVersionMeta);
    }
    if (data.containsKey('name_cipher')) {
      context.handle(
        _nameCipherMeta,
        nameCipher.isAcceptableOrUnknown(data['name_cipher']!, _nameCipherMeta),
      );
    } else if (isInserting) {
      context.missing(_nameCipherMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShelfRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShelfRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
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
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      keyVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}key_version'],
      )!,
      nameCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_cipher'],
      )!,
    );
  }

  @override
  $ShelvesTable createAlias(String alias) {
    return $ShelvesTable(attachedDatabase, alias);
  }
}

class ShelfRow extends DataClass implements Insertable<ShelfRow> {
  final String id;
  final String ownerId;
  final String? accent;
  final String? symbol;
  final String createdAt;
  final String updatedAt;
  final int keyVersion;
  final String nameCipher;
  const ShelfRow({
    required this.id,
    required this.ownerId,
    this.accent,
    this.symbol,
    required this.createdAt,
    required this.updatedAt,
    required this.keyVersion,
    required this.nameCipher,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    if (!nullToAbsent || accent != null) {
      map['accent'] = Variable<String>(accent);
    }
    if (!nullToAbsent || symbol != null) {
      map['symbol'] = Variable<String>(symbol);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['key_version'] = Variable<int>(keyVersion);
    map['name_cipher'] = Variable<String>(nameCipher);
    return map;
  }

  ShelvesCompanion toCompanion(bool nullToAbsent) {
    return ShelvesCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      accent: accent == null && nullToAbsent ? const Value.absent() : Value(accent),
      symbol: symbol == null && nullToAbsent ? const Value.absent() : Value(symbol),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      keyVersion: Value(keyVersion),
      nameCipher: Value(nameCipher),
    );
  }

  factory ShelfRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShelfRow(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      accent: serializer.fromJson<String?>(json['accent']),
      symbol: serializer.fromJson<String?>(json['symbol']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      keyVersion: serializer.fromJson<int>(json['keyVersion']),
      nameCipher: serializer.fromJson<String>(json['nameCipher']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'accent': serializer.toJson<String?>(accent),
      'symbol': serializer.toJson<String?>(symbol),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'keyVersion': serializer.toJson<int>(keyVersion),
      'nameCipher': serializer.toJson<String>(nameCipher),
    };
  }

  ShelfRow copyWith({
    String? id,
    String? ownerId,
    Value<String?> accent = const Value.absent(),
    Value<String?> symbol = const Value.absent(),
    String? createdAt,
    String? updatedAt,
    int? keyVersion,
    String? nameCipher,
  }) => ShelfRow(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    accent: accent.present ? accent.value : this.accent,
    symbol: symbol.present ? symbol.value : this.symbol,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    keyVersion: keyVersion ?? this.keyVersion,
    nameCipher: nameCipher ?? this.nameCipher,
  );
  ShelfRow copyWithCompanion(ShelvesCompanion data) {
    return ShelfRow(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      accent: data.accent.present ? data.accent.value : this.accent,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      keyVersion: data.keyVersion.present ? data.keyVersion.value : this.keyVersion,
      nameCipher: data.nameCipher.present ? data.nameCipher.value : this.nameCipher,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShelfRow(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('accent: $accent, ')
          ..write('symbol: $symbol, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('keyVersion: $keyVersion, ')
          ..write('nameCipher: $nameCipher')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerId,
    accent,
    symbol,
    createdAt,
    updatedAt,
    keyVersion,
    nameCipher,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShelfRow &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.accent == this.accent &&
          other.symbol == this.symbol &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.keyVersion == this.keyVersion &&
          other.nameCipher == this.nameCipher);
}

class ShelvesCompanion extends UpdateCompanion<ShelfRow> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String?> accent;
  final Value<String?> symbol;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> keyVersion;
  final Value<String> nameCipher;
  final Value<int> rowid;
  const ShelvesCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.accent = const Value.absent(),
    this.symbol = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.keyVersion = const Value.absent(),
    this.nameCipher = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShelvesCompanion.insert({
    required String id,
    required String ownerId,
    this.accent = const Value.absent(),
    this.symbol = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    required int keyVersion,
    required String nameCipher,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       keyVersion = Value(keyVersion),
       nameCipher = Value(nameCipher);
  static Insertable<ShelfRow> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? accent,
    Expression<String>? symbol,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? keyVersion,
    Expression<String>? nameCipher,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (accent != null) 'accent': accent,
      if (symbol != null) 'symbol': symbol,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (keyVersion != null) 'key_version': keyVersion,
      if (nameCipher != null) 'name_cipher': nameCipher,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShelvesCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String?>? accent,
    Value<String?>? symbol,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? keyVersion,
    Value<String>? nameCipher,
    Value<int>? rowid,
  }) {
    return ShelvesCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      accent: accent ?? this.accent,
      symbol: symbol ?? this.symbol,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      keyVersion: keyVersion ?? this.keyVersion,
      nameCipher: nameCipher ?? this.nameCipher,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (accent.present) {
      map['accent'] = Variable<String>(accent.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (keyVersion.present) {
      map['key_version'] = Variable<int>(keyVersion.value);
    }
    if (nameCipher.present) {
      map['name_cipher'] = Variable<String>(nameCipher.value);
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
          ..write('ownerId: $ownerId, ')
          ..write('accent: $accent, ')
          ..write('symbol: $symbol, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('keyVersion: $keyVersion, ')
          ..write('nameCipher: $nameCipher, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShelfBooksTable extends ShelfBooks with TableInfo<$ShelfBooksTable, ShelfBookRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShelfBooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    shelfId,
    bookId,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shelf_books';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShelfBookRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShelfBookRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShelfBookRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      shelfId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shelf_id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ShelfBooksTable createAlias(String alias) {
    return $ShelfBooksTable(attachedDatabase, alias);
  }
}

class ShelfBookRow extends DataClass implements Insertable<ShelfBookRow> {
  final String id;
  final String ownerId;
  final String shelfId;
  final String bookId;
  final String updatedAt;
  const ShelfBookRow({
    required this.id,
    required this.ownerId,
    required this.shelfId,
    required this.bookId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['shelf_id'] = Variable<String>(shelfId);
    map['book_id'] = Variable<String>(bookId);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  ShelfBooksCompanion toCompanion(bool nullToAbsent) {
    return ShelfBooksCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      shelfId: Value(shelfId),
      bookId: Value(bookId),
      updatedAt: Value(updatedAt),
    );
  }

  factory ShelfBookRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShelfBookRow(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      shelfId: serializer.fromJson<String>(json['shelfId']),
      bookId: serializer.fromJson<String>(json['bookId']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'shelfId': serializer.toJson<String>(shelfId),
      'bookId': serializer.toJson<String>(bookId),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  ShelfBookRow copyWith({
    String? id,
    String? ownerId,
    String? shelfId,
    String? bookId,
    String? updatedAt,
  }) => ShelfBookRow(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    shelfId: shelfId ?? this.shelfId,
    bookId: bookId ?? this.bookId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ShelfBookRow copyWithCompanion(ShelfBooksCompanion data) {
    return ShelfBookRow(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      shelfId: data.shelfId.present ? data.shelfId.value : this.shelfId,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShelfBookRow(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('shelfId: $shelfId, ')
          ..write('bookId: $bookId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ownerId, shelfId, bookId, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShelfBookRow &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.shelfId == this.shelfId &&
          other.bookId == this.bookId &&
          other.updatedAt == this.updatedAt);
}

class ShelfBooksCompanion extends UpdateCompanion<ShelfBookRow> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> shelfId;
  final Value<String> bookId;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const ShelfBooksCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.shelfId = const Value.absent(),
    this.bookId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShelfBooksCompanion.insert({
    required String id,
    required String ownerId,
    required String shelfId,
    required String bookId,
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       shelfId = Value(shelfId),
       bookId = Value(bookId),
       updatedAt = Value(updatedAt);
  static Insertable<ShelfBookRow> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? shelfId,
    Expression<String>? bookId,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (shelfId != null) 'shelf_id': shelfId,
      if (bookId != null) 'book_id': bookId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShelfBooksCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? shelfId,
    Value<String>? bookId,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return ShelfBooksCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      shelfId: shelfId ?? this.shelfId,
      bookId: bookId ?? this.bookId,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (shelfId.present) {
      map['shelf_id'] = Variable<String>(shelfId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShelfBooksCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('shelfId: $shelfId, ')
          ..write('bookId: $bookId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTableTable extends SettingsTable with TableInfo<$SettingsTableTable, LocalSettings> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _contrastPreferenceMeta = const VerificationMeta(
    'contrastPreference',
  );
  @override
  late final GeneratedColumn<String> contrastPreference = GeneratedColumn<String>(
    'contrast_preference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _backupPromptDismissedMeta = const VerificationMeta(
    'backupPromptDismissed',
  );
  @override
  late final GeneratedColumn<int> backupPromptDismissed = GeneratedColumn<int>(
    'backup_prompt_dismissed',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    localePreference,
    themePreference,
    contrastPreference,
    backupPromptDismissed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSettings> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    if (data.containsKey('backup_prompt_dismissed')) {
      context.handle(
        _backupPromptDismissedMeta,
        backupPromptDismissed.isAcceptableOrUnknown(
          data['backup_prompt_dismissed']!,
          _backupPromptDismissedMeta,
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
        DriftSqlType.string,
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
      backupPromptDismissed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}backup_prompt_dismissed'],
      ),
    );
  }

  @override
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }
}

class LocalSettings extends DataClass implements Insertable<LocalSettings> {
  final String id;
  final String? displayName;
  final String? localePreference;
  final String? themePreference;
  final String? contrastPreference;
  final int? backupPromptDismissed;
  const LocalSettings({
    required this.id,
    this.displayName,
    this.localePreference,
    this.themePreference,
    this.contrastPreference,
    this.backupPromptDismissed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
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
    if (!nullToAbsent || backupPromptDismissed != null) {
      map['backup_prompt_dismissed'] = Variable<int>(backupPromptDismissed);
    }
    return map;
  }

  SettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SettingsTableCompanion(
      id: Value(id),
      displayName: displayName == null && nullToAbsent ? const Value.absent() : Value(displayName),
      localePreference: localePreference == null && nullToAbsent
          ? const Value.absent()
          : Value(localePreference),
      themePreference: themePreference == null && nullToAbsent
          ? const Value.absent()
          : Value(themePreference),
      contrastPreference: contrastPreference == null && nullToAbsent
          ? const Value.absent()
          : Value(contrastPreference),
      backupPromptDismissed: backupPromptDismissed == null && nullToAbsent
          ? const Value.absent()
          : Value(backupPromptDismissed),
    );
  }

  factory LocalSettings.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSettings(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      localePreference: serializer.fromJson<String?>(json['localePreference']),
      themePreference: serializer.fromJson<String?>(json['themePreference']),
      contrastPreference: serializer.fromJson<String?>(
        json['contrastPreference'],
      ),
      backupPromptDismissed: serializer.fromJson<int?>(
        json['backupPromptDismissed'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String?>(displayName),
      'localePreference': serializer.toJson<String?>(localePreference),
      'themePreference': serializer.toJson<String?>(themePreference),
      'contrastPreference': serializer.toJson<String?>(contrastPreference),
      'backupPromptDismissed': serializer.toJson<int?>(backupPromptDismissed),
    };
  }

  LocalSettings copyWith({
    String? id,
    Value<String?> displayName = const Value.absent(),
    Value<String?> localePreference = const Value.absent(),
    Value<String?> themePreference = const Value.absent(),
    Value<String?> contrastPreference = const Value.absent(),
    Value<int?> backupPromptDismissed = const Value.absent(),
  }) => LocalSettings(
    id: id ?? this.id,
    displayName: displayName.present ? displayName.value : this.displayName,
    localePreference: localePreference.present ? localePreference.value : this.localePreference,
    themePreference: themePreference.present ? themePreference.value : this.themePreference,
    contrastPreference: contrastPreference.present
        ? contrastPreference.value
        : this.contrastPreference,
    backupPromptDismissed: backupPromptDismissed.present
        ? backupPromptDismissed.value
        : this.backupPromptDismissed,
  );
  LocalSettings copyWithCompanion(SettingsTableCompanion data) {
    return LocalSettings(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present ? data.displayName.value : this.displayName,
      localePreference: data.localePreference.present
          ? data.localePreference.value
          : this.localePreference,
      themePreference: data.themePreference.present
          ? data.themePreference.value
          : this.themePreference,
      contrastPreference: data.contrastPreference.present
          ? data.contrastPreference.value
          : this.contrastPreference,
      backupPromptDismissed: data.backupPromptDismissed.present
          ? data.backupPromptDismissed.value
          : this.backupPromptDismissed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSettings(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('localePreference: $localePreference, ')
          ..write('themePreference: $themePreference, ')
          ..write('contrastPreference: $contrastPreference, ')
          ..write('backupPromptDismissed: $backupPromptDismissed')
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
    backupPromptDismissed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSettings &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.localePreference == this.localePreference &&
          other.themePreference == this.themePreference &&
          other.contrastPreference == this.contrastPreference &&
          other.backupPromptDismissed == this.backupPromptDismissed);
}

class SettingsTableCompanion extends UpdateCompanion<LocalSettings> {
  final Value<String> id;
  final Value<String?> displayName;
  final Value<String?> localePreference;
  final Value<String?> themePreference;
  final Value<String?> contrastPreference;
  final Value<int?> backupPromptDismissed;
  final Value<int> rowid;
  const SettingsTableCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.localePreference = const Value.absent(),
    this.themePreference = const Value.absent(),
    this.contrastPreference = const Value.absent(),
    this.backupPromptDismissed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    required String id,
    this.displayName = const Value.absent(),
    this.localePreference = const Value.absent(),
    this.themePreference = const Value.absent(),
    this.contrastPreference = const Value.absent(),
    this.backupPromptDismissed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<LocalSettings> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? localePreference,
    Expression<String>? themePreference,
    Expression<String>? contrastPreference,
    Expression<int>? backupPromptDismissed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (localePreference != null) 'locale_preference': localePreference,
      if (themePreference != null) 'theme_preference': themePreference,
      if (contrastPreference != null) 'contrast_preference': contrastPreference,
      if (backupPromptDismissed != null) 'backup_prompt_dismissed': backupPromptDismissed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? displayName,
    Value<String?>? localePreference,
    Value<String?>? themePreference,
    Value<String?>? contrastPreference,
    Value<int?>? backupPromptDismissed,
    Value<int>? rowid,
  }) {
    return SettingsTableCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      localePreference: localePreference ?? this.localePreference,
      themePreference: themePreference ?? this.themePreference,
      contrastPreference: contrastPreference ?? this.contrastPreference,
      backupPromptDismissed: backupPromptDismissed ?? this.backupPromptDismissed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
    if (backupPromptDismissed.present) {
      map['backup_prompt_dismissed'] = Variable<int>(
        backupPromptDismissed.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
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
          ..write('contrastPreference: $contrastPreference, ')
          ..write('backupPromptDismissed: $backupPromptDismissed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppConfigCacheTableTable extends AppConfigCacheTable
    with TableInfo<$AppConfigCacheTableTable, LocalAppConfigCache> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppConfigCacheTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<String> fetchedAt = GeneratedColumn<String>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, version, fetchedAt, payload];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_config_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalAppConfigCache> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalAppConfigCache map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalAppConfigCache(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fetched_at'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
    );
  }

  @override
  $AppConfigCacheTableTable createAlias(String alias) {
    return $AppConfigCacheTableTable(attachedDatabase, alias);
  }
}

class LocalAppConfigCache extends DataClass implements Insertable<LocalAppConfigCache> {
  final String id;
  final int version;
  final String fetchedAt;
  final String payload;
  const LocalAppConfigCache({
    required this.id,
    required this.version,
    required this.fetchedAt,
    required this.payload,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['version'] = Variable<int>(version);
    map['fetched_at'] = Variable<String>(fetchedAt);
    map['payload'] = Variable<String>(payload);
    return map;
  }

  AppConfigCacheTableCompanion toCompanion(bool nullToAbsent) {
    return AppConfigCacheTableCompanion(
      id: Value(id),
      version: Value(version),
      fetchedAt: Value(fetchedAt),
      payload: Value(payload),
    );
  }

  factory LocalAppConfigCache.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalAppConfigCache(
      id: serializer.fromJson<String>(json['id']),
      version: serializer.fromJson<int>(json['version']),
      fetchedAt: serializer.fromJson<String>(json['fetchedAt']),
      payload: serializer.fromJson<String>(json['payload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'version': serializer.toJson<int>(version),
      'fetchedAt': serializer.toJson<String>(fetchedAt),
      'payload': serializer.toJson<String>(payload),
    };
  }

  LocalAppConfigCache copyWith({
    String? id,
    int? version,
    String? fetchedAt,
    String? payload,
  }) => LocalAppConfigCache(
    id: id ?? this.id,
    version: version ?? this.version,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    payload: payload ?? this.payload,
  );
  LocalAppConfigCache copyWithCompanion(AppConfigCacheTableCompanion data) {
    return LocalAppConfigCache(
      id: data.id.present ? data.id.value : this.id,
      version: data.version.present ? data.version.value : this.version,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      payload: data.payload.present ? data.payload.value : this.payload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalAppConfigCache(')
          ..write('id: $id, ')
          ..write('version: $version, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, version, fetchedAt, payload);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalAppConfigCache &&
          other.id == this.id &&
          other.version == this.version &&
          other.fetchedAt == this.fetchedAt &&
          other.payload == this.payload);
}

class AppConfigCacheTableCompanion extends UpdateCompanion<LocalAppConfigCache> {
  final Value<String> id;
  final Value<int> version;
  final Value<String> fetchedAt;
  final Value<String> payload;
  final Value<int> rowid;
  const AppConfigCacheTableCompanion({
    this.id = const Value.absent(),
    this.version = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.payload = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppConfigCacheTableCompanion.insert({
    required String id,
    required int version,
    required String fetchedAt,
    required String payload,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       version = Value(version),
       fetchedAt = Value(fetchedAt),
       payload = Value(payload);
  static Insertable<LocalAppConfigCache> custom({
    Expression<String>? id,
    Expression<int>? version,
    Expression<String>? fetchedAt,
    Expression<String>? payload,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (version != null) 'version': version,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (payload != null) 'payload': payload,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppConfigCacheTableCompanion copyWith({
    Value<String>? id,
    Value<int>? version,
    Value<String>? fetchedAt,
    Value<String>? payload,
    Value<int>? rowid,
  }) {
    return AppConfigCacheTableCompanion(
      id: id ?? this.id,
      version: version ?? this.version,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      payload: payload ?? this.payload,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<String>(fetchedAt.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppConfigCacheTableCompanion(')
          ..write('id: $id, ')
          ..write('version: $version, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('payload: $payload, ')
          ..write('rowid: $rowid')
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
  late final $AppConfigCacheTableTable appConfigCacheTable = $AppConfigCacheTableTable(this);
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
    appConfigCacheTable,
  ];
}

typedef $$BooksTableCreateCompanionBuilder = BooksCompanion Function({
  required String id,
  required String ownerId,
  required String status,
  required String createdAt,
  required String lastUsedAt,
  required String updatedAt,
  required int keyVersion,
  required String titleCipher,
  required String authorsCipher,
  Value<String?> isbnCipher,
  Value<String?> coverCipher,
  Value<int> rowid,
});
typedef $$BooksTableUpdateCompanionBuilder = BooksCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<String> status,
  Value<String> createdAt,
  Value<String> lastUsedAt,
  Value<String> updatedAt,
  Value<int> keyVersion,
  Value<String> titleCipher,
  Value<String> authorsCipher,
  Value<String?> isbnCipher,
  Value<String?> coverCipher,
  Value<int> rowid,
});

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

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleCipher => $composableBuilder(
    column: $table.titleCipher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorsCipher => $composableBuilder(
    column: $table.authorsCipher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get isbnCipher => $composableBuilder(
    column: $table.isbnCipher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverCipher => $composableBuilder(
    column: $table.coverCipher,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BooksTableOrderingComposer extends Composer<_$AppDatabase, $BooksTable> {
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

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleCipher => $composableBuilder(
    column: $table.titleCipher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorsCipher => $composableBuilder(
    column: $table.authorsCipher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get isbnCipher => $composableBuilder(
    column: $table.isbnCipher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverCipher => $composableBuilder(
    column: $table.coverCipher,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BooksTableAnnotationComposer extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleCipher => $composableBuilder(
    column: $table.titleCipher,
    builder: (column) => column,
  );

  GeneratedColumn<String> get authorsCipher => $composableBuilder(
    column: $table.authorsCipher,
    builder: (column) => column,
  );

  GeneratedColumn<String> get isbnCipher => $composableBuilder(
    column: $table.isbnCipher,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverCipher => $composableBuilder(
    column: $table.coverCipher,
    builder: (column) => column,
  );
}

class $$BooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BooksTable,
          BookRow,
          $$BooksTableFilterComposer,
          $$BooksTableOrderingComposer,
          $$BooksTableAnnotationComposer,
          $$BooksTableCreateCompanionBuilder,
          $$BooksTableUpdateCompanionBuilder,
          (BookRow, BaseReferences<_$AppDatabase, $BooksTable, BookRow>),
          BookRow,
          PrefetchHooks Function()
        > {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> lastUsedAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> keyVersion = const Value.absent(),
                Value<String> titleCipher = const Value.absent(),
                Value<String> authorsCipher = const Value.absent(),
                Value<String?> isbnCipher = const Value.absent(),
                Value<String?> coverCipher = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion(
                id: id,
                ownerId: ownerId,
                status: status,
                createdAt: createdAt,
                lastUsedAt: lastUsedAt,
                updatedAt: updatedAt,
                keyVersion: keyVersion,
                titleCipher: titleCipher,
                authorsCipher: authorsCipher,
                isbnCipher: isbnCipher,
                coverCipher: coverCipher,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerId,
                required String status,
                required String createdAt,
                required String lastUsedAt,
                required String updatedAt,
                required int keyVersion,
                required String titleCipher,
                required String authorsCipher,
                Value<String?> isbnCipher = const Value.absent(),
                Value<String?> coverCipher = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion.insert(
                id: id,
                ownerId: ownerId,
                status: status,
                createdAt: createdAt,
                lastUsedAt: lastUsedAt,
                updatedAt: updatedAt,
                keyVersion: keyVersion,
                titleCipher: titleCipher,
                authorsCipher: authorsCipher,
                isbnCipher: isbnCipher,
                coverCipher: coverCipher,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BooksTable,
      BookRow,
      $$BooksTableFilterComposer,
      $$BooksTableOrderingComposer,
      $$BooksTableAnnotationComposer,
      $$BooksTableCreateCompanionBuilder,
      $$BooksTableUpdateCompanionBuilder,
      (BookRow, BaseReferences<_$AppDatabase, $BooksTable, BookRow>),
      BookRow,
      PrefetchHooks Function()
    >;
typedef $$QuotesTableCreateCompanionBuilder = QuotesCompanion Function({
  required String id,
  required String ownerId,
  required String bookId,
  required int isFavorite,
  required String createdAt,
  required String updatedAt,
  required int keyVersion,
  required String quoteCipher,
  Value<String?> noteCipher,
  required String pageNumbersCipher,
  required String pagesCipher,
  required String wordsCipher,
  required String markedWordIndexesCipher,
  Value<String?> voiceNoteCipher,
  Value<int> rowid,
});
typedef $$QuotesTableUpdateCompanionBuilder = QuotesCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<String> bookId,
  Value<int> isFavorite,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<int> keyVersion,
  Value<String> quoteCipher,
  Value<String?> noteCipher,
  Value<String> pageNumbersCipher,
  Value<String> pagesCipher,
  Value<String> wordsCipher,
  Value<String> markedWordIndexesCipher,
  Value<String?> voiceNoteCipher,
  Value<int> rowid,
});

class $$QuotesTableFilterComposer extends Composer<_$AppDatabase, $QuotesTable> {
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

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quoteCipher => $composableBuilder(
    column: $table.quoteCipher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noteCipher => $composableBuilder(
    column: $table.noteCipher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pageNumbersCipher => $composableBuilder(
    column: $table.pageNumbersCipher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pagesCipher => $composableBuilder(
    column: $table.pagesCipher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wordsCipher => $composableBuilder(
    column: $table.wordsCipher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get markedWordIndexesCipher => $composableBuilder(
    column: $table.markedWordIndexesCipher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get voiceNoteCipher => $composableBuilder(
    column: $table.voiceNoteCipher,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuotesTableOrderingComposer extends Composer<_$AppDatabase, $QuotesTable> {
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

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quoteCipher => $composableBuilder(
    column: $table.quoteCipher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noteCipher => $composableBuilder(
    column: $table.noteCipher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pageNumbersCipher => $composableBuilder(
    column: $table.pageNumbersCipher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pagesCipher => $composableBuilder(
    column: $table.pagesCipher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wordsCipher => $composableBuilder(
    column: $table.wordsCipher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get markedWordIndexesCipher => $composableBuilder(
    column: $table.markedWordIndexesCipher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get voiceNoteCipher => $composableBuilder(
    column: $table.voiceNoteCipher,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuotesTableAnnotationComposer extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quoteCipher => $composableBuilder(
    column: $table.quoteCipher,
    builder: (column) => column,
  );

  GeneratedColumn<String> get noteCipher => $composableBuilder(
    column: $table.noteCipher,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pageNumbersCipher => $composableBuilder(
    column: $table.pageNumbersCipher,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pagesCipher => $composableBuilder(
    column: $table.pagesCipher,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wordsCipher => $composableBuilder(
    column: $table.wordsCipher,
    builder: (column) => column,
  );

  GeneratedColumn<String> get markedWordIndexesCipher => $composableBuilder(
    column: $table.markedWordIndexesCipher,
    builder: (column) => column,
  );

  GeneratedColumn<String> get voiceNoteCipher => $composableBuilder(
    column: $table.voiceNoteCipher,
    builder: (column) => column,
  );
}

class $$QuotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuotesTable,
          QuoteRow,
          $$QuotesTableFilterComposer,
          $$QuotesTableOrderingComposer,
          $$QuotesTableAnnotationComposer,
          $$QuotesTableCreateCompanionBuilder,
          $$QuotesTableUpdateCompanionBuilder,
          (QuoteRow, BaseReferences<_$AppDatabase, $QuotesTable, QuoteRow>),
          QuoteRow,
          PrefetchHooks Function()
        > {
  $$QuotesTableTableManager(_$AppDatabase db, $QuotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$QuotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$QuotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<int> isFavorite = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> keyVersion = const Value.absent(),
                Value<String> quoteCipher = const Value.absent(),
                Value<String?> noteCipher = const Value.absent(),
                Value<String> pageNumbersCipher = const Value.absent(),
                Value<String> pagesCipher = const Value.absent(),
                Value<String> wordsCipher = const Value.absent(),
                Value<String> markedWordIndexesCipher = const Value.absent(),
                Value<String?> voiceNoteCipher = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuotesCompanion(
                id: id,
                ownerId: ownerId,
                bookId: bookId,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
                keyVersion: keyVersion,
                quoteCipher: quoteCipher,
                noteCipher: noteCipher,
                pageNumbersCipher: pageNumbersCipher,
                pagesCipher: pagesCipher,
                wordsCipher: wordsCipher,
                markedWordIndexesCipher: markedWordIndexesCipher,
                voiceNoteCipher: voiceNoteCipher,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerId,
                required String bookId,
                required int isFavorite,
                required String createdAt,
                required String updatedAt,
                required int keyVersion,
                required String quoteCipher,
                Value<String?> noteCipher = const Value.absent(),
                required String pageNumbersCipher,
                required String pagesCipher,
                required String wordsCipher,
                required String markedWordIndexesCipher,
                Value<String?> voiceNoteCipher = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuotesCompanion.insert(
                id: id,
                ownerId: ownerId,
                bookId: bookId,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
                keyVersion: keyVersion,
                quoteCipher: quoteCipher,
                noteCipher: noteCipher,
                pageNumbersCipher: pageNumbersCipher,
                pagesCipher: pagesCipher,
                wordsCipher: wordsCipher,
                markedWordIndexesCipher: markedWordIndexesCipher,
                voiceNoteCipher: voiceNoteCipher,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuotesTable,
      QuoteRow,
      $$QuotesTableFilterComposer,
      $$QuotesTableOrderingComposer,
      $$QuotesTableAnnotationComposer,
      $$QuotesTableCreateCompanionBuilder,
      $$QuotesTableUpdateCompanionBuilder,
      (QuoteRow, BaseReferences<_$AppDatabase, $QuotesTable, QuoteRow>),
      QuoteRow,
      PrefetchHooks Function()
    >;
typedef $$ThemesTableCreateCompanionBuilder = ThemesCompanion Function({
  required String id,
  required String ownerId,
  Value<String?> accent,
  Value<String?> symbol,
  required String createdAt,
  required String updatedAt,
  required int keyVersion,
  required String nameCipher,
  Value<int> rowid,
});
typedef $$ThemesTableUpdateCompanionBuilder = ThemesCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<String?> accent,
  Value<String?> symbol,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<int> keyVersion,
  Value<String> nameCipher,
  Value<int> rowid,
});

class $$ThemesTableFilterComposer extends Composer<_$AppDatabase, $ThemesTable> {
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

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
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

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameCipher => $composableBuilder(
    column: $table.nameCipher,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ThemesTableOrderingComposer extends Composer<_$AppDatabase, $ThemesTable> {
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

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
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

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameCipher => $composableBuilder(
    column: $table.nameCipher,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ThemesTableAnnotationComposer extends Composer<_$AppDatabase, $ThemesTable> {
  $$ThemesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get accent =>
      $composableBuilder(column: $table.accent, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameCipher => $composableBuilder(
    column: $table.nameCipher,
    builder: (column) => column,
  );
}

class $$ThemesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ThemesTable,
          ThemeRow,
          $$ThemesTableFilterComposer,
          $$ThemesTableOrderingComposer,
          $$ThemesTableAnnotationComposer,
          $$ThemesTableCreateCompanionBuilder,
          $$ThemesTableUpdateCompanionBuilder,
          (ThemeRow, BaseReferences<_$AppDatabase, $ThemesTable, ThemeRow>),
          ThemeRow,
          PrefetchHooks Function()
        > {
  $$ThemesTableTableManager(_$AppDatabase db, $ThemesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ThemesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ThemesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThemesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String?> accent = const Value.absent(),
                Value<String?> symbol = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> keyVersion = const Value.absent(),
                Value<String> nameCipher = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ThemesCompanion(
                id: id,
                ownerId: ownerId,
                accent: accent,
                symbol: symbol,
                createdAt: createdAt,
                updatedAt: updatedAt,
                keyVersion: keyVersion,
                nameCipher: nameCipher,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerId,
                Value<String?> accent = const Value.absent(),
                Value<String?> symbol = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                required int keyVersion,
                required String nameCipher,
                Value<int> rowid = const Value.absent(),
              }) => ThemesCompanion.insert(
                id: id,
                ownerId: ownerId,
                accent: accent,
                symbol: symbol,
                createdAt: createdAt,
                updatedAt: updatedAt,
                keyVersion: keyVersion,
                nameCipher: nameCipher,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ThemesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ThemesTable,
      ThemeRow,
      $$ThemesTableFilterComposer,
      $$ThemesTableOrderingComposer,
      $$ThemesTableAnnotationComposer,
      $$ThemesTableCreateCompanionBuilder,
      $$ThemesTableUpdateCompanionBuilder,
      (ThemeRow, BaseReferences<_$AppDatabase, $ThemesTable, ThemeRow>),
      ThemeRow,
      PrefetchHooks Function()
    >;
typedef $$ThemeQuotesTableCreateCompanionBuilder = ThemeQuotesCompanion Function({
  required String id,
  required String ownerId,
  required String themeId,
  required String quoteId,
  required String updatedAt,
  Value<int> rowid,
});
typedef $$ThemeQuotesTableUpdateCompanionBuilder = ThemeQuotesCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<String> themeId,
  Value<String> quoteId,
  Value<String> updatedAt,
  Value<int> rowid,
});

class $$ThemeQuotesTableFilterComposer extends Composer<_$AppDatabase, $ThemeQuotesTable> {
  $$ThemeQuotesTableFilterComposer({
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

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeId => $composableBuilder(
    column: $table.themeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quoteId => $composableBuilder(
    column: $table.quoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ThemeQuotesTableOrderingComposer extends Composer<_$AppDatabase, $ThemeQuotesTable> {
  $$ThemeQuotesTableOrderingComposer({
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

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeId => $composableBuilder(
    column: $table.themeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quoteId => $composableBuilder(
    column: $table.quoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ThemeQuotesTableAnnotationComposer extends Composer<_$AppDatabase, $ThemeQuotesTable> {
  $$ThemeQuotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get themeId =>
      $composableBuilder(column: $table.themeId, builder: (column) => column);

  GeneratedColumn<String> get quoteId =>
      $composableBuilder(column: $table.quoteId, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ThemeQuotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ThemeQuotesTable,
          ThemeQuoteRow,
          $$ThemeQuotesTableFilterComposer,
          $$ThemeQuotesTableOrderingComposer,
          $$ThemeQuotesTableAnnotationComposer,
          $$ThemeQuotesTableCreateCompanionBuilder,
          $$ThemeQuotesTableUpdateCompanionBuilder,
          (
            ThemeQuoteRow,
            BaseReferences<_$AppDatabase, $ThemeQuotesTable, ThemeQuoteRow>,
          ),
          ThemeQuoteRow,
          PrefetchHooks Function()
        > {
  $$ThemeQuotesTableTableManager(_$AppDatabase db, $ThemeQuotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ThemeQuotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ThemeQuotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThemeQuotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> themeId = const Value.absent(),
                Value<String> quoteId = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ThemeQuotesCompanion(
                id: id,
                ownerId: ownerId,
                themeId: themeId,
                quoteId: quoteId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerId,
                required String themeId,
                required String quoteId,
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ThemeQuotesCompanion.insert(
                id: id,
                ownerId: ownerId,
                themeId: themeId,
                quoteId: quoteId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ThemeQuotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ThemeQuotesTable,
      ThemeQuoteRow,
      $$ThemeQuotesTableFilterComposer,
      $$ThemeQuotesTableOrderingComposer,
      $$ThemeQuotesTableAnnotationComposer,
      $$ThemeQuotesTableCreateCompanionBuilder,
      $$ThemeQuotesTableUpdateCompanionBuilder,
      (
        ThemeQuoteRow,
        BaseReferences<_$AppDatabase, $ThemeQuotesTable, ThemeQuoteRow>,
      ),
      ThemeQuoteRow,
      PrefetchHooks Function()
    >;
typedef $$ShelvesTableCreateCompanionBuilder = ShelvesCompanion Function({
  required String id,
  required String ownerId,
  Value<String?> accent,
  Value<String?> symbol,
  required String createdAt,
  required String updatedAt,
  required int keyVersion,
  required String nameCipher,
  Value<int> rowid,
});
typedef $$ShelvesTableUpdateCompanionBuilder = ShelvesCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<String?> accent,
  Value<String?> symbol,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<int> keyVersion,
  Value<String> nameCipher,
  Value<int> rowid,
});

class $$ShelvesTableFilterComposer extends Composer<_$AppDatabase, $ShelvesTable> {
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

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
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

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameCipher => $composableBuilder(
    column: $table.nameCipher,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShelvesTableOrderingComposer extends Composer<_$AppDatabase, $ShelvesTable> {
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

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
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

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameCipher => $composableBuilder(
    column: $table.nameCipher,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShelvesTableAnnotationComposer extends Composer<_$AppDatabase, $ShelvesTable> {
  $$ShelvesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get accent =>
      $composableBuilder(column: $table.accent, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameCipher => $composableBuilder(
    column: $table.nameCipher,
    builder: (column) => column,
  );
}

class $$ShelvesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShelvesTable,
          ShelfRow,
          $$ShelvesTableFilterComposer,
          $$ShelvesTableOrderingComposer,
          $$ShelvesTableAnnotationComposer,
          $$ShelvesTableCreateCompanionBuilder,
          $$ShelvesTableUpdateCompanionBuilder,
          (ShelfRow, BaseReferences<_$AppDatabase, $ShelvesTable, ShelfRow>),
          ShelfRow,
          PrefetchHooks Function()
        > {
  $$ShelvesTableTableManager(_$AppDatabase db, $ShelvesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ShelvesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ShelvesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShelvesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String?> accent = const Value.absent(),
                Value<String?> symbol = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> keyVersion = const Value.absent(),
                Value<String> nameCipher = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShelvesCompanion(
                id: id,
                ownerId: ownerId,
                accent: accent,
                symbol: symbol,
                createdAt: createdAt,
                updatedAt: updatedAt,
                keyVersion: keyVersion,
                nameCipher: nameCipher,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerId,
                Value<String?> accent = const Value.absent(),
                Value<String?> symbol = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                required int keyVersion,
                required String nameCipher,
                Value<int> rowid = const Value.absent(),
              }) => ShelvesCompanion.insert(
                id: id,
                ownerId: ownerId,
                accent: accent,
                symbol: symbol,
                createdAt: createdAt,
                updatedAt: updatedAt,
                keyVersion: keyVersion,
                nameCipher: nameCipher,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShelvesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShelvesTable,
      ShelfRow,
      $$ShelvesTableFilterComposer,
      $$ShelvesTableOrderingComposer,
      $$ShelvesTableAnnotationComposer,
      $$ShelvesTableCreateCompanionBuilder,
      $$ShelvesTableUpdateCompanionBuilder,
      (ShelfRow, BaseReferences<_$AppDatabase, $ShelvesTable, ShelfRow>),
      ShelfRow,
      PrefetchHooks Function()
    >;
typedef $$ShelfBooksTableCreateCompanionBuilder = ShelfBooksCompanion Function({
  required String id,
  required String ownerId,
  required String shelfId,
  required String bookId,
  required String updatedAt,
  Value<int> rowid,
});
typedef $$ShelfBooksTableUpdateCompanionBuilder = ShelfBooksCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<String> shelfId,
  Value<String> bookId,
  Value<String> updatedAt,
  Value<int> rowid,
});

class $$ShelfBooksTableFilterComposer extends Composer<_$AppDatabase, $ShelfBooksTable> {
  $$ShelfBooksTableFilterComposer({
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

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shelfId => $composableBuilder(
    column: $table.shelfId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShelfBooksTableOrderingComposer extends Composer<_$AppDatabase, $ShelfBooksTable> {
  $$ShelfBooksTableOrderingComposer({
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

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shelfId => $composableBuilder(
    column: $table.shelfId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShelfBooksTableAnnotationComposer extends Composer<_$AppDatabase, $ShelfBooksTable> {
  $$ShelfBooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get shelfId =>
      $composableBuilder(column: $table.shelfId, builder: (column) => column);

  GeneratedColumn<String> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ShelfBooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShelfBooksTable,
          ShelfBookRow,
          $$ShelfBooksTableFilterComposer,
          $$ShelfBooksTableOrderingComposer,
          $$ShelfBooksTableAnnotationComposer,
          $$ShelfBooksTableCreateCompanionBuilder,
          $$ShelfBooksTableUpdateCompanionBuilder,
          (
            ShelfBookRow,
            BaseReferences<_$AppDatabase, $ShelfBooksTable, ShelfBookRow>,
          ),
          ShelfBookRow,
          PrefetchHooks Function()
        > {
  $$ShelfBooksTableTableManager(_$AppDatabase db, $ShelfBooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ShelfBooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ShelfBooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShelfBooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> shelfId = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShelfBooksCompanion(
                id: id,
                ownerId: ownerId,
                shelfId: shelfId,
                bookId: bookId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerId,
                required String shelfId,
                required String bookId,
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ShelfBooksCompanion.insert(
                id: id,
                ownerId: ownerId,
                shelfId: shelfId,
                bookId: bookId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShelfBooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShelfBooksTable,
      ShelfBookRow,
      $$ShelfBooksTableFilterComposer,
      $$ShelfBooksTableOrderingComposer,
      $$ShelfBooksTableAnnotationComposer,
      $$ShelfBooksTableCreateCompanionBuilder,
      $$ShelfBooksTableUpdateCompanionBuilder,
      (
        ShelfBookRow,
        BaseReferences<_$AppDatabase, $ShelfBooksTable, ShelfBookRow>,
      ),
      ShelfBookRow,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableTableCreateCompanionBuilder = SettingsTableCompanion Function({
  required String id,
  Value<String?> displayName,
  Value<String?> localePreference,
  Value<String?> themePreference,
  Value<String?> contrastPreference,
  Value<int?> backupPromptDismissed,
  Value<int> rowid,
});
typedef $$SettingsTableTableUpdateCompanionBuilder = SettingsTableCompanion Function({
  Value<String> id,
  Value<String?> displayName,
  Value<String?> localePreference,
  Value<String?> themePreference,
  Value<String?> contrastPreference,
  Value<int?> backupPromptDismissed,
  Value<int> rowid,
});

class $$SettingsTableTableFilterComposer extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer({
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

  ColumnFilters<int> get backupPromptDismissed => $composableBuilder(
    column: $table.backupPromptDismissed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableTableOrderingComposer extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer({
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

  ColumnOrderings<int> get backupPromptDismissed => $composableBuilder(
    column: $table.backupPromptDismissed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableTableAnnotationComposer extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
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

  GeneratedColumn<int> get backupPromptDismissed => $composableBuilder(
    column: $table.backupPromptDismissed,
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
          createFilteringComposer: () => $$SettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> localePreference = const Value.absent(),
                Value<String?> themePreference = const Value.absent(),
                Value<String?> contrastPreference = const Value.absent(),
                Value<int?> backupPromptDismissed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsTableCompanion(
                id: id,
                displayName: displayName,
                localePreference: localePreference,
                themePreference: themePreference,
                contrastPreference: contrastPreference,
                backupPromptDismissed: backupPromptDismissed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> displayName = const Value.absent(),
                Value<String?> localePreference = const Value.absent(),
                Value<String?> themePreference = const Value.absent(),
                Value<String?> contrastPreference = const Value.absent(),
                Value<int?> backupPromptDismissed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsTableCompanion.insert(
                id: id,
                displayName: displayName,
                localePreference: localePreference,
                themePreference: themePreference,
                contrastPreference: contrastPreference,
                backupPromptDismissed: backupPromptDismissed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
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
typedef $$AppConfigCacheTableTableCreateCompanionBuilder = AppConfigCacheTableCompanion Function({
  required String id,
  required int version,
  required String fetchedAt,
  required String payload,
  Value<int> rowid,
});
typedef $$AppConfigCacheTableTableUpdateCompanionBuilder = AppConfigCacheTableCompanion Function({
  Value<String> id,
  Value<int> version,
  Value<String> fetchedAt,
  Value<String> payload,
  Value<int> rowid,
});

class $$AppConfigCacheTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppConfigCacheTableTable> {
  $$AppConfigCacheTableTableFilterComposer({
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

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppConfigCacheTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppConfigCacheTableTable> {
  $$AppConfigCacheTableTableOrderingComposer({
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

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppConfigCacheTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppConfigCacheTableTable> {
  $$AppConfigCacheTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);
}

class $$AppConfigCacheTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppConfigCacheTableTable,
          LocalAppConfigCache,
          $$AppConfigCacheTableTableFilterComposer,
          $$AppConfigCacheTableTableOrderingComposer,
          $$AppConfigCacheTableTableAnnotationComposer,
          $$AppConfigCacheTableTableCreateCompanionBuilder,
          $$AppConfigCacheTableTableUpdateCompanionBuilder,
          (
            LocalAppConfigCache,
            BaseReferences<_$AppDatabase, $AppConfigCacheTableTable, LocalAppConfigCache>,
          ),
          LocalAppConfigCache,
          PrefetchHooks Function()
        > {
  $$AppConfigCacheTableTableTableManager(
    _$AppDatabase db,
    $AppConfigCacheTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppConfigCacheTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$AppConfigCacheTableTableOrderingComposer(
            $db: db,
            $table: table,
          ),
          createComputedFieldComposer: () => $$AppConfigCacheTableTableAnnotationComposer(
            $db: db,
            $table: table,
          ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> fetchedAt = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppConfigCacheTableCompanion(
                id: id,
                version: version,
                fetchedAt: fetchedAt,
                payload: payload,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int version,
                required String fetchedAt,
                required String payload,
                Value<int> rowid = const Value.absent(),
              }) => AppConfigCacheTableCompanion.insert(
                id: id,
                version: version,
                fetchedAt: fetchedAt,
                payload: payload,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppConfigCacheTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppConfigCacheTableTable,
      LocalAppConfigCache,
      $$AppConfigCacheTableTableFilterComposer,
      $$AppConfigCacheTableTableOrderingComposer,
      $$AppConfigCacheTableTableAnnotationComposer,
      $$AppConfigCacheTableTableCreateCompanionBuilder,
      $$AppConfigCacheTableTableUpdateCompanionBuilder,
      (
        LocalAppConfigCache,
        BaseReferences<_$AppDatabase, $AppConfigCacheTableTable, LocalAppConfigCache>,
      ),
      LocalAppConfigCache,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BooksTableTableManager get books => $$BooksTableTableManager(_db, _db.books);
  $$QuotesTableTableManager get quotes => $$QuotesTableTableManager(_db, _db.quotes);
  $$ThemesTableTableManager get themes => $$ThemesTableTableManager(_db, _db.themes);
  $$ThemeQuotesTableTableManager get themeQuotes =>
      $$ThemeQuotesTableTableManager(_db, _db.themeQuotes);
  $$ShelvesTableTableManager get shelves => $$ShelvesTableTableManager(_db, _db.shelves);
  $$ShelfBooksTableTableManager get shelfBooks =>
      $$ShelfBooksTableTableManager(_db, _db.shelfBooks);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
  $$AppConfigCacheTableTableTableManager get appConfigCacheTable =>
      $$AppConfigCacheTableTableTableManager(_db, _db.appConfigCacheTable);
}
