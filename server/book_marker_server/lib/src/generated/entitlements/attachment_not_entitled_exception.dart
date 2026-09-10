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

/// Thrown when a free account tries to upload an attachment.
///
/// The client must treat this as PERMANENT, not as a failure to retry. A plain
/// rejection makes the background attachment queue hammer the server forever,
/// which is the failure mode this exception exists to make impossible to miss.
abstract class AttachmentNotEntitledException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  AttachmentNotEntitledException._({required this.reason});

  factory AttachmentNotEntitledException({required String reason}) =
      _AttachmentNotEntitledExceptionImpl;

  factory AttachmentNotEntitledException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AttachmentNotEntitledException(
      reason: jsonSerialization['reason'] as String,
    );
  }

  String reason;

  /// Returns a shallow copy of this [AttachmentNotEntitledException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AttachmentNotEntitledException copyWith({String? reason});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AttachmentNotEntitledException',
      'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AttachmentNotEntitledException',
      'reason': reason,
    };
  }

  @override
  String toString() {
    return 'AttachmentNotEntitledException(reason: $reason)';
  }
}

class _AttachmentNotEntitledExceptionImpl
    extends AttachmentNotEntitledException {
  _AttachmentNotEntitledExceptionImpl({required String reason})
    : super._(reason: reason);

  /// Returns a shallow copy of this [AttachmentNotEntitledException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AttachmentNotEntitledException copyWith({String? reason}) {
    return AttachmentNotEntitledException(reason: reason ?? this.reason);
  }
}
