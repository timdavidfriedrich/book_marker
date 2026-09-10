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

/// The provider failed, or the upload was larger than the plan allows. Both
/// mean the same thing to the app: use on-device recognition for this page.
abstract class OcrUnavailableException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  OcrUnavailableException._({required this.reason});

  factory OcrUnavailableException({required String reason}) =
      _OcrUnavailableExceptionImpl;

  factory OcrUnavailableException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OcrUnavailableException(
      reason: jsonSerialization['reason'] as String,
    );
  }

  String reason;

  /// Returns a shallow copy of this [OcrUnavailableException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OcrUnavailableException copyWith({String? reason});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OcrUnavailableException',
      'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OcrUnavailableException',
      'reason': reason,
    };
  }

  @override
  String toString() {
    return 'OcrUnavailableException(reason: $reason)';
  }
}

class _OcrUnavailableExceptionImpl extends OcrUnavailableException {
  _OcrUnavailableExceptionImpl({required String reason})
    : super._(reason: reason);

  /// Returns a shallow copy of this [OcrUnavailableException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OcrUnavailableException copyWith({String? reason}) {
    return OcrUnavailableException(reason: reason ?? this.reason);
  }
}
