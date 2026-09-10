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

/// Which books sit on which shelf.
///
/// The local table has a composite primary key and no id column, which
/// PowerSync cannot sync, so this one gains a UUID id and keeps the pair unique
/// through an index instead. No keyVersion: there is no ciphertext here.
abstract class SyncedShelfBook
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SyncedShelfBook._({
    _isc.UuidValue? id,
    required this.ownerId,
    required this.shelfId,
    required this.bookId,
    required this.updatedAt,
  }) : id = id ?? const _isc.Uuid().v4obj();

  factory SyncedShelfBook({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    required _isc.UuidValue shelfId,
    required _isc.UuidValue bookId,
    required DateTime updatedAt,
  }) = _SyncedShelfBookImpl;

  factory SyncedShelfBook.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncedShelfBook(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      shelfId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['shelfId'],
      ),
      bookId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['bookId']),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The id of the object.
  _isc.UuidValue id;

  _isc.UuidValue ownerId;

  _isc.UuidValue shelfId;

  _isc.UuidValue bookId;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SyncedShelfBook]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SyncedShelfBook copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    _isc.UuidValue? shelfId,
    _isc.UuidValue? bookId,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncedShelfBook',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'shelfId': shelfId.toJson(),
      'bookId': bookId.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncedShelfBook',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'shelfId': shelfId.toJson(),
      'bookId': bookId.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _SyncedShelfBookImpl extends SyncedShelfBook {
  _SyncedShelfBookImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    required _isc.UuidValue shelfId,
    required _isc.UuidValue bookId,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         shelfId: shelfId,
         bookId: bookId,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SyncedShelfBook]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SyncedShelfBook copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    _isc.UuidValue? shelfId,
    _isc.UuidValue? bookId,
    DateTime? updatedAt,
  }) {
    return SyncedShelfBook(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      shelfId: shelfId ?? this.shelfId,
      bookId: bookId ?? this.bookId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
