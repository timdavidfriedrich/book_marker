/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

/// A quote. Every word of it is ciphertext, including the page numbers and the
/// recognised word boxes, which would otherwise leak the shape of the text.
///
/// There is deliberately NO foreign key to books. PowerSync replicates rows
/// independently and a batch can carry a quote whose book the server has not
/// seen yet; a constraint would reject the write instead of storing an opaque
/// string. Referential integrity is kept on the device, where the cascades are.
abstract class SyncedQuote
    implements _is.TableRow<_is.UuidValue>, _is.ProtocolSerialization {
  SyncedQuote._({
    _is.UuidValue? id,
    required this.ownerId,
    required this.bookId,
    bool? isFavorite,
    required this.createdAt,
    required this.updatedAt,
    int? keyVersion,
    required this.quoteCipher,
    this.noteCipher,
    required this.pageNumbersCipher,
    required this.pagesCipher,
    required this.wordsCipher,
    required this.markedWordIndexesCipher,
    this.voiceNoteCipher,
  }) : id = id ?? const _is.Uuid().v4obj(),
       isFavorite = isFavorite ?? false,
       keyVersion = keyVersion ?? 1;

  factory SyncedQuote({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    required _is.UuidValue bookId,
    bool? isFavorite,
    required DateTime createdAt,
    required DateTime updatedAt,
    int? keyVersion,
    required String quoteCipher,
    String? noteCipher,
    required String pageNumbersCipher,
    required String pagesCipher,
    required String wordsCipher,
    required String markedWordIndexesCipher,
    String? voiceNoteCipher,
  }) = _SyncedQuoteImpl;

  factory SyncedQuote.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncedQuote(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      bookId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['bookId']),
      isFavorite: jsonSerialization['isFavorite'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isFavorite']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      keyVersion: jsonSerialization['keyVersion'] as int?,
      quoteCipher: jsonSerialization['quoteCipher'] as String,
      noteCipher: jsonSerialization['noteCipher'] as String?,
      pageNumbersCipher: jsonSerialization['pageNumbersCipher'] as String,
      pagesCipher: jsonSerialization['pagesCipher'] as String,
      wordsCipher: jsonSerialization['wordsCipher'] as String,
      markedWordIndexesCipher:
          jsonSerialization['markedWordIndexesCipher'] as String,
      voiceNoteCipher: jsonSerialization['voiceNoteCipher'] as String?,
    );
  }

  static final t = SyncedQuoteTable();

  static const db = SyncedQuoteRepository._();

  @override
  _is.UuidValue id;

  _is.UuidValue ownerId;

  _is.UuidValue bookId;

  bool isFavorite;

  DateTime createdAt;

  DateTime updatedAt;

  int keyVersion;

  String quoteCipher;

  String? noteCipher;

  String pageNumbersCipher;

  String pagesCipher;

  String wordsCipher;

  String markedWordIndexesCipher;

  /// Duration and the id of the local recording, encrypted together.
  String? voiceNoteCipher;

  @override
  _is.Table<_is.UuidValue> get table => t;

  /// Returns a shallow copy of this [SyncedQuote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SyncedQuote copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    _is.UuidValue? bookId,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? keyVersion,
    String? quoteCipher,
    String? noteCipher,
    String? pageNumbersCipher,
    String? pagesCipher,
    String? wordsCipher,
    String? markedWordIndexesCipher,
    String? voiceNoteCipher,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncedQuote',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'bookId': bookId.toJson(),
      'isFavorite': isFavorite,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'keyVersion': keyVersion,
      'quoteCipher': quoteCipher,
      if (noteCipher != null) 'noteCipher': noteCipher,
      'pageNumbersCipher': pageNumbersCipher,
      'pagesCipher': pagesCipher,
      'wordsCipher': wordsCipher,
      'markedWordIndexesCipher': markedWordIndexesCipher,
      if (voiceNoteCipher != null) 'voiceNoteCipher': voiceNoteCipher,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncedQuote',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'bookId': bookId.toJson(),
      'isFavorite': isFavorite,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'keyVersion': keyVersion,
      'quoteCipher': quoteCipher,
      if (noteCipher != null) 'noteCipher': noteCipher,
      'pageNumbersCipher': pageNumbersCipher,
      'pagesCipher': pagesCipher,
      'wordsCipher': wordsCipher,
      'markedWordIndexesCipher': markedWordIndexesCipher,
      if (voiceNoteCipher != null) 'voiceNoteCipher': voiceNoteCipher,
    };
  }

  static SyncedQuoteInclude include() {
    return SyncedQuoteInclude._();
  }

  static SyncedQuoteIncludeList includeList({
    _is.WhereExpressionBuilder<SyncedQuoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedQuoteTable>? orderBy,
    _is.OrderByListBuilder<SyncedQuoteTable>? orderByList,
    SyncedQuoteInclude? include,
  }) {
    return SyncedQuoteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyncedQuote.t),
      orderByList: orderByList?.call(SyncedQuote.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SyncedQuoteImpl extends SyncedQuote {
  _SyncedQuoteImpl({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    required _is.UuidValue bookId,
    bool? isFavorite,
    required DateTime createdAt,
    required DateTime updatedAt,
    int? keyVersion,
    required String quoteCipher,
    String? noteCipher,
    required String pageNumbersCipher,
    required String pagesCipher,
    required String wordsCipher,
    required String markedWordIndexesCipher,
    String? voiceNoteCipher,
  }) : super._(
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
       );

  /// Returns a shallow copy of this [SyncedQuote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SyncedQuote copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    _is.UuidValue? bookId,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? keyVersion,
    String? quoteCipher,
    Object? noteCipher = _Undefined,
    String? pageNumbersCipher,
    String? pagesCipher,
    String? wordsCipher,
    String? markedWordIndexesCipher,
    Object? voiceNoteCipher = _Undefined,
  }) {
    return SyncedQuote(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      bookId: bookId ?? this.bookId,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      keyVersion: keyVersion ?? this.keyVersion,
      quoteCipher: quoteCipher ?? this.quoteCipher,
      noteCipher: noteCipher is String? ? noteCipher : this.noteCipher,
      pageNumbersCipher: pageNumbersCipher ?? this.pageNumbersCipher,
      pagesCipher: pagesCipher ?? this.pagesCipher,
      wordsCipher: wordsCipher ?? this.wordsCipher,
      markedWordIndexesCipher:
          markedWordIndexesCipher ?? this.markedWordIndexesCipher,
      voiceNoteCipher: voiceNoteCipher is String?
          ? voiceNoteCipher
          : this.voiceNoteCipher,
    );
  }
}

class SyncedQuoteUpdateTable extends _is.UpdateTable<SyncedQuoteTable> {
  SyncedQuoteUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> bookId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.bookId,
        value,
      );

  _is.ColumnValue<bool, bool> isFavorite(bool value) => _is.ColumnValue(
    table.isFavorite,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );

  _is.ColumnValue<int, int> keyVersion(int value) => _is.ColumnValue(
    table.keyVersion,
    value,
  );

  _is.ColumnValue<String, String> quoteCipher(String value) => _is.ColumnValue(
    table.quoteCipher,
    value,
  );

  _is.ColumnValue<String, String> noteCipher(String? value) => _is.ColumnValue(
    table.noteCipher,
    value,
  );

  _is.ColumnValue<String, String> pageNumbersCipher(String value) =>
      _is.ColumnValue(
        table.pageNumbersCipher,
        value,
      );

  _is.ColumnValue<String, String> pagesCipher(String value) => _is.ColumnValue(
    table.pagesCipher,
    value,
  );

  _is.ColumnValue<String, String> wordsCipher(String value) => _is.ColumnValue(
    table.wordsCipher,
    value,
  );

  _is.ColumnValue<String, String> markedWordIndexesCipher(String value) =>
      _is.ColumnValue(
        table.markedWordIndexesCipher,
        value,
      );

  _is.ColumnValue<String, String> voiceNoteCipher(String? value) =>
      _is.ColumnValue(
        table.voiceNoteCipher,
        value,
      );
}

class SyncedQuoteTable extends _is.Table<_is.UuidValue> {
  SyncedQuoteTable({super.tableRelation}) : super(tableName: 'quotes') {
    updateTable = SyncedQuoteUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'owner_id',
      this,
      fieldName: 'ownerId',
    );
    bookId = _is.ColumnUuid(
      'book_id',
      this,
      fieldName: 'bookId',
    );
    isFavorite = _is.ColumnBool(
      'is_favorite',
      this,
      hasDefault: true,
      fieldName: 'isFavorite',
    );
    createdAt = _is.ColumnDateTime(
      'created_at',
      this,
      fieldName: 'createdAt',
    );
    updatedAt = _is.ColumnDateTime(
      'updated_at',
      this,
      fieldName: 'updatedAt',
    );
    keyVersion = _is.ColumnInt(
      'key_version',
      this,
      hasDefault: true,
      fieldName: 'keyVersion',
    );
    quoteCipher = _is.ColumnString(
      'quote_cipher',
      this,
      fieldName: 'quoteCipher',
    );
    noteCipher = _is.ColumnString(
      'note_cipher',
      this,
      fieldName: 'noteCipher',
    );
    pageNumbersCipher = _is.ColumnString(
      'page_numbers_cipher',
      this,
      fieldName: 'pageNumbersCipher',
    );
    pagesCipher = _is.ColumnString(
      'pages_cipher',
      this,
      fieldName: 'pagesCipher',
    );
    wordsCipher = _is.ColumnString(
      'words_cipher',
      this,
      fieldName: 'wordsCipher',
    );
    markedWordIndexesCipher = _is.ColumnString(
      'marked_word_indexes_cipher',
      this,
      fieldName: 'markedWordIndexesCipher',
    );
    voiceNoteCipher = _is.ColumnString(
      'voice_note_cipher',
      this,
      fieldName: 'voiceNoteCipher',
    );
  }

  late final SyncedQuoteUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnUuid bookId;

  late final _is.ColumnBool isFavorite;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnInt keyVersion;

  late final _is.ColumnString quoteCipher;

  late final _is.ColumnString noteCipher;

  late final _is.ColumnString pageNumbersCipher;

  late final _is.ColumnString pagesCipher;

  late final _is.ColumnString wordsCipher;

  late final _is.ColumnString markedWordIndexesCipher;

  /// Duration and the id of the local recording, encrypted together.
  late final _is.ColumnString voiceNoteCipher;

  @override
  List<_is.Column> get columns => [
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
}

class SyncedQuoteInclude extends _is.IncludeObject {
  SyncedQuoteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue> get table => SyncedQuote.t;
}

class SyncedQuoteIncludeList extends _is.IncludeList {
  SyncedQuoteIncludeList._({
    _is.WhereExpressionBuilder<SyncedQuoteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SyncedQuote.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue> get table => SyncedQuote.t;
}

class SyncedQuoteRepository {
  const SyncedQuoteRepository._();

  /// Returns a list of [SyncedQuote]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<SyncedQuote>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedQuoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedQuoteTable>? orderBy,
    _is.OrderByListBuilder<SyncedQuoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SyncedQuote>(
      where: where?.call(SyncedQuote.t),
      orderBy: orderBy?.call(SyncedQuote.t),
      orderByList: orderByList?.call(SyncedQuote.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SyncedQuote] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<SyncedQuote?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedQuoteTable>? where,
    int? offset,
    _is.OrderByBuilder<SyncedQuoteTable>? orderBy,
    _is.OrderByListBuilder<SyncedQuoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SyncedQuote>(
      where: where?.call(SyncedQuote.t),
      orderBy: orderBy?.call(SyncedQuote.t),
      orderByList: orderByList?.call(SyncedQuote.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SyncedQuote] by its [id] or null if no such row exists.
  Future<SyncedQuote?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SyncedQuote>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SyncedQuote]s in the list and returns the inserted rows.
  ///
  /// The returned [SyncedQuote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedQuote>> insert(
    _is.DatabaseSession session,
    List<SyncedQuote> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SyncedQuote>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SyncedQuote] and returns the inserted row.
  ///
  /// The returned [SyncedQuote] will have its `id` field set.
  Future<SyncedQuote> insertRow(
    _is.DatabaseSession session,
    SyncedQuote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SyncedQuote>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SyncedQuote]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [SyncedQuote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedQuote>> upsert(
    _is.DatabaseSession session,
    List<SyncedQuote> rows, {
    required _is.ColumnSelections<SyncedQuoteTable> conflictColumns,
    _is.ColumnSelections<SyncedQuoteTable>? updateColumns,
    _is.WhereExpressionBuilder<SyncedQuoteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SyncedQuote>(
      rows,
      conflictColumns: conflictColumns(SyncedQuote.t),
      updateColumns: updateColumns?.call(SyncedQuote.t),
      updateWhere: updateWhere?.call(SyncedQuote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SyncedQuote] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [SyncedQuote] will have its `id` field set.
  Future<SyncedQuote?> upsertRow(
    _is.DatabaseSession session,
    SyncedQuote row, {
    required _is.ColumnSelections<SyncedQuoteTable> conflictColumns,
    _is.ColumnSelections<SyncedQuoteTable>? updateColumns,
    _is.WhereExpressionBuilder<SyncedQuoteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SyncedQuote>(
      row,
      conflictColumns: conflictColumns(SyncedQuote.t),
      updateColumns: updateColumns?.call(SyncedQuote.t),
      updateWhere: updateWhere?.call(SyncedQuote.t),
      transaction: transaction,
    );
  }

  /// Updates all [SyncedQuote]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedQuote>> update(
    _is.DatabaseSession session,
    List<SyncedQuote> rows, {
    _is.ColumnSelections<SyncedQuoteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SyncedQuote>(
      rows,
      columns: columns?.call(SyncedQuote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SyncedQuote]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SyncedQuote> updateRow(
    _is.DatabaseSession session,
    SyncedQuote row, {
    _is.ColumnSelections<SyncedQuoteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SyncedQuote>(
      row,
      columns: columns?.call(SyncedQuote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SyncedQuote] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SyncedQuote?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<SyncedQuoteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SyncedQuote>(
      id,
      columnValues: columnValues(SyncedQuote.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SyncedQuote]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedQuote>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SyncedQuoteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SyncedQuoteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedQuoteTable>? orderBy,
    _is.OrderByListBuilder<SyncedQuoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SyncedQuote>(
      columnValues: columnValues(SyncedQuote.t.updateTable),
      where: where(SyncedQuote.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyncedQuote.t),
      orderByList: orderByList?.call(SyncedQuote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SyncedQuote]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedQuote>> delete(
    _is.DatabaseSession session,
    List<SyncedQuote> rows, {
    _is.OrderByBuilder<SyncedQuoteTable>? orderBy,
    _is.OrderByListBuilder<SyncedQuoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SyncedQuote>(
      rows,
      orderBy: orderBy?.call(SyncedQuote.t),
      orderByList: orderByList?.call(SyncedQuote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SyncedQuote].
  Future<SyncedQuote> deleteRow(
    _is.DatabaseSession session,
    SyncedQuote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SyncedQuote>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedQuote>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyncedQuoteTable> where,
    _is.OrderByBuilder<SyncedQuoteTable>? orderBy,
    _is.OrderByListBuilder<SyncedQuoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SyncedQuote>(
      where: where(SyncedQuote.t),
      orderBy: orderBy?.call(SyncedQuote.t),
      orderByList: orderByList?.call(SyncedQuote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedQuoteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SyncedQuote>(
      where: where?.call(SyncedQuote.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SyncedQuote] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyncedQuoteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SyncedQuote>(
      where: where(SyncedQuote.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
