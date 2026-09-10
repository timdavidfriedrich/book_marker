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
import 'package:book_marker_client/src/protocol/protocol.dart' as _it2ad2ly;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../config/client_config.dart' as _izbnfhbo;
import '../config/plan_limits.dart' as _ikxhbfyx;
import '../config/recognition_config.dart' as _iw7rryx2;

/// Everything that can change in production without a deploy or an app release.
///
/// Not a table. It is parsed from app_config.yaml on the host, which is mounted
/// into the container read-only, so editing it and reloading is the whole
/// procedure. Nothing secret goes in it - it is served unauthenticated.
///
/// `version` is bumped by hand on every edit so a client can log which revision
/// it is holding.
abstract class RuntimeConfig
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RuntimeConfig._({
    required this.version,
    required this.free,
    required this.premium,
    required this.recognition,
    required this.client,
  });

  factory RuntimeConfig({
    required int version,
    required _ikxhbfyx.PlanLimits free,
    required _ikxhbfyx.PlanLimits premium,
    required _iw7rryx2.RecognitionConfig recognition,
    required _izbnfhbo.ClientConfig client,
  }) = _RuntimeConfigImpl;

  factory RuntimeConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return RuntimeConfig(
      version: jsonSerialization['version'] as int,
      free: _it2ad2ly.Protocol().deserialize<_ikxhbfyx.PlanLimits>(
        jsonSerialization['free'],
      ),
      premium: _it2ad2ly.Protocol().deserialize<_ikxhbfyx.PlanLimits>(
        jsonSerialization['premium'],
      ),
      recognition: _it2ad2ly.Protocol()
          .deserialize<_iw7rryx2.RecognitionConfig>(
            jsonSerialization['recognition'],
          ),
      client: _it2ad2ly.Protocol().deserialize<_izbnfhbo.ClientConfig>(
        jsonSerialization['client'],
      ),
    );
  }

  int version;

  _ikxhbfyx.PlanLimits free;

  _ikxhbfyx.PlanLimits premium;

  _iw7rryx2.RecognitionConfig recognition;

  _izbnfhbo.ClientConfig client;

  /// Returns a shallow copy of this [RuntimeConfig]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RuntimeConfig copyWith({
    int? version,
    _ikxhbfyx.PlanLimits? free,
    _ikxhbfyx.PlanLimits? premium,
    _iw7rryx2.RecognitionConfig? recognition,
    _izbnfhbo.ClientConfig? client,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RuntimeConfig',
      'version': version,
      'free': free.toJson(),
      'premium': premium.toJson(),
      'recognition': recognition.toJson(),
      'client': client.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RuntimeConfig',
      'version': version,
      'free': free.toJsonForProtocol(),
      'premium': premium.toJsonForProtocol(),
      'recognition': recognition.toJsonForProtocol(),
      'client': client.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _RuntimeConfigImpl extends RuntimeConfig {
  _RuntimeConfigImpl({
    required int version,
    required _ikxhbfyx.PlanLimits free,
    required _ikxhbfyx.PlanLimits premium,
    required _iw7rryx2.RecognitionConfig recognition,
    required _izbnfhbo.ClientConfig client,
  }) : super._(
         version: version,
         free: free,
         premium: premium,
         recognition: recognition,
         client: client,
       );

  /// Returns a shallow copy of this [RuntimeConfig]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RuntimeConfig copyWith({
    int? version,
    _ikxhbfyx.PlanLimits? free,
    _ikxhbfyx.PlanLimits? premium,
    _iw7rryx2.RecognitionConfig? recognition,
    _izbnfhbo.ClientConfig? client,
  }) {
    return RuntimeConfig(
      version: version ?? this.version,
      free: free ?? this.free.copyWith(),
      premium: premium ?? this.premium.copyWith(),
      recognition: recognition ?? this.recognition.copyWith(),
      client: client ?? this.client.copyWith(),
    );
  }
}
