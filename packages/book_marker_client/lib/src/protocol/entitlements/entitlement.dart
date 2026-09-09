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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// Per-user plan, account status and cloud-OCR usage.
///
/// Server-owned: the device may only READ this. `SyncEndpoint.upload` rejects
/// any write to it, and the sync stream is one-way in practice.
///
/// Limits are deliberately NOT stored here - they come from app_config.yaml at
/// check time, so changing a limit applies to every existing user at once
/// rather than only to accounts created afterwards.
abstract class Entitlement
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Entitlement._({
    _isc.UuidValue? id,
    required this.ownerId,
    String? plan,
    String? status,
    this.blockedReason,
    this.blockedAt,
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
    required this.updatedAt,
    this.store,
    this.productId,
    this.purchaseToken,
    this.purchasedAt,
    this.refundedAt,
  }) : id = id ?? const _isc.Uuid().v4obj(),
       plan = plan ?? 'free',
       status = status ?? 'active',
       usedDay = usedDay ?? 0,
       usedWeek = usedWeek ?? 0,
       usedMonth = usedMonth ?? 0;

  factory Entitlement({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    String? plan,
    String? status,
    String? blockedReason,
    DateTime? blockedAt,
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
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      plan: jsonSerialization['plan'] as String?,
      status: jsonSerialization['status'] as String?,
      blockedReason: jsonSerialization['blockedReason'] as String?,
      blockedAt: jsonSerialization['blockedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['blockedAt']),
      usedDay: jsonSerialization['usedDay'] as int?,
      usedWeek: jsonSerialization['usedWeek'] as int?,
      usedMonth: jsonSerialization['usedMonth'] as int?,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      store: jsonSerialization['store'] as String?,
      productId: jsonSerialization['productId'] as String?,
      purchaseToken: jsonSerialization['purchaseToken'] as String?,
      purchasedAt: jsonSerialization['purchasedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['purchasedAt'],
            ),
      refundedAt: jsonSerialization['refundedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['refundedAt'],
            ),
    );
  }

  /// UUID, not the default bigint serial: PowerSync requires a text id.
  _isc.UuidValue id;

  _isc.UuidValue ownerId;

  String plan;

  String status;

  String? blockedReason;

  DateTime? blockedAt;

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

  /// Returns a shallow copy of this [Entitlement]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Entitlement copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    String? plan,
    String? status,
    String? blockedReason,
    DateTime? blockedAt,
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
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntitlementImpl extends Entitlement {
  _EntitlementImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    String? plan,
    String? status,
    String? blockedReason,
    DateTime? blockedAt,
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
  @_isc.useResult
  @override
  Entitlement copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    String? plan,
    String? status,
    Object? blockedReason = _Undefined,
    Object? blockedAt = _Undefined,
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
