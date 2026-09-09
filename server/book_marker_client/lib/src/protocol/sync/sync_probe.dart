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

/// Temporary table used to verify the PowerSync replication path end to end.
/// Delete this together with its sync stream once the real synced tables land
/// in phase 4.
abstract class SyncProbe
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SyncProbe._({
    _isc.UuidValue? id,
    required this.ownerId,
    required this.note,
    required this.updatedAt,
  }) : id = id ?? const _isc.Uuid().v4obj();

  factory SyncProbe({
    _isc.UuidValue? id,
    required String ownerId,
    required String note,
    required DateTime updatedAt,
  }) = _SyncProbeImpl;

  factory SyncProbe.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncProbe(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: jsonSerialization['ownerId'] as String,
      note: jsonSerialization['note'] as String,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// UUID, not the default bigint serial. PowerSync requires a text id, and the
  /// app mints ids client-side while offline, so the database must never assign
  /// them. Every synced model needs this line.
  _isc.UuidValue id;

  String ownerId;

  String note;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SyncProbe]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SyncProbe copyWith({
    _isc.UuidValue? id,
    String? ownerId,
    String? note,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncProbe',
      'id': id.toJson(),
      'ownerId': ownerId,
      'note': note,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncProbe',
      'id': id.toJson(),
      'ownerId': ownerId,
      'note': note,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _SyncProbeImpl extends SyncProbe {
  _SyncProbeImpl({
    _isc.UuidValue? id,
    required String ownerId,
    required String note,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         note: note,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SyncProbe]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SyncProbe copyWith({
    _isc.UuidValue? id,
    String? ownerId,
    String? note,
    DateTime? updatedAt,
  }) {
    return SyncProbe(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      note: note ?? this.note,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
