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

/// What the device is allowed to know about its own entitlement.
///
/// A narrower shape than the `entitlements` row on purpose: the purchase
/// columns are bookkeeping the client has no use for. This is also the read
/// path that works BEFORE PowerSync connects, which matters because the master
/// key has to be resolved first and sync cannot help with that.
abstract class EntitlementView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EntitlementView._({
    required this.plan,
    required this.status,
    this.blockedReason,
    this.backupVerifier,
    required this.usedDay,
    required this.usedWeek,
    required this.usedMonth,
  });

  factory EntitlementView({
    required String plan,
    required String status,
    String? blockedReason,
    String? backupVerifier,
    required int usedDay,
    required int usedWeek,
    required int usedMonth,
  }) = _EntitlementViewImpl;

  factory EntitlementView.fromJson(Map<String, dynamic> jsonSerialization) {
    return EntitlementView(
      plan: jsonSerialization['plan'] as String,
      status: jsonSerialization['status'] as String,
      blockedReason: jsonSerialization['blockedReason'] as String?,
      backupVerifier: jsonSerialization['backupVerifier'] as String?,
      usedDay: jsonSerialization['usedDay'] as int,
      usedWeek: jsonSerialization['usedWeek'] as int,
      usedMonth: jsonSerialization['usedMonth'] as int,
    );
  }

  String plan;

  String status;

  String? blockedReason;

  /// Null means no backup exists yet, so this device should generate a code
  /// rather than ask for one. See entitlement.spy.yaml for why handing it out
  /// is safe.
  String? backupVerifier;

  int usedDay;

  int usedWeek;

  int usedMonth;

  /// Returns a shallow copy of this [EntitlementView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EntitlementView copyWith({
    String? plan,
    String? status,
    String? blockedReason,
    String? backupVerifier,
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EntitlementView',
      'plan': plan,
      'status': status,
      if (blockedReason != null) 'blockedReason': blockedReason,
      if (backupVerifier != null) 'backupVerifier': backupVerifier,
      'usedDay': usedDay,
      'usedWeek': usedWeek,
      'usedMonth': usedMonth,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EntitlementView',
      'plan': plan,
      'status': status,
      if (blockedReason != null) 'blockedReason': blockedReason,
      if (backupVerifier != null) 'backupVerifier': backupVerifier,
      'usedDay': usedDay,
      'usedWeek': usedWeek,
      'usedMonth': usedMonth,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntitlementViewImpl extends EntitlementView {
  _EntitlementViewImpl({
    required String plan,
    required String status,
    String? blockedReason,
    String? backupVerifier,
    required int usedDay,
    required int usedWeek,
    required int usedMonth,
  }) : super._(
         plan: plan,
         status: status,
         blockedReason: blockedReason,
         backupVerifier: backupVerifier,
         usedDay: usedDay,
         usedWeek: usedWeek,
         usedMonth: usedMonth,
       );

  /// Returns a shallow copy of this [EntitlementView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EntitlementView copyWith({
    String? plan,
    String? status,
    Object? blockedReason = _Undefined,
    Object? backupVerifier = _Undefined,
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
  }) {
    return EntitlementView(
      plan: plan ?? this.plan,
      status: status ?? this.status,
      blockedReason: blockedReason is String?
          ? blockedReason
          : this.blockedReason,
      backupVerifier: backupVerifier is String?
          ? backupVerifier
          : this.backupVerifier,
      usedDay: usedDay ?? this.usedDay,
      usedWeek: usedWeek ?? this.usedWeek,
      usedMonth: usedMonth ?? this.usedMonth,
    );
  }
}
