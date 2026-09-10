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

/// Thrown when a batch exceeds the configured cap. Unreachable for a client
/// that chunks to the limit it reads from the same config, so it means a broken
/// or hostile one, and failing loudly beats silently truncating a batch.
abstract class SyncBatchTooLargeException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  SyncBatchTooLargeException._({
    required this.size,
    required this.limit,
  });

  factory SyncBatchTooLargeException({
    required int size,
    required int limit,
  }) = _SyncBatchTooLargeExceptionImpl;

  factory SyncBatchTooLargeException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SyncBatchTooLargeException(
      size: jsonSerialization['size'] as int,
      limit: jsonSerialization['limit'] as int,
    );
  }

  int size;

  int limit;

  /// Returns a shallow copy of this [SyncBatchTooLargeException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SyncBatchTooLargeException copyWith({
    int? size,
    int? limit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncBatchTooLargeException',
      'size': size,
      'limit': limit,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncBatchTooLargeException',
      'size': size,
      'limit': limit,
    };
  }

  @override
  String toString() {
    return 'SyncBatchTooLargeException(size: $size, limit: $limit)';
  }
}

class _SyncBatchTooLargeExceptionImpl extends SyncBatchTooLargeException {
  _SyncBatchTooLargeExceptionImpl({
    required int size,
    required int limit,
  }) : super._(
         size: size,
         limit: limit,
       );

  /// Returns a shallow copy of this [SyncBatchTooLargeException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SyncBatchTooLargeException copyWith({
    int? size,
    int? limit,
  }) {
    return SyncBatchTooLargeException(
      size: size ?? this.size,
      limit: limit ?? this.limit,
    );
  }
}
