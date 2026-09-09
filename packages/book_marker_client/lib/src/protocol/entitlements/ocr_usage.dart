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

/// Append-only log of cloud OCR requests. The source of truth for rate limits.
///
/// Server-only: never added to the `powersync` publication. The device sees the
/// denormalised counters on `entitlements` instead.
///
/// `status` drives the admission protocol: a row is inserted as `reserved`
/// inside the advisory-locked transaction, then flipped to `completed` or
/// `failed` once the provider responds. Counting includes `reserved`, so an
/// in-flight scan holds its slot.
abstract class OcrUsage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OcrUsage._({
    _isc.UuidValue? id,
    required this.ownerId,
    required this.createdAt,
    required this.engine,
    String? status,
    this.inputTokens,
    this.outputTokens,
  }) : id = id ?? const _isc.Uuid().v4obj(),
       status = status ?? 'reserved';

  factory OcrUsage({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    required DateTime createdAt,
    required String engine,
    String? status,
    int? inputTokens,
    int? outputTokens,
  }) = _OcrUsageImpl;

  factory OcrUsage.fromJson(Map<String, dynamic> jsonSerialization) {
    return OcrUsage(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      engine: jsonSerialization['engine'] as String,
      status: jsonSerialization['status'] as String?,
      inputTokens: jsonSerialization['inputTokens'] as int?,
      outputTokens: jsonSerialization['outputTokens'] as int?,
    );
  }

  /// The id of the object.
  _isc.UuidValue id;

  _isc.UuidValue ownerId;

  DateTime createdAt;

  String engine;

  String status;

  int? inputTokens;

  int? outputTokens;

  /// Returns a shallow copy of this [OcrUsage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OcrUsage copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    DateTime? createdAt,
    String? engine,
    String? status,
    int? inputTokens,
    int? outputTokens,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OcrUsage',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'createdAt': createdAt.toJson(),
      'engine': engine,
      'status': status,
      if (inputTokens != null) 'inputTokens': inputTokens,
      if (outputTokens != null) 'outputTokens': outputTokens,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OcrUsage',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'createdAt': createdAt.toJson(),
      'engine': engine,
      'status': status,
      if (inputTokens != null) 'inputTokens': inputTokens,
      if (outputTokens != null) 'outputTokens': outputTokens,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OcrUsageImpl extends OcrUsage {
  _OcrUsageImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    required DateTime createdAt,
    required String engine,
    String? status,
    int? inputTokens,
    int? outputTokens,
  }) : super._(
         id: id,
         ownerId: ownerId,
         createdAt: createdAt,
         engine: engine,
         status: status,
         inputTokens: inputTokens,
         outputTokens: outputTokens,
       );

  /// Returns a shallow copy of this [OcrUsage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OcrUsage copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    DateTime? createdAt,
    String? engine,
    String? status,
    Object? inputTokens = _Undefined,
    Object? outputTokens = _Undefined,
  }) {
    return OcrUsage(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      engine: engine ?? this.engine,
      status: status ?? this.status,
      inputTokens: inputTokens is int? ? inputTokens : this.inputTokens,
      outputTokens: outputTokens is int? ? outputTokens : this.outputTokens,
    );
  }
}
