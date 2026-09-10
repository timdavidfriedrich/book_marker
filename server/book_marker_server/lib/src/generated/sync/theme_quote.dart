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

/// Which quotes belong to which theme. Same reasoning as shelf_books.
abstract class SyncedThemeQuote
    implements _is.TableRow<_is.UuidValue>, _is.ProtocolSerialization {
  SyncedThemeQuote._({
    _is.UuidValue? id,
    required this.ownerId,
    required this.themeId,
    required this.quoteId,
    required this.updatedAt,
  }) : id = id ?? const _is.Uuid().v4obj();

  factory SyncedThemeQuote({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    required _is.UuidValue themeId,
    required _is.UuidValue quoteId,
    required DateTime updatedAt,
  }) = _SyncedThemeQuoteImpl;

  factory SyncedThemeQuote.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncedThemeQuote(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      themeId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['themeId'],
      ),
      quoteId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['quoteId'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = SyncedThemeQuoteTable();

  static const db = SyncedThemeQuoteRepository._();

  @override
  _is.UuidValue id;

  _is.UuidValue ownerId;

  _is.UuidValue themeId;

  _is.UuidValue quoteId;

  DateTime updatedAt;

  @override
  _is.Table<_is.UuidValue> get table => t;

  /// Returns a shallow copy of this [SyncedThemeQuote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SyncedThemeQuote copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    _is.UuidValue? themeId,
    _is.UuidValue? quoteId,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncedThemeQuote',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'themeId': themeId.toJson(),
      'quoteId': quoteId.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncedThemeQuote',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'themeId': themeId.toJson(),
      'quoteId': quoteId.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SyncedThemeQuoteInclude include() {
    return SyncedThemeQuoteInclude._();
  }

  static SyncedThemeQuoteIncludeList includeList({
    _is.WhereExpressionBuilder<SyncedThemeQuoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedThemeQuoteTable>? orderBy,
    _is.OrderByListBuilder<SyncedThemeQuoteTable>? orderByList,
    SyncedThemeQuoteInclude? include,
  }) {
    return SyncedThemeQuoteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyncedThemeQuote.t),
      orderByList: orderByList?.call(SyncedThemeQuote.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _SyncedThemeQuoteImpl extends SyncedThemeQuote {
  _SyncedThemeQuoteImpl({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    required _is.UuidValue themeId,
    required _is.UuidValue quoteId,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         themeId: themeId,
         quoteId: quoteId,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SyncedThemeQuote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SyncedThemeQuote copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    _is.UuidValue? themeId,
    _is.UuidValue? quoteId,
    DateTime? updatedAt,
  }) {
    return SyncedThemeQuote(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      themeId: themeId ?? this.themeId,
      quoteId: quoteId ?? this.quoteId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SyncedThemeQuoteUpdateTable
    extends _is.UpdateTable<SyncedThemeQuoteTable> {
  SyncedThemeQuoteUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> themeId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.themeId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> quoteId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.quoteId,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class SyncedThemeQuoteTable extends _is.Table<_is.UuidValue> {
  SyncedThemeQuoteTable({super.tableRelation})
    : super(tableName: 'theme_quotes') {
    updateTable = SyncedThemeQuoteUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'owner_id',
      this,
      fieldName: 'ownerId',
    );
    themeId = _is.ColumnUuid(
      'theme_id',
      this,
      fieldName: 'themeId',
    );
    quoteId = _is.ColumnUuid(
      'quote_id',
      this,
      fieldName: 'quoteId',
    );
    updatedAt = _is.ColumnDateTime(
      'updated_at',
      this,
      fieldName: 'updatedAt',
    );
  }

  late final SyncedThemeQuoteUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnUuid themeId;

  late final _is.ColumnUuid quoteId;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    themeId,
    quoteId,
    updatedAt,
  ];
}

class SyncedThemeQuoteInclude extends _is.IncludeObject {
  SyncedThemeQuoteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue> get table => SyncedThemeQuote.t;
}

class SyncedThemeQuoteIncludeList extends _is.IncludeList {
  SyncedThemeQuoteIncludeList._({
    _is.WhereExpressionBuilder<SyncedThemeQuoteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SyncedThemeQuote.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue> get table => SyncedThemeQuote.t;
}

class SyncedThemeQuoteRepository {
  const SyncedThemeQuoteRepository._();

  /// Returns a list of [SyncedThemeQuote]s matching the given query parameters.
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
  Future<List<SyncedThemeQuote>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedThemeQuoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedThemeQuoteTable>? orderBy,
    _is.OrderByListBuilder<SyncedThemeQuoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SyncedThemeQuote>(
      where: where?.call(SyncedThemeQuote.t),
      orderBy: orderBy?.call(SyncedThemeQuote.t),
      orderByList: orderByList?.call(SyncedThemeQuote.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SyncedThemeQuote] matching the given query parameters.
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
  Future<SyncedThemeQuote?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedThemeQuoteTable>? where,
    int? offset,
    _is.OrderByBuilder<SyncedThemeQuoteTable>? orderBy,
    _is.OrderByListBuilder<SyncedThemeQuoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SyncedThemeQuote>(
      where: where?.call(SyncedThemeQuote.t),
      orderBy: orderBy?.call(SyncedThemeQuote.t),
      orderByList: orderByList?.call(SyncedThemeQuote.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SyncedThemeQuote] by its [id] or null if no such row exists.
  Future<SyncedThemeQuote?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SyncedThemeQuote>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SyncedThemeQuote]s in the list and returns the inserted rows.
  ///
  /// The returned [SyncedThemeQuote]s will have their `id` fields set.
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
  Future<List<SyncedThemeQuote>> insert(
    _is.DatabaseSession session,
    List<SyncedThemeQuote> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SyncedThemeQuote>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SyncedThemeQuote] and returns the inserted row.
  ///
  /// The returned [SyncedThemeQuote] will have its `id` field set.
  Future<SyncedThemeQuote> insertRow(
    _is.DatabaseSession session,
    SyncedThemeQuote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SyncedThemeQuote>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SyncedThemeQuote]s in the list and returns the resulting rows.
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
  /// The returned [SyncedThemeQuote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedThemeQuote>> upsert(
    _is.DatabaseSession session,
    List<SyncedThemeQuote> rows, {
    required _is.ColumnSelections<SyncedThemeQuoteTable> conflictColumns,
    _is.ColumnSelections<SyncedThemeQuoteTable>? updateColumns,
    _is.WhereExpressionBuilder<SyncedThemeQuoteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SyncedThemeQuote>(
      rows,
      conflictColumns: conflictColumns(SyncedThemeQuote.t),
      updateColumns: updateColumns?.call(SyncedThemeQuote.t),
      updateWhere: updateWhere?.call(SyncedThemeQuote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SyncedThemeQuote] and returns the resulting row.
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
  /// The returned [SyncedThemeQuote] will have its `id` field set.
  Future<SyncedThemeQuote?> upsertRow(
    _is.DatabaseSession session,
    SyncedThemeQuote row, {
    required _is.ColumnSelections<SyncedThemeQuoteTable> conflictColumns,
    _is.ColumnSelections<SyncedThemeQuoteTable>? updateColumns,
    _is.WhereExpressionBuilder<SyncedThemeQuoteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SyncedThemeQuote>(
      row,
      conflictColumns: conflictColumns(SyncedThemeQuote.t),
      updateColumns: updateColumns?.call(SyncedThemeQuote.t),
      updateWhere: updateWhere?.call(SyncedThemeQuote.t),
      transaction: transaction,
    );
  }

  /// Updates all [SyncedThemeQuote]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedThemeQuote>> update(
    _is.DatabaseSession session,
    List<SyncedThemeQuote> rows, {
    _is.ColumnSelections<SyncedThemeQuoteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SyncedThemeQuote>(
      rows,
      columns: columns?.call(SyncedThemeQuote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SyncedThemeQuote]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SyncedThemeQuote> updateRow(
    _is.DatabaseSession session,
    SyncedThemeQuote row, {
    _is.ColumnSelections<SyncedThemeQuoteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SyncedThemeQuote>(
      row,
      columns: columns?.call(SyncedThemeQuote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SyncedThemeQuote] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SyncedThemeQuote?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<SyncedThemeQuoteUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SyncedThemeQuote>(
      id,
      columnValues: columnValues(SyncedThemeQuote.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SyncedThemeQuote]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncedThemeQuote>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SyncedThemeQuoteUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SyncedThemeQuoteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncedThemeQuoteTable>? orderBy,
    _is.OrderByListBuilder<SyncedThemeQuoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SyncedThemeQuote>(
      columnValues: columnValues(SyncedThemeQuote.t.updateTable),
      where: where(SyncedThemeQuote.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyncedThemeQuote.t),
      orderByList: orderByList?.call(SyncedThemeQuote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SyncedThemeQuote]s in the list and returns the deleted rows.
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
  Future<List<SyncedThemeQuote>> delete(
    _is.DatabaseSession session,
    List<SyncedThemeQuote> rows, {
    _is.OrderByBuilder<SyncedThemeQuoteTable>? orderBy,
    _is.OrderByListBuilder<SyncedThemeQuoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SyncedThemeQuote>(
      rows,
      orderBy: orderBy?.call(SyncedThemeQuote.t),
      orderByList: orderByList?.call(SyncedThemeQuote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SyncedThemeQuote].
  Future<SyncedThemeQuote> deleteRow(
    _is.DatabaseSession session,
    SyncedThemeQuote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SyncedThemeQuote>(
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
  Future<List<SyncedThemeQuote>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyncedThemeQuoteTable> where,
    _is.OrderByBuilder<SyncedThemeQuoteTable>? orderBy,
    _is.OrderByListBuilder<SyncedThemeQuoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SyncedThemeQuote>(
      where: where(SyncedThemeQuote.t),
      orderBy: orderBy?.call(SyncedThemeQuote.t),
      orderByList: orderByList?.call(SyncedThemeQuote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncedThemeQuoteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SyncedThemeQuote>(
      where: where?.call(SyncedThemeQuote.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SyncedThemeQuote] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyncedThemeQuoteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SyncedThemeQuote>(
      where: where(SyncedThemeQuote.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
