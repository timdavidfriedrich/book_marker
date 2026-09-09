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

/// Thrown when a suspended account attempts an action that needs the server.
/// The client must render this differently from "locked" (missing master key):
/// one means contact support, the other means enter your passphrase.
abstract class AccountBlockedException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  AccountBlockedException._({this.reason});

  factory AccountBlockedException({String? reason}) =
      _AccountBlockedExceptionImpl;

  factory AccountBlockedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AccountBlockedException(
      reason: jsonSerialization['reason'] as String?,
    );
  }

  String? reason;

  /// Returns a shallow copy of this [AccountBlockedException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AccountBlockedException copyWith({String? reason});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccountBlockedException',
      if (reason != null) 'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AccountBlockedException',
      if (reason != null) 'reason': reason,
    };
  }

  @override
  String toString() {
    return 'AccountBlockedException(reason: $reason)';
  }
}

class _Undefined {}

class _AccountBlockedExceptionImpl extends AccountBlockedException {
  _AccountBlockedExceptionImpl({String? reason}) : super._(reason: reason);

  /// Returns a shallow copy of this [AccountBlockedException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AccountBlockedException copyWith({Object? reason = _Undefined}) {
    return AccountBlockedException(
      reason: reason is String? ? reason : this.reason,
    );
  }
}
