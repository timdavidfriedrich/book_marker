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

/// The two levers that can tell an already-shipped app to stand down. They are
/// the reason this endpoint is unauthenticated: both have to work for a client
/// that cannot sign in.
abstract class ClientConfig
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ClientConfig._({
    required this.minSupportedVersion,
    required this.maintenanceMode,
    this.maintenanceMessage,
  });

  factory ClientConfig({
    required String minSupportedVersion,
    required bool maintenanceMode,
    String? maintenanceMessage,
  }) = _ClientConfigImpl;

  factory ClientConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClientConfig(
      minSupportedVersion: jsonSerialization['minSupportedVersion'] as String,
      maintenanceMode: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['maintenanceMode'],
      ),
      maintenanceMessage: jsonSerialization['maintenanceMessage'] as String?,
    );
  }

  String minSupportedVersion;

  bool maintenanceMode;

  String? maintenanceMessage;

  /// Returns a shallow copy of this [ClientConfig]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ClientConfig copyWith({
    String? minSupportedVersion,
    bool? maintenanceMode,
    String? maintenanceMessage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClientConfig',
      'minSupportedVersion': minSupportedVersion,
      'maintenanceMode': maintenanceMode,
      if (maintenanceMessage != null) 'maintenanceMessage': maintenanceMessage,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClientConfig',
      'minSupportedVersion': minSupportedVersion,
      'maintenanceMode': maintenanceMode,
      if (maintenanceMessage != null) 'maintenanceMessage': maintenanceMessage,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClientConfigImpl extends ClientConfig {
  _ClientConfigImpl({
    required String minSupportedVersion,
    required bool maintenanceMode,
    String? maintenanceMessage,
  }) : super._(
         minSupportedVersion: minSupportedVersion,
         maintenanceMode: maintenanceMode,
         maintenanceMessage: maintenanceMessage,
       );

  /// Returns a shallow copy of this [ClientConfig]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ClientConfig copyWith({
    String? minSupportedVersion,
    bool? maintenanceMode,
    Object? maintenanceMessage = _Undefined,
  }) {
    return ClientConfig(
      minSupportedVersion: minSupportedVersion ?? this.minSupportedVersion,
      maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      maintenanceMessage: maintenanceMessage is String?
          ? maintenanceMessage
          : this.maintenanceMessage,
    );
  }
}
