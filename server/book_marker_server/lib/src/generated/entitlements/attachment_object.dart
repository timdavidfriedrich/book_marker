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

/// One row per stored blob.
///
/// The server cannot read an attachment and cannot infer from a synced row
/// which blobs exist, because every reference to one is inside ciphertext. So
/// it keeps its own index, and that index is what makes two things possible:
/// deleting an account completely, and knowing how much disk an owner is using.
///
/// It leaks a count and a total size, which is the same shape of structural
/// leak the row tables already accept.
///
/// Server-only: never added to the `powersync` publication.
abstract class AttachmentObject
    implements _is.TableRow<_is.UuidValue>, _is.ProtocolSerialization {
  AttachmentObject._({
    _is.UuidValue? id,
    required this.ownerId,
    required this.attachmentId,
    required this.sizeBytes,
    required this.createdAt,
  }) : id = id ?? const _is.Uuid().v4obj();

  factory AttachmentObject({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    required String attachmentId,
    required int sizeBytes,
    required DateTime createdAt,
  }) = _AttachmentObjectImpl;

  factory AttachmentObject.fromJson(Map<String, dynamic> jsonSerialization) {
    return AttachmentObject(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      attachmentId: jsonSerialization['attachmentId'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = AttachmentObjectTable();

  static const db = AttachmentObjectRepository._();

  @override
  _is.UuidValue id;

  _is.UuidValue ownerId;

  String attachmentId;

  int sizeBytes;

  DateTime createdAt;

  @override
  _is.Table<_is.UuidValue> get table => t;

  /// Returns a shallow copy of this [AttachmentObject]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AttachmentObject copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    String? attachmentId,
    int? sizeBytes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AttachmentObject',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'attachmentId': attachmentId,
      'sizeBytes': sizeBytes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AttachmentObject',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'attachmentId': attachmentId,
      'sizeBytes': sizeBytes,
      'createdAt': createdAt.toJson(),
    };
  }

  static AttachmentObjectInclude include() {
    return AttachmentObjectInclude._();
  }

  static AttachmentObjectIncludeList includeList({
    _is.WhereExpressionBuilder<AttachmentObjectTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AttachmentObjectTable>? orderBy,
    _is.OrderByListBuilder<AttachmentObjectTable>? orderByList,
    AttachmentObjectInclude? include,
  }) {
    return AttachmentObjectIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AttachmentObject.t),
      orderByList: orderByList?.call(AttachmentObject.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AttachmentObjectImpl extends AttachmentObject {
  _AttachmentObjectImpl({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    required String attachmentId,
    required int sizeBytes,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         attachmentId: attachmentId,
         sizeBytes: sizeBytes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AttachmentObject]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AttachmentObject copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    String? attachmentId,
    int? sizeBytes,
    DateTime? createdAt,
  }) {
    return AttachmentObject(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      attachmentId: attachmentId ?? this.attachmentId,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AttachmentObjectUpdateTable
    extends _is.UpdateTable<AttachmentObjectTable> {
  AttachmentObjectUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<String, String> attachmentId(String value) => _is.ColumnValue(
    table.attachmentId,
    value,
  );

  _is.ColumnValue<int, int> sizeBytes(int value) => _is.ColumnValue(
    table.sizeBytes,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class AttachmentObjectTable extends _is.Table<_is.UuidValue> {
  AttachmentObjectTable({super.tableRelation})
    : super(tableName: 'attachment_objects') {
    updateTable = AttachmentObjectUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'owner_id',
      this,
      fieldName: 'ownerId',
    );
    attachmentId = _is.ColumnString(
      'attachment_id',
      this,
      fieldName: 'attachmentId',
    );
    sizeBytes = _is.ColumnInt(
      'size_bytes',
      this,
      fieldName: 'sizeBytes',
    );
    createdAt = _is.ColumnDateTime(
      'created_at',
      this,
      fieldName: 'createdAt',
    );
  }

  late final AttachmentObjectUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnString attachmentId;

  late final _is.ColumnInt sizeBytes;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    attachmentId,
    sizeBytes,
    createdAt,
  ];
}

class AttachmentObjectInclude extends _is.IncludeObject {
  AttachmentObjectInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue> get table => AttachmentObject.t;
}

class AttachmentObjectIncludeList extends _is.IncludeList {
  AttachmentObjectIncludeList._({
    _is.WhereExpressionBuilder<AttachmentObjectTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AttachmentObject.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue> get table => AttachmentObject.t;
}

class AttachmentObjectRepository {
  const AttachmentObjectRepository._();

  /// Returns a list of [AttachmentObject]s matching the given query parameters.
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
  Future<List<AttachmentObject>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AttachmentObjectTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AttachmentObjectTable>? orderBy,
    _is.OrderByListBuilder<AttachmentObjectTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AttachmentObject>(
      where: where?.call(AttachmentObject.t),
      orderBy: orderBy?.call(AttachmentObject.t),
      orderByList: orderByList?.call(AttachmentObject.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AttachmentObject] matching the given query parameters.
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
  Future<AttachmentObject?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AttachmentObjectTable>? where,
    int? offset,
    _is.OrderByBuilder<AttachmentObjectTable>? orderBy,
    _is.OrderByListBuilder<AttachmentObjectTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AttachmentObject>(
      where: where?.call(AttachmentObject.t),
      orderBy: orderBy?.call(AttachmentObject.t),
      orderByList: orderByList?.call(AttachmentObject.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AttachmentObject] by its [id] or null if no such row exists.
  Future<AttachmentObject?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AttachmentObject>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AttachmentObject]s in the list and returns the inserted rows.
  ///
  /// The returned [AttachmentObject]s will have their `id` fields set.
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
  Future<List<AttachmentObject>> insert(
    _is.DatabaseSession session,
    List<AttachmentObject> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AttachmentObject>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AttachmentObject] and returns the inserted row.
  ///
  /// The returned [AttachmentObject] will have its `id` field set.
  Future<AttachmentObject> insertRow(
    _is.DatabaseSession session,
    AttachmentObject row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AttachmentObject>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AttachmentObject]s in the list and returns the resulting rows.
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
  /// The returned [AttachmentObject]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AttachmentObject>> upsert(
    _is.DatabaseSession session,
    List<AttachmentObject> rows, {
    required _is.ColumnSelections<AttachmentObjectTable> conflictColumns,
    _is.ColumnSelections<AttachmentObjectTable>? updateColumns,
    _is.WhereExpressionBuilder<AttachmentObjectTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AttachmentObject>(
      rows,
      conflictColumns: conflictColumns(AttachmentObject.t),
      updateColumns: updateColumns?.call(AttachmentObject.t),
      updateWhere: updateWhere?.call(AttachmentObject.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AttachmentObject] and returns the resulting row.
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
  /// The returned [AttachmentObject] will have its `id` field set.
  Future<AttachmentObject?> upsertRow(
    _is.DatabaseSession session,
    AttachmentObject row, {
    required _is.ColumnSelections<AttachmentObjectTable> conflictColumns,
    _is.ColumnSelections<AttachmentObjectTable>? updateColumns,
    _is.WhereExpressionBuilder<AttachmentObjectTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AttachmentObject>(
      row,
      conflictColumns: conflictColumns(AttachmentObject.t),
      updateColumns: updateColumns?.call(AttachmentObject.t),
      updateWhere: updateWhere?.call(AttachmentObject.t),
      transaction: transaction,
    );
  }

  /// Updates all [AttachmentObject]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AttachmentObject>> update(
    _is.DatabaseSession session,
    List<AttachmentObject> rows, {
    _is.ColumnSelections<AttachmentObjectTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AttachmentObject>(
      rows,
      columns: columns?.call(AttachmentObject.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AttachmentObject]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AttachmentObject> updateRow(
    _is.DatabaseSession session,
    AttachmentObject row, {
    _is.ColumnSelections<AttachmentObjectTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AttachmentObject>(
      row,
      columns: columns?.call(AttachmentObject.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AttachmentObject] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AttachmentObject?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<AttachmentObjectUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AttachmentObject>(
      id,
      columnValues: columnValues(AttachmentObject.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AttachmentObject]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AttachmentObject>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AttachmentObjectUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<AttachmentObjectTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AttachmentObjectTable>? orderBy,
    _is.OrderByListBuilder<AttachmentObjectTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AttachmentObject>(
      columnValues: columnValues(AttachmentObject.t.updateTable),
      where: where(AttachmentObject.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AttachmentObject.t),
      orderByList: orderByList?.call(AttachmentObject.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AttachmentObject]s in the list and returns the deleted rows.
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
  Future<List<AttachmentObject>> delete(
    _is.DatabaseSession session,
    List<AttachmentObject> rows, {
    _is.OrderByBuilder<AttachmentObjectTable>? orderBy,
    _is.OrderByListBuilder<AttachmentObjectTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AttachmentObject>(
      rows,
      orderBy: orderBy?.call(AttachmentObject.t),
      orderByList: orderByList?.call(AttachmentObject.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AttachmentObject].
  Future<AttachmentObject> deleteRow(
    _is.DatabaseSession session,
    AttachmentObject row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AttachmentObject>(
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
  Future<List<AttachmentObject>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AttachmentObjectTable> where,
    _is.OrderByBuilder<AttachmentObjectTable>? orderBy,
    _is.OrderByListBuilder<AttachmentObjectTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AttachmentObject>(
      where: where(AttachmentObject.t),
      orderBy: orderBy?.call(AttachmentObject.t),
      orderByList: orderByList?.call(AttachmentObject.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AttachmentObjectTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AttachmentObject>(
      where: where?.call(AttachmentObject.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AttachmentObject] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AttachmentObjectTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AttachmentObject>(
      where: where(AttachmentObject.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
