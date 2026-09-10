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

/// A book, as the server stores it: structure in the clear, content encrypted.
///
/// `status`, `createdAt` and `lastUsedAt` stay plaintext so PowerSync can bucket
/// by owner and Drift can order in SQL. Everything a person wrote or looked up
/// is ciphertext the server has no key for.
///
/// Column names are snake_case via `column=`, not Serverpod's default camelCase.
/// The sync stream SQL, the PowerSync client schema and Drift's default column
/// naming all use snake_case, and one convention across the three is worth more
/// than matching the Dart field names.
abstract class SyncedBook
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SyncedBook._({
    _isc.UuidValue? id,
    required this.ownerId,
    required this.status,
    required this.createdAt,
    required this.lastUsedAt,
    required this.updatedAt,
    int? keyVersion,
    required this.titleCipher,
    required this.authorsCipher,
    this.isbnCipher,
    this.coverCipher,
  }) : id = id ?? const _isc.Uuid().v4obj(),
       keyVersion = keyVersion ?? 1;

  factory SyncedBook({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    required String status,
    required DateTime createdAt,
    required DateTime lastUsedAt,
    required DateTime updatedAt,
    int? keyVersion,
    required String titleCipher,
    required String authorsCipher,
    String? isbnCipher,
    String? coverCipher,
  }) = _SyncedBookImpl;

  factory SyncedBook.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncedBook(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      status: jsonSerialization['status'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      lastUsedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastUsedAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      keyVersion: jsonSerialization['keyVersion'] as int?,
      titleCipher: jsonSerialization['titleCipher'] as String,
      authorsCipher: jsonSerialization['authorsCipher'] as String,
      isbnCipher: jsonSerialization['isbnCipher'] as String?,
      coverCipher: jsonSerialization['coverCipher'] as String?,
    );
  }

  /// UUID, not the default bigint serial. PowerSync requires a text id, and the
  /// app mints ids client-side while offline, so the database must never assign
  /// them. Every synced model needs this line.
  _isc.UuidValue id;

  _isc.UuidValue ownerId;

  String status;

  DateTime createdAt;

  DateTime lastUsedAt;

  DateTime updatedAt;

  /// Which key encrypted this row. Present from the start so re-encryption is a
  /// migration rather than a rewrite.
  int keyVersion;

  String titleCipher;

  String authorsCipher;

  String? isbnCipher;

  /// Cover URL and the id of the local cover file, encrypted together. The
  /// attachment itself does not exist until phase 7.
  String? coverCipher;

  /// Returns a shallow copy of this [SyncedBook]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SyncedBook copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    String? status,
    DateTime? createdAt,
    DateTime? lastUsedAt,
    DateTime? updatedAt,
    int? keyVersion,
    String? titleCipher,
    String? authorsCipher,
    String? isbnCipher,
    String? coverCipher,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncedBook',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'status': status,
      'createdAt': createdAt.toJson(),
      'lastUsedAt': lastUsedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'keyVersion': keyVersion,
      'titleCipher': titleCipher,
      'authorsCipher': authorsCipher,
      if (isbnCipher != null) 'isbnCipher': isbnCipher,
      if (coverCipher != null) 'coverCipher': coverCipher,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncedBook',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'status': status,
      'createdAt': createdAt.toJson(),
      'lastUsedAt': lastUsedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'keyVersion': keyVersion,
      'titleCipher': titleCipher,
      'authorsCipher': authorsCipher,
      if (isbnCipher != null) 'isbnCipher': isbnCipher,
      if (coverCipher != null) 'coverCipher': coverCipher,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SyncedBookImpl extends SyncedBook {
  _SyncedBookImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    required String status,
    required DateTime createdAt,
    required DateTime lastUsedAt,
    required DateTime updatedAt,
    int? keyVersion,
    required String titleCipher,
    required String authorsCipher,
    String? isbnCipher,
    String? coverCipher,
  }) : super._(
         id: id,
         ownerId: ownerId,
         status: status,
         createdAt: createdAt,
         lastUsedAt: lastUsedAt,
         updatedAt: updatedAt,
         keyVersion: keyVersion,
         titleCipher: titleCipher,
         authorsCipher: authorsCipher,
         isbnCipher: isbnCipher,
         coverCipher: coverCipher,
       );

  /// Returns a shallow copy of this [SyncedBook]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SyncedBook copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    String? status,
    DateTime? createdAt,
    DateTime? lastUsedAt,
    DateTime? updatedAt,
    int? keyVersion,
    String? titleCipher,
    String? authorsCipher,
    Object? isbnCipher = _Undefined,
    Object? coverCipher = _Undefined,
  }) {
    return SyncedBook(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      keyVersion: keyVersion ?? this.keyVersion,
      titleCipher: titleCipher ?? this.titleCipher,
      authorsCipher: authorsCipher ?? this.authorsCipher,
      isbnCipher: isbnCipher is String? ? isbnCipher : this.isbnCipher,
      coverCipher: coverCipher is String? ? coverCipher : this.coverCipher,
    );
  }
}
