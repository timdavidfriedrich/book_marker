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

/// One row per stored blob.
///
/// The server cannot read an attachment and cannot infer from a synced row
/// which blobs exist, because every reference to one is inside ciphertext. So
/// it keeps its own index, and that index is what makes two things possible:
/// deleting an account completely, and knowing how much disk an owner is using.
///
/// It leaks a count and a total size, which is the same shape of structural
/// leak the row tables already accept.
///
/// Server-only: never added to the `powersync` publication.
abstract class AttachmentObject
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AttachmentObject._({
    _isc.UuidValue? id,
    required this.ownerId,
    required this.attachmentId,
    required this.sizeBytes,
    required this.createdAt,
  }) : id = id ?? const _isc.Uuid().v4obj();

  factory AttachmentObject({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    required String attachmentId,
    required int sizeBytes,
    required DateTime createdAt,
  }) = _AttachmentObjectImpl;

  factory AttachmentObject.fromJson(Map<String, dynamic> jsonSerialization) {
    return AttachmentObject(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      attachmentId: jsonSerialization['attachmentId'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The id of the object.
  _isc.UuidValue id;

  _isc.UuidValue ownerId;

  String attachmentId;

  int sizeBytes;

  DateTime createdAt;

  /// Returns a shallow copy of this [AttachmentObject]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AttachmentObject copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    String? attachmentId,
    int? sizeBytes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AttachmentObject',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'attachmentId': attachmentId,
      'sizeBytes': sizeBytes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AttachmentObject',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'attachmentId': attachmentId,
      'sizeBytes': sizeBytes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AttachmentObjectImpl extends AttachmentObject {
  _AttachmentObjectImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    required String attachmentId,
    required int sizeBytes,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         attachmentId: attachmentId,
         sizeBytes: sizeBytes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AttachmentObject]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AttachmentObject copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    String? attachmentId,
    int? sizeBytes,
    DateTime? createdAt,
  }) {
    return AttachmentObject(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      attachmentId: attachmentId ?? this.attachmentId,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
