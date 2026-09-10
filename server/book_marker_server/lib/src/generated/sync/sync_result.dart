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

/// What the server did with a batch.
///
/// `rejected` counts writes that were refused for a reason retrying cannot fix:
/// an unknown table, a column that is not the device's to write, a row that is
/// server owned. They are reported rather than thrown, because a 4xx would
/// block the client's upload queue permanently and every later write with it.
abstract class SyncResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SyncResult._({
    required this.applied,
    required this.rejected,
    this.rejectionReason,
  });

  factory SyncResult({
    required int applied,
    required int rejected,
    String? rejectionReason,
  }) = _SyncResultImpl;

  factory SyncResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncResult(
      applied: jsonSerialization['applied'] as int,
      rejected: jsonSerialization['rejected'] as int,
      rejectionReason: jsonSerialization['rejectionReason'] as String?,
    );
  }

  int applied;

  int rejected;

  String? rejectionReason;

  /// Returns a shallow copy of this [SyncResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SyncResult copyWith({
    int? applied,
    int? rejected,
    String? rejectionReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncResult',
      'applied': applied,
      'rejected': rejected,
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncResult',
      'applied': applied,
      'rejected': rejected,
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SyncResultImpl extends SyncResult {
  _SyncResultImpl({
    required int applied,
    required int rejected,
    String? rejectionReason,
  }) : super._(
         applied: applied,
         rejected: rejected,
         rejectionReason: rejectionReason,
       );

  /// Returns a shallow copy of this [SyncResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SyncResult copyWith({
    int? applied,
    int? rejected,
    Object? rejectionReason = _Undefined,
  }) {
    return SyncResult(
      applied: applied ?? this.applied,
      rejected: rejected ?? this.rejected,
      rejectionReason: rejectionReason is String?
          ? rejectionReason
          : this.rejectionReason,
    );
  }
}
