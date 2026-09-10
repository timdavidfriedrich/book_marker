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

/// Guards against a runaway or hostile client, not a monetisation gate. Every
/// signed-in account syncs rows regardless of plan.
abstract class SyncLimits
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SyncLimits._({
    required this.maxWritesPerBatch,
    required this.maxRowsPerTable,
  });

  factory SyncLimits({
    required int maxWritesPerBatch,
    required int maxRowsPerTable,
  }) = _SyncLimitsImpl;

  factory SyncLimits.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncLimits(
      maxWritesPerBatch: jsonSerialization['maxWritesPerBatch'] as int,
      maxRowsPerTable: jsonSerialization['maxRowsPerTable'] as int,
    );
  }

  int maxWritesPerBatch;

  int maxRowsPerTable;

  /// Returns a shallow copy of this [SyncLimits]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SyncLimits copyWith({
    int? maxWritesPerBatch,
    int? maxRowsPerTable,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncLimits',
      'maxWritesPerBatch': maxWritesPerBatch,
      'maxRowsPerTable': maxRowsPerTable,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncLimits',
      'maxWritesPerBatch': maxWritesPerBatch,
      'maxRowsPerTable': maxRowsPerTable,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _SyncLimitsImpl extends SyncLimits {
  _SyncLimitsImpl({
    required int maxWritesPerBatch,
    required int maxRowsPerTable,
  }) : super._(
         maxWritesPerBatch: maxWritesPerBatch,
         maxRowsPerTable: maxRowsPerTable,
       );

  /// Returns a shallow copy of this [SyncLimits]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SyncLimits copyWith({
    int? maxWritesPerBatch,
    int? maxRowsPerTable,
  }) {
    return SyncLimits(
      maxWritesPerBatch: maxWritesPerBatch ?? this.maxWritesPerBatch,
      maxRowsPerTable: maxRowsPerTable ?? this.maxRowsPerTable,
    );
  }
}
