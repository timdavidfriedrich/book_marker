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

/// Temporary table used to verify the PowerSync replication path end to end.
/// Delete this together with its sync stream once the real synced tables land
/// in phase 4.
abstract class SyncProbe
    implements _is.TableRow<_is.UuidValue>, _is.ProtocolSerialization {
  SyncProbe._({
    _is.UuidValue? id,
    required this.ownerId,
    required this.note,
    required this.updatedAt,
  }) : id = id ?? const _is.Uuid().v4obj();

  factory SyncProbe({
    _is.UuidValue? id,
    required String ownerId,
    required String note,
    required DateTime updatedAt,
  }) = _SyncProbeImpl;

  factory SyncProbe.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncProbe(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: jsonSerialization['ownerId'] as String,
      note: jsonSerialization['note'] as String,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = SyncProbeTable();

  static const db = SyncProbeRepository._();

  @override
  _is.UuidValue id;

  String ownerId;

  String note;

  DateTime updatedAt;

  @override
  _is.Table<_is.UuidValue> get table => t;

  /// Returns a shallow copy of this [SyncProbe]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SyncProbe copyWith({
    _is.UuidValue? id,
    String? ownerId,
    String? note,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncProbe',
      'id': id.toJson(),
      'ownerId': ownerId,
      'note': note,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncProbe',
      'id': id.toJson(),
      'ownerId': ownerId,
      'note': note,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SyncProbeInclude include() {
    return SyncProbeInclude._();
  }

  static SyncProbeIncludeList includeList({
    _is.WhereExpressionBuilder<SyncProbeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncProbeTable>? orderBy,
    _is.OrderByListBuilder<SyncProbeTable>? orderByList,
    SyncProbeInclude? include,
  }) {
    return SyncProbeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyncProbe.t),
      orderByList: orderByList?.call(SyncProbe.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _SyncProbeImpl extends SyncProbe {
  _SyncProbeImpl({
    _is.UuidValue? id,
    required String ownerId,
    required String note,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         note: note,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SyncProbe]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SyncProbe copyWith({
    _is.UuidValue? id,
    String? ownerId,
    String? note,
    DateTime? updatedAt,
  }) {
    return SyncProbe(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      note: note ?? this.note,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SyncProbeUpdateTable extends _is.UpdateTable<SyncProbeTable> {
  SyncProbeUpdateTable(super.table);

  _is.ColumnValue<String, String> ownerId(String value) => _is.ColumnValue(
    table.ownerId,
    value,
  );

  _is.ColumnValue<String, String> note(String value) => _is.ColumnValue(
    table.note,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class SyncProbeTable extends _is.Table<_is.UuidValue> {
  SyncProbeTable({super.tableRelation}) : super(tableName: 'sync_probes') {
    updateTable = SyncProbeUpdateTable(this);
    ownerId = _is.ColumnString(
      'ownerId',
      this,
    );
    note = _is.ColumnString(
      'note',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final SyncProbeUpdateTable updateTable;

  late final _is.ColumnString ownerId;

  late final _is.ColumnString note;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    note,
    updatedAt,
  ];
}

class SyncProbeInclude extends _is.IncludeObject {
  SyncProbeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue> get table => SyncProbe.t;
}

class SyncProbeIncludeList extends _is.IncludeList {
  SyncProbeIncludeList._({
    _is.WhereExpressionBuilder<SyncProbeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SyncProbe.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue> get table => SyncProbe.t;
}

class SyncProbeRepository {
  const SyncProbeRepository._();

  /// Returns a list of [SyncProbe]s matching the given query parameters.
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
  Future<List<SyncProbe>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncProbeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncProbeTable>? orderBy,
    _is.OrderByListBuilder<SyncProbeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SyncProbe>(
      where: where?.call(SyncProbe.t),
      orderBy: orderBy?.call(SyncProbe.t),
      orderByList: orderByList?.call(SyncProbe.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SyncProbe] matching the given query parameters.
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
  Future<SyncProbe?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncProbeTable>? where,
    int? offset,
    _is.OrderByBuilder<SyncProbeTable>? orderBy,
    _is.OrderByListBuilder<SyncProbeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SyncProbe>(
      where: where?.call(SyncProbe.t),
      orderBy: orderBy?.call(SyncProbe.t),
      orderByList: orderByList?.call(SyncProbe.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SyncProbe] by its [id] or null if no such row exists.
  Future<SyncProbe?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SyncProbe>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SyncProbe]s in the list and returns the inserted rows.
  ///
  /// The returned [SyncProbe]s will have their `id` fields set.
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
  Future<List<SyncProbe>> insert(
    _is.DatabaseSession session,
    List<SyncProbe> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SyncProbe>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SyncProbe] and returns the inserted row.
  ///
  /// The returned [SyncProbe] will have its `id` field set.
  Future<SyncProbe> insertRow(
    _is.DatabaseSession session,
    SyncProbe row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SyncProbe>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SyncProbe]s in the list and returns the resulting rows.
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
  /// The returned [SyncProbe]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncProbe>> upsert(
    _is.DatabaseSession session,
    List<SyncProbe> rows, {
    required _is.ColumnSelections<SyncProbeTable> conflictColumns,
    _is.ColumnSelections<SyncProbeTable>? updateColumns,
    _is.WhereExpressionBuilder<SyncProbeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SyncProbe>(
      rows,
      conflictColumns: conflictColumns(SyncProbe.t),
      updateColumns: updateColumns?.call(SyncProbe.t),
      updateWhere: updateWhere?.call(SyncProbe.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SyncProbe] and returns the resulting row.
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
  /// The returned [SyncProbe] will have its `id` field set.
  Future<SyncProbe?> upsertRow(
    _is.DatabaseSession session,
    SyncProbe row, {
    required _is.ColumnSelections<SyncProbeTable> conflictColumns,
    _is.ColumnSelections<SyncProbeTable>? updateColumns,
    _is.WhereExpressionBuilder<SyncProbeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SyncProbe>(
      row,
      conflictColumns: conflictColumns(SyncProbe.t),
      updateColumns: updateColumns?.call(SyncProbe.t),
      updateWhere: updateWhere?.call(SyncProbe.t),
      transaction: transaction,
    );
  }

  /// Updates all [SyncProbe]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncProbe>> update(
    _is.DatabaseSession session,
    List<SyncProbe> rows, {
    _is.ColumnSelections<SyncProbeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SyncProbe>(
      rows,
      columns: columns?.call(SyncProbe.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SyncProbe]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SyncProbe> updateRow(
    _is.DatabaseSession session,
    SyncProbe row, {
    _is.ColumnSelections<SyncProbeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SyncProbe>(
      row,
      columns: columns?.call(SyncProbe.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SyncProbe] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SyncProbe?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<SyncProbeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SyncProbe>(
      id,
      columnValues: columnValues(SyncProbe.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SyncProbe]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyncProbe>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SyncProbeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SyncProbeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyncProbeTable>? orderBy,
    _is.OrderByListBuilder<SyncProbeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SyncProbe>(
      columnValues: columnValues(SyncProbe.t.updateTable),
      where: where(SyncProbe.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyncProbe.t),
      orderByList: orderByList?.call(SyncProbe.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SyncProbe]s in the list and returns the deleted rows.
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
  Future<List<SyncProbe>> delete(
    _is.DatabaseSession session,
    List<SyncProbe> rows, {
    _is.OrderByBuilder<SyncProbeTable>? orderBy,
    _is.OrderByListBuilder<SyncProbeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SyncProbe>(
      rows,
      orderBy: orderBy?.call(SyncProbe.t),
      orderByList: orderByList?.call(SyncProbe.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SyncProbe].
  Future<SyncProbe> deleteRow(
    _is.DatabaseSession session,
    SyncProbe row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SyncProbe>(
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
  Future<List<SyncProbe>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyncProbeTable> where,
    _is.OrderByBuilder<SyncProbeTable>? orderBy,
    _is.OrderByListBuilder<SyncProbeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SyncProbe>(
      where: where(SyncProbe.t),
      orderBy: orderBy?.call(SyncProbe.t),
      orderByList: orderByList?.call(SyncProbe.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyncProbeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SyncProbe>(
      where: where?.call(SyncProbe.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SyncProbe] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyncProbeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SyncProbe>(
      where: where(SyncProbe.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
