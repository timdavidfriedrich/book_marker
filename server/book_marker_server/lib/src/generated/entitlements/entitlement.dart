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

/// Per-user plan, account status and cloud-OCR usage.
///
/// Server-owned: the device may only READ this. `SyncEndpoint.upload` rejects
/// any write to it, and the sync stream is one-way in practice.
///
/// Limits are deliberately NOT stored here - they come from app_config.yaml at
/// check time, so changing a limit applies to every existing user at once
/// rather than only to accounts created afterwards.
abstract class Entitlement
    implements _is.TableRow<_is.UuidValue>, _is.ProtocolSerialization {
  Entitlement._({
    _is.UuidValue? id,
    required this.ownerId,
    String? plan,
    String? status,
    this.blockedReason,
    this.blockedAt,
    this.backupVerifier,
    this.backupInitializedAt,
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
    required this.updatedAt,
    this.store,
    this.productId,
    this.purchaseToken,
    this.purchasedAt,
    this.refundedAt,
  }) : id = id ?? const _is.Uuid().v4obj(),
       plan = plan ?? 'free',
       status = status ?? 'active',
       usedDay = usedDay ?? 0,
       usedWeek = usedWeek ?? 0,
       usedMonth = usedMonth ?? 0;

  factory Entitlement({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    String? plan,
    String? status,
    String? blockedReason,
    DateTime? blockedAt,
    String? backupVerifier,
    DateTime? backupInitializedAt,
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
    required DateTime updatedAt,
    String? store,
    String? productId,
    String? purchaseToken,
    DateTime? purchasedAt,
    DateTime? refundedAt,
  }) = _EntitlementImpl;

  factory Entitlement.fromJson(Map<String, dynamic> jsonSerialization) {
    return Entitlement(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      plan: jsonSerialization['plan'] as String?,
      status: jsonSerialization['status'] as String?,
      blockedReason: jsonSerialization['blockedReason'] as String?,
      blockedAt: jsonSerialization['blockedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['blockedAt']),
      backupVerifier: jsonSerialization['backupVerifier'] as String?,
      backupInitializedAt: jsonSerialization['backupInitializedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['backupInitializedAt'],
            ),
      usedDay: jsonSerialization['usedDay'] as int?,
      usedWeek: jsonSerialization['usedWeek'] as int?,
      usedMonth: jsonSerialization['usedMonth'] as int?,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      store: jsonSerialization['store'] as String?,
      productId: jsonSerialization['productId'] as String?,
      purchaseToken: jsonSerialization['purchaseToken'] as String?,
      purchasedAt: jsonSerialization['purchasedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['purchasedAt'],
            ),
      refundedAt: jsonSerialization['refundedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['refundedAt']),
    );
  }

  static final t = EntitlementTable();

  static const db = EntitlementRepository._();

  @override
  _is.UuidValue id;

  _is.UuidValue ownerId;

  String plan;

  String status;

  String? blockedReason;

  DateTime? blockedAt;

  /// A known string encrypted under the master key, written once by the first
  /// device to complete setup and never overwritten. NOT key material: AES-GCM
  /// is secure against a chosen plaintext, so this reveals nothing about a
  /// 128 bit random key, and the server still cannot read a single quote.
  ///
  /// It does two jobs. Non-null answers "does a backup already exist", which is
  /// what stops a keyless device generating a second code and orphaning
  /// everything encrypted under the first. And it lets the device tell a wrong
  /// recovery code from a right one immediately, rather than after a sync round
  /// trip has produced garbage.
  String? backupVerifier;

  /// Diagnostics only, written together with the verifier.
  DateTime? backupInitializedAt;

  int usedDay;

  int usedWeek;

  int usedMonth;

  DateTime updatedAt;

  /// Purchase fields, unused until phase 6. Nullable and present from the start
  /// so enabling purchases is not a migration on a database with real users.
  String? store;

  String? productId;

  String? purchaseToken;

  DateTime? purchasedAt;

  DateTime? refundedAt;

  @override
  _is.Table<_is.UuidValue> get table => t;

  /// Returns a shallow copy of this [Entitlement]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Entitlement copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    String? plan,
    String? status,
    String? blockedReason,
    DateTime? blockedAt,
    String? backupVerifier,
    DateTime? backupInitializedAt,
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
    DateTime? updatedAt,
    String? store,
    String? productId,
    String? purchaseToken,
    DateTime? purchasedAt,
    DateTime? refundedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Entitlement',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'plan': plan,
      'status': status,
      if (blockedReason != null) 'blockedReason': blockedReason,
      if (blockedAt != null) 'blockedAt': blockedAt?.toJson(),
      if (backupVerifier != null) 'backupVerifier': backupVerifier,
      if (backupInitializedAt != null)
        'backupInitializedAt': backupInitializedAt?.toJson(),
      'usedDay': usedDay,
      'usedWeek': usedWeek,
      'usedMonth': usedMonth,
      'updatedAt': updatedAt.toJson(),
      if (store != null) 'store': store,
      if (productId != null) 'productId': productId,
      if (purchaseToken != null) 'purchaseToken': purchaseToken,
      if (purchasedAt != null) 'purchasedAt': purchasedAt?.toJson(),
      if (refundedAt != null) 'refundedAt': refundedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Entitlement',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'plan': plan,
      'status': status,
      if (blockedReason != null) 'blockedReason': blockedReason,
      if (blockedAt != null) 'blockedAt': blockedAt?.toJson(),
      if (backupVerifier != null) 'backupVerifier': backupVerifier,
      if (backupInitializedAt != null)
        'backupInitializedAt': backupInitializedAt?.toJson(),
      'usedDay': usedDay,
      'usedWeek': usedWeek,
      'usedMonth': usedMonth,
      'updatedAt': updatedAt.toJson(),
      if (store != null) 'store': store,
      if (productId != null) 'productId': productId,
      if (purchaseToken != null) 'purchaseToken': purchaseToken,
      if (purchasedAt != null) 'purchasedAt': purchasedAt?.toJson(),
      if (refundedAt != null) 'refundedAt': refundedAt?.toJson(),
    };
  }

  static EntitlementInclude include() {
    return EntitlementInclude._();
  }

  static EntitlementIncludeList includeList({
    _is.WhereExpressionBuilder<EntitlementTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EntitlementTable>? orderBy,
    _is.OrderByListBuilder<EntitlementTable>? orderByList,
    EntitlementInclude? include,
  }) {
    return EntitlementIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Entitlement.t),
      orderByList: orderByList?.call(Entitlement.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntitlementImpl extends Entitlement {
  _EntitlementImpl({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    String? plan,
    String? status,
    String? blockedReason,
    DateTime? blockedAt,
    String? backupVerifier,
    DateTime? backupInitializedAt,
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
    required DateTime updatedAt,
    String? store,
    String? productId,
    String? purchaseToken,
    DateTime? purchasedAt,
    DateTime? refundedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         plan: plan,
         status: status,
         blockedReason: blockedReason,
         blockedAt: blockedAt,
         backupVerifier: backupVerifier,
         backupInitializedAt: backupInitializedAt,
         usedDay: usedDay,
         usedWeek: usedWeek,
         usedMonth: usedMonth,
         updatedAt: updatedAt,
         store: store,
         productId: productId,
         purchaseToken: purchaseToken,
         purchasedAt: purchasedAt,
         refundedAt: refundedAt,
       );

  /// Returns a shallow copy of this [Entitlement]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Entitlement copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    String? plan,
    String? status,
    Object? blockedReason = _Undefined,
    Object? blockedAt = _Undefined,
    Object? backupVerifier = _Undefined,
    Object? backupInitializedAt = _Undefined,
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
    DateTime? updatedAt,
    Object? store = _Undefined,
    Object? productId = _Undefined,
    Object? purchaseToken = _Undefined,
    Object? purchasedAt = _Undefined,
    Object? refundedAt = _Undefined,
  }) {
    return Entitlement(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      plan: plan ?? this.plan,
      status: status ?? this.status,
      blockedReason: blockedReason is String?
          ? blockedReason
          : this.blockedReason,
      blockedAt: blockedAt is DateTime? ? blockedAt : this.blockedAt,
      backupVerifier: backupVerifier is String?
          ? backupVerifier
          : this.backupVerifier,
      backupInitializedAt: backupInitializedAt is DateTime?
          ? backupInitializedAt
          : this.backupInitializedAt,
      usedDay: usedDay ?? this.usedDay,
      usedWeek: usedWeek ?? this.usedWeek,
      usedMonth: usedMonth ?? this.usedMonth,
      updatedAt: updatedAt ?? this.updatedAt,
      store: store is String? ? store : this.store,
      productId: productId is String? ? productId : this.productId,
      purchaseToken: purchaseToken is String?
          ? purchaseToken
          : this.purchaseToken,
      purchasedAt: purchasedAt is DateTime? ? purchasedAt : this.purchasedAt,
      refundedAt: refundedAt is DateTime? ? refundedAt : this.refundedAt,
    );
  }
}

class EntitlementUpdateTable extends _is.UpdateTable<EntitlementTable> {
  EntitlementUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<String, String> plan(String value) => _is.ColumnValue(
    table.plan,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> blockedReason(String? value) =>
      _is.ColumnValue(
        table.blockedReason,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> blockedAt(DateTime? value) =>
      _is.ColumnValue(
        table.blockedAt,
        value,
      );

  _is.ColumnValue<String, String> backupVerifier(String? value) =>
      _is.ColumnValue(
        table.backupVerifier,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> backupInitializedAt(DateTime? value) =>
      _is.ColumnValue(
        table.backupInitializedAt,
        value,
      );

  _is.ColumnValue<int, int> usedDay(int value) => _is.ColumnValue(
    table.usedDay,
    value,
  );

  _is.ColumnValue<int, int> usedWeek(int value) => _is.ColumnValue(
    table.usedWeek,
    value,
  );

  _is.ColumnValue<int, int> usedMonth(int value) => _is.ColumnValue(
    table.usedMonth,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );

  _is.ColumnValue<String, String> store(String? value) => _is.ColumnValue(
    table.store,
    value,
  );

  _is.ColumnValue<String, String> productId(String? value) => _is.ColumnValue(
    table.productId,
    value,
  );

  _is.ColumnValue<String, String> purchaseToken(String? value) =>
      _is.ColumnValue(
        table.purchaseToken,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> purchasedAt(DateTime? value) =>
      _is.ColumnValue(
        table.purchasedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> refundedAt(DateTime? value) =>
      _is.ColumnValue(
        table.refundedAt,
        value,
      );
}

class EntitlementTable extends _is.Table<_is.UuidValue> {
  EntitlementTable({super.tableRelation}) : super(tableName: 'entitlements') {
    updateTable = EntitlementUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'owner_id',
      this,
      fieldName: 'ownerId',
    );
    plan = _is.ColumnString(
      'plan',
      this,
      hasDefault: true,
    );
    status = _is.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    blockedReason = _is.ColumnString(
      'blocked_reason',
      this,
      fieldName: 'blockedReason',
    );
    blockedAt = _is.ColumnDateTime(
      'blocked_at',
      this,
      fieldName: 'blockedAt',
    );
    backupVerifier = _is.ColumnString(
      'backup_verifier',
      this,
      fieldName: 'backupVerifier',
    );
    backupInitializedAt = _is.ColumnDateTime(
      'backup_initialized_at',
      this,
      fieldName: 'backupInitializedAt',
    );
    usedDay = _is.ColumnInt(
      'used_day',
      this,
      hasDefault: true,
      fieldName: 'usedDay',
    );
    usedWeek = _is.ColumnInt(
      'used_week',
      this,
      hasDefault: true,
      fieldName: 'usedWeek',
    );
    usedMonth = _is.ColumnInt(
      'used_month',
      this,
      hasDefault: true,
      fieldName: 'usedMonth',
    );
    updatedAt = _is.ColumnDateTime(
      'updated_at',
      this,
      fieldName: 'updatedAt',
    );
    store = _is.ColumnString(
      'store',
      this,
    );
    productId = _is.ColumnString(
      'product_id',
      this,
      fieldName: 'productId',
    );
    purchaseToken = _is.ColumnString(
      'purchase_token',
      this,
      fieldName: 'purchaseToken',
    );
    purchasedAt = _is.ColumnDateTime(
      'purchased_at',
      this,
      fieldName: 'purchasedAt',
    );
    refundedAt = _is.ColumnDateTime(
      'refunded_at',
      this,
      fieldName: 'refundedAt',
    );
  }

  late final EntitlementUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnString plan;

  late final _is.ColumnString status;

  late final _is.ColumnString blockedReason;

  late final _is.ColumnDateTime blockedAt;

  /// A known string encrypted under the master key, written once by the first
  /// device to complete setup and never overwritten. NOT key material: AES-GCM
  /// is secure against a chosen plaintext, so this reveals nothing about a
  /// 128 bit random key, and the server still cannot read a single quote.
  ///
  /// It does two jobs. Non-null answers "does a backup already exist", which is
  /// what stops a keyless device generating a second code and orphaning
  /// everything encrypted under the first. And it lets the device tell a wrong
  /// recovery code from a right one immediately, rather than after a sync round
  /// trip has produced garbage.
  late final _is.ColumnString backupVerifier;

  /// Diagnostics only, written together with the verifier.
  late final _is.ColumnDateTime backupInitializedAt;

  late final _is.ColumnInt usedDay;

  late final _is.ColumnInt usedWeek;

  late final _is.ColumnInt usedMonth;

  late final _is.ColumnDateTime updatedAt;

  /// Purchase fields, unused until phase 6. Nullable and present from the start
  /// so enabling purchases is not a migration on a database with real users.
  late final _is.ColumnString store;

  late final _is.ColumnString productId;

  late final _is.ColumnString purchaseToken;

  late final _is.ColumnDateTime purchasedAt;

  late final _is.ColumnDateTime refundedAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    plan,
    status,
    blockedReason,
    blockedAt,
    backupVerifier,
    backupInitializedAt,
    usedDay,
    usedWeek,
    usedMonth,
    updatedAt,
    store,
    productId,
    purchaseToken,
    purchasedAt,
    refundedAt,
  ];
}

class EntitlementInclude extends _is.IncludeObject {
  EntitlementInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue> get table => Entitlement.t;
}

class EntitlementIncludeList extends _is.IncludeList {
  EntitlementIncludeList._({
    _is.WhereExpressionBuilder<EntitlementTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Entitlement.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue> get table => Entitlement.t;
}

class EntitlementRepository {
  const EntitlementRepository._();

  /// Returns a list of [Entitlement]s matching the given query parameters.
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
  Future<List<Entitlement>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EntitlementTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EntitlementTable>? orderBy,
    _is.OrderByListBuilder<EntitlementTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Entitlement>(
      where: where?.call(Entitlement.t),
      orderBy: orderBy?.call(Entitlement.t),
      orderByList: orderByList?.call(Entitlement.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Entitlement] matching the given query parameters.
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
  Future<Entitlement?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EntitlementTable>? where,
    int? offset,
    _is.OrderByBuilder<EntitlementTable>? orderBy,
    _is.OrderByListBuilder<EntitlementTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Entitlement>(
      where: where?.call(Entitlement.t),
      orderBy: orderBy?.call(Entitlement.t),
      orderByList: orderByList?.call(Entitlement.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Entitlement] by its [id] or null if no such row exists.
  Future<Entitlement?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Entitlement>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Entitlement]s in the list and returns the inserted rows.
  ///
  /// The returned [Entitlement]s will have their `id` fields set.
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
  Future<List<Entitlement>> insert(
    _is.DatabaseSession session,
    List<Entitlement> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Entitlement>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Entitlement] and returns the inserted row.
  ///
  /// The returned [Entitlement] will have its `id` field set.
  Future<Entitlement> insertRow(
    _is.DatabaseSession session,
    Entitlement row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Entitlement>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Entitlement]s in the list and returns the resulting rows.
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
  /// The returned [Entitlement]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Entitlement>> upsert(
    _is.DatabaseSession session,
    List<Entitlement> rows, {
    required _is.ColumnSelections<EntitlementTable> conflictColumns,
    _is.ColumnSelections<EntitlementTable>? updateColumns,
    _is.WhereExpressionBuilder<EntitlementTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Entitlement>(
      rows,
      conflictColumns: conflictColumns(Entitlement.t),
      updateColumns: updateColumns?.call(Entitlement.t),
      updateWhere: updateWhere?.call(Entitlement.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Entitlement] and returns the resulting row.
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
  /// The returned [Entitlement] will have its `id` field set.
  Future<Entitlement?> upsertRow(
    _is.DatabaseSession session,
    Entitlement row, {
    required _is.ColumnSelections<EntitlementTable> conflictColumns,
    _is.ColumnSelections<EntitlementTable>? updateColumns,
    _is.WhereExpressionBuilder<EntitlementTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Entitlement>(
      row,
      conflictColumns: conflictColumns(Entitlement.t),
      updateColumns: updateColumns?.call(Entitlement.t),
      updateWhere: updateWhere?.call(Entitlement.t),
      transaction: transaction,
    );
  }

  /// Updates all [Entitlement]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Entitlement>> update(
    _is.DatabaseSession session,
    List<Entitlement> rows, {
    _is.ColumnSelections<EntitlementTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Entitlement>(
      rows,
      columns: columns?.call(Entitlement.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Entitlement]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Entitlement> updateRow(
    _is.DatabaseSession session,
    Entitlement row, {
    _is.ColumnSelections<EntitlementTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Entitlement>(
      row,
      columns: columns?.call(Entitlement.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Entitlement] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Entitlement?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<EntitlementUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Entitlement>(
      id,
      columnValues: columnValues(Entitlement.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Entitlement]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Entitlement>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EntitlementUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<EntitlementTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EntitlementTable>? orderBy,
    _is.OrderByListBuilder<EntitlementTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Entitlement>(
      columnValues: columnValues(Entitlement.t.updateTable),
      where: where(Entitlement.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Entitlement.t),
      orderByList: orderByList?.call(Entitlement.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Entitlement]s in the list and returns the deleted rows.
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
  Future<List<Entitlement>> delete(
    _is.DatabaseSession session,
    List<Entitlement> rows, {
    _is.OrderByBuilder<EntitlementTable>? orderBy,
    _is.OrderByListBuilder<EntitlementTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Entitlement>(
      rows,
      orderBy: orderBy?.call(Entitlement.t),
      orderByList: orderByList?.call(Entitlement.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Entitlement].
  Future<Entitlement> deleteRow(
    _is.DatabaseSession session,
    Entitlement row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Entitlement>(
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
  Future<List<Entitlement>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EntitlementTable> where,
    _is.OrderByBuilder<EntitlementTable>? orderBy,
    _is.OrderByListBuilder<EntitlementTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Entitlement>(
      where: where(Entitlement.t),
      orderBy: orderBy?.call(Entitlement.t),
      orderByList: orderByList?.call(Entitlement.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EntitlementTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Entitlement>(
      where: where?.call(Entitlement.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Entitlement] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EntitlementTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Entitlement>(
      where: where(Entitlement.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
