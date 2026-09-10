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

/// A book, as the server stores it: structure in the clear, content encrypted.
///
/// `status`, `createdAt` and `lastUsedAt` stay plaintext so PowerSync can bucket
/// by owner and Drift can order in SQL. Everything a person wrote or looked up
/// is ciphertext the server has no key for.
///
/// Column names are snake_case via `column=`, not Serverpod's default camelCase.
/// The sync stream SQL, the PowerSync client schema and Drift's default column
/// naming all use snake_case, and one convention across the three is worth more
/// than matching the Dart field names.
abstract class SyncedBook
    implements _is.TableRow<_is.UuidValue>, _is.ProtocolSerialization {
  SyncedBook._({
    _is.UuidValue? id,
    required this.ownerId,
    required this.status,
    required this.createdAt,
    required this.lastUsedAt,
    required this.updatedAt,
    int? keyVersion,
    required this.titleCipher,
    required this.authorsCipher,
    this.isbnCipher,
    this.coverCipher,
  }) : id = id ?? const _is.Uuid().v4obj(),
       keyVersion = keyVersion ?? 1;

  factory SyncedBook({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    required String status,
    required DateTime createdAt,
    required DateTime lastUsedAt,
    required DateTime updatedAt,
    int? keyVersion,
    required String titleCipher,
    required String authorsCipher,
    String? isbnCipher,
    String? coverCipher,
  }) = _SyncedBookImpl;

  factory SyncedBook.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncedBook(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      status: jsonSerialization['status'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      lastUsedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastUsedAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      keyVersion: jsonSerialization['keyVersion'] as int?,
      titleCipher: jsonSerialization['titleCipher'] as String,
      authorsCipher: jsonSerialization['authorsCipher'] as String,
      isbnCipher: jsonSerialization['isbnCipher'] as String?,
      coverCipher: jsonSerialization['coverCipher'] as String?,
    );
  }

  static final t = SyncedBookTable();

  static const db = SyncedBookRepository._();

  @override
  _is.UuidValue id;

  _is.UuidValue ownerId;

  String status;

  DateTime createdAt;

  DateTime lastUsedAt;

  DateTime updatedAt;

  /// Which key encrypted this row. Present from the start so re-encryption is a
  /// migration rather than a rewrite.
  int keyVersion;

  String titleCipher;

  String authorsCipher;

  String? isbnCipher;

  /// Cover URL and the id of the local cover file, encrypted together. The
  /// attachment itself does not exist until phase 7.
  String? coverCipher;

  @override
  _is.Table<_is.UuidValue> get table => t;

  /// Returns a shallow copy of this [SyncedBook]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SyncedBook copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    String? status,
    DateTime? createdAt,
    DateTime? lastUsedAt,
    DateTime? updatedAt,
    int? keyVersion,
    String? titleCipher,
    String? authorsCipher,
    String? isbnCipher,
    String? coverCipher,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncedBook',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'status': status,
      'createdAt': createdAt.toJson(),
      'lastUsedAt': lastUsedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'keyVersion': keyVersion,
      'titleCipher': titleCipher,
      'authorsCipher': authorsCipher,
      if (isbnCipher != null) 'isbnCipher': isbnCipher,
      if (coverCipher != null) 'coverCipher': coverCipher,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncedBook',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'status': status,
      'createdAt': createdAt.toJson(),
      'lastUsedAt': lastUsedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'keyVersion': keyVersion,
      'titleCipher': titleCipher,
      'authorsCipher': authorsCipher,
      if (isbnCipher != null) 'isbnCipher': isbnCipher,
      if (coverCipher != null) 'coverCipher': coverCipher,
    };
  }

  static SyncedBookInclude include() {
    return SyncedBookInclude._();
  }

  static SyncedBookIncludeList includeList({
    _is.WhereExpressionBuilder<SyncedBookTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedBookTable>? orderBy,
    _is.OrderByListBuilder<SyncedBookTable>? orderByList,
    SyncedBookInclude? include,
  }) {
    return SyncedBookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyncedBook.t),
      orderByList: orderByList?.call(SyncedBook.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SyncedBookImpl extends SyncedBook {
  _SyncedBookImpl({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    required String status,
    required DateTime createdAt,
    required DateTime lastUsedAt,
    required DateTime updatedAt,
    int? keyVersion,
    required String titleCipher,
    required String authorsCipher,
    String? isbnCipher,
    String? coverCipher,
  }) : super._(
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
       );

  /// Returns a shallow copy of this [SyncedBook]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SyncedBook copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    String? status,
    DateTime? createdAt,
    DateTime? lastUsedAt,
    DateTime? updatedAt,
    int? keyVersion,
    String? titleCipher,
    String? authorsCipher,
    Object? isbnCipher = _Undefined,
    Object? coverCipher = _Undefined,
  }) {
    return SyncedBook(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      keyVersion: keyVersion ?? this.keyVersion,
      titleCipher: titleCipher ?? this.titleCipher,
      authorsCipher: authorsCipher ?? this.authorsCipher,
      isbnCipher: isbnCipher is String? ? isbnCipher : this.isbnCipher,
      coverCipher: coverCipher is String? ? coverCipher : this.coverCipher,
    );
  }
}

class SyncedBookUpdateTable extends _is.UpdateTable<SyncedBookTable> {
  SyncedBookUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastUsedAt(DateTime value) =>
      _is.ColumnValue(
        table.lastUsedAt,
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

  _is.ColumnValue<String, String> titleCipher(String value) => _is.ColumnValue(
    table.titleCipher,
    value,
  );

  _is.ColumnValue<String, String> authorsCipher(String value) =>
      _is.ColumnValue(
        table.authorsCipher,
        value,
      );

  _is.ColumnValue<String, String> isbnCipher(String? value) => _is.ColumnValue(
    table.isbnCipher,
    value,
  );

  _is.ColumnValue<String, String> coverCipher(String? value) => _is.ColumnValue(
    table.coverCipher,
    value,
  );
}

class SyncedBookTable extends _is.Table<_is.UuidValue> {
  SyncedBookTable({super.tableRelation}) : super(tableName: 'books') {
    updateTable = SyncedBookUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'owner_id',
      this,
      fieldName: 'ownerId',
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'created_at',
      this,
      fieldName: 'createdAt',
    );
    lastUsedAt = _is.ColumnDateTime(
      'last_used_at',
      this,
      fieldName: 'lastUsedAt',
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
    titleCipher = _is.ColumnString(
      'title_cipher',
      this,
      fieldName: 'titleCipher',
    );
    authorsCipher = _is.ColumnString(
      'authors_cipher',
      this,
      fieldName: 'authorsCipher',
    );
    isbnCipher = _is.ColumnString(
      'isbn_cipher',
      this,
      fieldName: 'isbnCipher',
    );
    coverCipher = _is.ColumnString(
      'cover_cipher',
      this,
      fieldName: 'coverCipher',
    );
  }

  late final SyncedBookUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime lastUsedAt;

  late final _is.ColumnDateTime updatedAt;

  /// Which key encrypted this row. Present from the start so re-encryption is a
  /// migration rather than a rewrite.
  late final _is.ColumnInt keyVersion;

  late final _is.ColumnString titleCipher;

  late final _is.ColumnString authorsCipher;

  late final _is.ColumnString isbnCipher;

  /// Cover URL and the id of the local cover file, encrypted together. The
  /// attachment itself does not exist until phase 7.
  late final _is.ColumnString coverCipher;

  @override
  List<_is.Column> get columns => [
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
}

class SyncedBookInclude extends _is.IncludeObject {
  SyncedBookInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue> get table => SyncedBook.t;
}

class SyncedBookIncludeList extends _is.IncludeList {
  SyncedBookIncludeList._({
    _is.WhereExpressionBuilder<SyncedBookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SyncedBook.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue> get table => SyncedBook.t;
}

class SyncedBookRepository {
  const SyncedBookRepository._();

  /// Returns a list of [SyncedBook]s matching the given query parameters.
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
  Future<List<SyncedBook>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedBookTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedBookTable>? orderBy,
    _is.OrderByListBuilder<SyncedBookTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SyncedBook>(
      where: where?.call(SyncedBook.t),
      orderBy: orderBy?.call(SyncedBook.t),
      orderByList: orderByList?.call(SyncedBook.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SyncedBook] matching the given query parameters.
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
  Future<SyncedBook?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedBookTable>? where,
    int? offset,
    _is.OrderByBuilder<SyncedBookTable>? orderBy,
    _is.OrderByListBuilder<SyncedBookTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SyncedBook>(
      where: where?.call(SyncedBook.t),
      orderBy: orderBy?.call(SyncedBook.t),
      orderByList: orderByList?.call(SyncedBook.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SyncedBook] by its [id] or null if no such row exists.
  Future<SyncedBook?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SyncedBook>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SyncedBook]s in the list and returns the inserted rows.
  ///
  /// The returned [SyncedBook]s will have their `id` fields set.
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
  Future<List<SyncedBook>> insert(
    _is.DatabaseSession session,
    List<SyncedBook> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SyncedBook>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SyncedBook] and returns the inserted row.
  ///
  /// The returned [SyncedBook] will have its `id` field set.
  Future<SyncedBook> insertRow(
    _is.DatabaseSession session,
    SyncedBook row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SyncedBook>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SyncedBook]s in the list and returns the resulting rows.
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
  /// The returned [SyncedBook]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedBook>> upsert(
    _is.DatabaseSession session,
    List<SyncedBook> rows, {
    required _is.ColumnSelections<SyncedBookTable> conflictColumns,
    _is.ColumnSelections<SyncedBookTable>? updateColumns,
    _is.WhereExpressionBuilder<SyncedBookTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SyncedBook>(
      rows,
      conflictColumns: conflictColumns(SyncedBook.t),
      updateColumns: updateColumns?.call(SyncedBook.t),
      updateWhere: updateWhere?.call(SyncedBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SyncedBook] and returns the resulting row.
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
  /// The returned [SyncedBook] will have its `id` field set.
  Future<SyncedBook?> upsertRow(
    _is.DatabaseSession session,
    SyncedBook row, {
    required _is.ColumnSelections<SyncedBookTable> conflictColumns,
    _is.ColumnSelections<SyncedBookTable>? updateColumns,
    _is.WhereExpressionBuilder<SyncedBookTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SyncedBook>(
      row,
      conflictColumns: conflictColumns(SyncedBook.t),
      updateColumns: updateColumns?.call(SyncedBook.t),
      updateWhere: updateWhere?.call(SyncedBook.t),
      transaction: transaction,
    );
  }

  /// Updates all [SyncedBook]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedBook>> update(
    _is.DatabaseSession session,
    List<SyncedBook> rows, {
    _is.ColumnSelections<SyncedBookTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SyncedBook>(
      rows,
      columns: columns?.call(SyncedBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SyncedBook]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SyncedBook> updateRow(
    _is.DatabaseSession session,
    SyncedBook row, {
    _is.ColumnSelections<SyncedBookTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SyncedBook>(
      row,
      columns: columns?.call(SyncedBook.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SyncedBook] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SyncedBook?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<SyncedBookUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SyncedBook>(
      id,
      columnValues: columnValues(SyncedBook.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SyncedBook]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedBook>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SyncedBookUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SyncedBookTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedBookTable>? orderBy,
    _is.OrderByListBuilder<SyncedBookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SyncedBook>(
      columnValues: columnValues(SyncedBook.t.updateTable),
      where: where(SyncedBook.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyncedBook.t),
      orderByList: orderByList?.call(SyncedBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SyncedBook]s in the list and returns the deleted rows.
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
  Future<List<SyncedBook>> delete(
    _is.DatabaseSession session,
    List<SyncedBook> rows, {
    _is.OrderByBuilder<SyncedBookTable>? orderBy,
    _is.OrderByListBuilder<SyncedBookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SyncedBook>(
      rows,
      orderBy: orderBy?.call(SyncedBook.t),
      orderByList: orderByList?.call(SyncedBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SyncedBook].
  Future<SyncedBook> deleteRow(
    _is.DatabaseSession session,
    SyncedBook row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SyncedBook>(
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
  Future<List<SyncedBook>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyncedBookTable> where,
    _is.OrderByBuilder<SyncedBookTable>? orderBy,
    _is.OrderByListBuilder<SyncedBookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SyncedBook>(
      where: where(SyncedBook.t),
      orderBy: orderBy?.call(SyncedBook.t),
      orderByList: orderByList?.call(SyncedBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedBookTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SyncedBook>(
      where: where?.call(SyncedBook.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SyncedBook] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyncedBookTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SyncedBook>(
      where: where(SyncedBook.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
