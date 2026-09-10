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

/// Where encrypted attachment blobs are kept.
///
/// Unlike everything else in app_config.yaml this is read at BOOT, not per
/// request: the storage backend is registered with Serverpod once at startup.
/// Changing it needs a restart, which is honest, because it is infrastructure
/// rather than a tunable.
abstract class AttachmentConfig
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AttachmentConfig._({
    required this.provider,
    required this.bucket,
    required this.region,
    required this.endpoint,
  });

  factory AttachmentConfig({
    required String provider,
    required String bucket,
    required String region,
    required String endpoint,
  }) = _AttachmentConfigImpl;

  factory AttachmentConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return AttachmentConfig(
      provider: jsonSerialization['provider'] as String,
      bucket: jsonSerialization['bucket'] as String,
      region: jsonSerialization['region'] as String,
      endpoint: jsonSerialization['endpoint'] as String,
    );
  }

  /// minio, or database to keep blobs in Postgres with no object store at all.
  /// The database one exists so the whole attachment path can be exercised on a
  /// machine with no MinIO and no access keys.
  String provider;

  String bucket;

  String region;

  /// Reached over the internal docker network; never published.
  String endpoint;

  /// Returns a shallow copy of this [AttachmentConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AttachmentConfig copyWith({
    String? provider,
    String? bucket,
    String? region,
    String? endpoint,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AttachmentConfig',
      'provider': provider,
      'bucket': bucket,
      'region': region,
      'endpoint': endpoint,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AttachmentConfig',
      'provider': provider,
      'bucket': bucket,
      'region': region,
      'endpoint': endpoint,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AttachmentConfigImpl extends AttachmentConfig {
  _AttachmentConfigImpl({
    required String provider,
    required String bucket,
    required String region,
    required String endpoint,
  }) : super._(
         provider: provider,
         bucket: bucket,
         region: region,
         endpoint: endpoint,
       );

  /// Returns a shallow copy of this [AttachmentConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AttachmentConfig copyWith({
    String? provider,
    String? bucket,
    String? region,
    String? endpoint,
  }) {
    return AttachmentConfig(
      provider: provider ?? this.provider,
      bucket: bucket ?? this.bucket,
      region: region ?? this.region,
      endpoint: endpoint ?? this.endpoint,
    );
  }
}
