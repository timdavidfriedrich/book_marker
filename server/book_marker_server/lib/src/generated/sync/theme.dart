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

/// A theme. Same shape as a shelf: the name is content, the rest is
/// presentation.
abstract class SyncedTheme
    implements _is.TableRow<_is.UuidValue>, _is.ProtocolSerialization {
  SyncedTheme._({
    _is.UuidValue? id,
    required this.ownerId,
    this.accent,
    this.symbol,
    required this.createdAt,
    required this.updatedAt,
    int? keyVersion,
    required this.nameCipher,
  }) : id = id ?? const _is.Uuid().v4obj(),
       keyVersion = keyVersion ?? 1;

  factory SyncedTheme({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    String? accent,
    String? symbol,
    required DateTime createdAt,
    required DateTime updatedAt,
    int? keyVersion,
    required String nameCipher,
  }) = _SyncedThemeImpl;

  factory SyncedTheme.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncedTheme(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      accent: jsonSerialization['accent'] as String?,
      symbol: jsonSerialization['symbol'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      keyVersion: jsonSerialization['keyVersion'] as int?,
      nameCipher: jsonSerialization['nameCipher'] as String,
    );
  }

  static final t = SyncedThemeTable();

  static const db = SyncedThemeRepository._();

  @override
  _is.UuidValue id;

  _is.UuidValue ownerId;

  String? accent;

  String? symbol;

  DateTime createdAt;

  DateTime updatedAt;

  int keyVersion;

  String nameCipher;

  @override
  _is.Table<_is.UuidValue> get table => t;

  /// Returns a shallow copy of this [SyncedTheme]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SyncedTheme copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    String? accent,
    String? symbol,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? keyVersion,
    String? nameCipher,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncedTheme',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      if (accent != null) 'accent': accent,
      if (symbol != null) 'symbol': symbol,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'keyVersion': keyVersion,
      'nameCipher': nameCipher,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncedTheme',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      if (accent != null) 'accent': accent,
      if (symbol != null) 'symbol': symbol,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'keyVersion': keyVersion,
      'nameCipher': nameCipher,
    };
  }

  static SyncedThemeInclude include() {
    return SyncedThemeInclude._();
  }

  static SyncedThemeIncludeList includeList({
    _is.WhereExpressionBuilder<SyncedThemeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedThemeTable>? orderBy,
    _is.OrderByListBuilder<SyncedThemeTable>? orderByList,
    SyncedThemeInclude? include,
  }) {
    return SyncedThemeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyncedTheme.t),
      orderByList: orderByList?.call(SyncedTheme.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SyncedThemeImpl extends SyncedTheme {
  _SyncedThemeImpl({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    String? accent,
    String? symbol,
    required DateTime createdAt,
    required DateTime updatedAt,
    int? keyVersion,
    required String nameCipher,
  }) : super._(
         id: id,
         ownerId: ownerId,
         accent: accent,
         symbol: symbol,
         createdAt: createdAt,
         updatedAt: updatedAt,
         keyVersion: keyVersion,
         nameCipher: nameCipher,
       );

  /// Returns a shallow copy of this [SyncedTheme]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SyncedTheme copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    Object? accent = _Undefined,
    Object? symbol = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? keyVersion,
    String? nameCipher,
  }) {
    return SyncedTheme(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      accent: accent is String? ? accent : this.accent,
      symbol: symbol is String? ? symbol : this.symbol,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      keyVersion: keyVersion ?? this.keyVersion,
      nameCipher: nameCipher ?? this.nameCipher,
    );
  }
}

class SyncedThemeUpdateTable extends _is.UpdateTable<SyncedThemeTable> {
  SyncedThemeUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<String, String> accent(String? value) => _is.ColumnValue(
    table.accent,
    value,
  );

  _is.ColumnValue<String, String> symbol(String? value) => _is.ColumnValue(
    table.symbol,
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

  _is.ColumnValue<String, String> nameCipher(String value) => _is.ColumnValue(
    table.nameCipher,
    value,
  );
}

class SyncedThemeTable extends _is.Table<_is.UuidValue> {
  SyncedThemeTable({super.tableRelation}) : super(tableName: 'themes') {
    updateTable = SyncedThemeUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'owner_id',
      this,
      fieldName: 'ownerId',
    );
    accent = _is.ColumnString(
      'accent',
      this,
    );
    symbol = _is.ColumnString(
      'symbol',
      this,
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
    nameCipher = _is.ColumnString(
      'name_cipher',
      this,
      fieldName: 'nameCipher',
    );
  }

  late final SyncedThemeUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnString accent;

  late final _is.ColumnString symbol;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnInt keyVersion;

  late final _is.ColumnString nameCipher;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    accent,
    symbol,
    createdAt,
    updatedAt,
    keyVersion,
    nameCipher,
  ];
}

class SyncedThemeInclude extends _is.IncludeObject {
  SyncedThemeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue> get table => SyncedTheme.t;
}

class SyncedThemeIncludeList extends _is.IncludeList {
  SyncedThemeIncludeList._({
    _is.WhereExpressionBuilder<SyncedThemeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SyncedTheme.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue> get table => SyncedTheme.t;
}

class SyncedThemeRepository {
  const SyncedThemeRepository._();

  /// Returns a list of [SyncedTheme]s matching the given query parameters.
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
  Future<List<SyncedTheme>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedThemeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedThemeTable>? orderBy,
    _is.OrderByListBuilder<SyncedThemeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SyncedTheme>(
      where: where?.call(SyncedTheme.t),
      orderBy: orderBy?.call(SyncedTheme.t),
      orderByList: orderByList?.call(SyncedTheme.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SyncedTheme] matching the given query parameters.
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
  Future<SyncedTheme?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedThemeTable>? where,
    int? offset,
    _is.OrderByBuilder<SyncedThemeTable>? orderBy,
    _is.OrderByListBuilder<SyncedThemeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SyncedTheme>(
      where: where?.call(SyncedTheme.t),
      orderBy: orderBy?.call(SyncedTheme.t),
      orderByList: orderByList?.call(SyncedTheme.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SyncedTheme] by its [id] or null if no such row exists.
  Future<SyncedTheme?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SyncedTheme>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SyncedTheme]s in the list and returns the inserted rows.
  ///
  /// The returned [SyncedTheme]s will have their `id` fields set.
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
  Future<List<SyncedTheme>> insert(
    _is.DatabaseSession session,
    List<SyncedTheme> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SyncedTheme>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SyncedTheme] and returns the inserted row.
  ///
  /// The returned [SyncedTheme] will have its `id` field set.
  Future<SyncedTheme> insertRow(
    _is.DatabaseSession session,
    SyncedTheme row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SyncedTheme>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SyncedTheme]s in the list and returns the resulting rows.
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
  /// The returned [SyncedTheme]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedTheme>> upsert(
    _is.DatabaseSession session,
    List<SyncedTheme> rows, {
    required _is.ColumnSelections<SyncedThemeTable> conflictColumns,
    _is.ColumnSelections<SyncedThemeTable>? updateColumns,
    _is.WhereExpressionBuilder<SyncedThemeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SyncedTheme>(
      rows,
      conflictColumns: conflictColumns(SyncedTheme.t),
      updateColumns: updateColumns?.call(SyncedTheme.t),
      updateWhere: updateWhere?.call(SyncedTheme.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SyncedTheme] and returns the resulting row.
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
  /// The returned [SyncedTheme] will have its `id` field set.
  Future<SyncedTheme?> upsertRow(
    _is.DatabaseSession session,
    SyncedTheme row, {
    required _is.ColumnSelections<SyncedThemeTable> conflictColumns,
    _is.ColumnSelections<SyncedThemeTable>? updateColumns,
    _is.WhereExpressionBuilder<SyncedThemeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SyncedTheme>(
      row,
      conflictColumns: conflictColumns(SyncedTheme.t),
      updateColumns: updateColumns?.call(SyncedTheme.t),
      updateWhere: updateWhere?.call(SyncedTheme.t),
      transaction: transaction,
    );
  }

  /// Updates all [SyncedTheme]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedTheme>> update(
    _is.DatabaseSession session,
    List<SyncedTheme> rows, {
    _is.ColumnSelections<SyncedThemeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SyncedTheme>(
      rows,
      columns: columns?.call(SyncedTheme.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SyncedTheme]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SyncedTheme> updateRow(
    _is.DatabaseSession session,
    SyncedTheme row, {
    _is.ColumnSelections<SyncedThemeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SyncedTheme>(
      row,
      columns: columns?.call(SyncedTheme.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SyncedTheme] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SyncedTheme?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<SyncedThemeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SyncedTheme>(
      id,
      columnValues: columnValues(SyncedTheme.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SyncedTheme]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedTheme>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SyncedThemeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SyncedThemeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedThemeTable>? orderBy,
    _is.OrderByListBuilder<SyncedThemeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SyncedTheme>(
      columnValues: columnValues(SyncedTheme.t.updateTable),
      where: where(SyncedTheme.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyncedTheme.t),
      orderByList: orderByList?.call(SyncedTheme.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SyncedTheme]s in the list and returns the deleted rows.
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
  Future<List<SyncedTheme>> delete(
    _is.DatabaseSession session,
    List<SyncedTheme> rows, {
    _is.OrderByBuilder<SyncedThemeTable>? orderBy,
    _is.OrderByListBuilder<SyncedThemeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SyncedTheme>(
      rows,
      orderBy: orderBy?.call(SyncedTheme.t),
      orderByList: orderByList?.call(SyncedTheme.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SyncedTheme].
  Future<SyncedTheme> deleteRow(
    _is.DatabaseSession session,
    SyncedTheme row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SyncedTheme>(
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
  Future<List<SyncedTheme>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyncedThemeTable> where,
    _is.OrderByBuilder<SyncedThemeTable>? orderBy,
    _is.OrderByListBuilder<SyncedThemeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SyncedTheme>(
      where: where(SyncedTheme.t),
      orderBy: orderBy?.call(SyncedTheme.t),
      orderByList: orderByList?.call(SyncedTheme.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedThemeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SyncedTheme>(
      where: where?.call(SyncedTheme.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SyncedTheme] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyncedThemeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SyncedTheme>(
      where: where(SyncedTheme.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
