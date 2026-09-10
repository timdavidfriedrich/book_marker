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

/// A quote. Every word of it is ciphertext, including the page numbers and the
/// recognised word boxes, which would otherwise leak the shape of the text.
///
/// There is deliberately NO foreign key to books. PowerSync replicates rows
/// independently and a batch can carry a quote whose book the server has not
/// seen yet; a constraint would reject the write instead of storing an opaque
/// string. Referential integrity is kept on the device, where the cascades are.
abstract class SyncedQuote
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SyncedQuote._({
    _isc.UuidValue? id,
    required this.ownerId,
    required this.bookId,
    bool? isFavorite,
    required this.createdAt,
    required this.updatedAt,
    int? keyVersion,
    required this.quoteCipher,
    this.noteCipher,
    required this.pageNumbersCipher,
    required this.pagesCipher,
    required this.wordsCipher,
    required this.markedWordIndexesCipher,
    this.voiceNoteCipher,
  }) : id = id ?? const _isc.Uuid().v4obj(),
       isFavorite = isFavorite ?? false,
       keyVersion = keyVersion ?? 1;

  factory SyncedQuote({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    required _isc.UuidValue bookId,
    bool? isFavorite,
    required DateTime createdAt,
    required DateTime updatedAt,
    int? keyVersion,
    required String quoteCipher,
    String? noteCipher,
    required String pageNumbersCipher,
    required String pagesCipher,
    required String wordsCipher,
    required String markedWordIndexesCipher,
    String? voiceNoteCipher,
  }) = _SyncedQuoteImpl;

  factory SyncedQuote.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncedQuote(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      bookId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['bookId']),
      isFavorite: jsonSerialization['isFavorite'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isFavorite']),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      keyVersion: jsonSerialization['keyVersion'] as int?,
      quoteCipher: jsonSerialization['quoteCipher'] as String,
      noteCipher: jsonSerialization['noteCipher'] as String?,
      pageNumbersCipher: jsonSerialization['pageNumbersCipher'] as String,
      pagesCipher: jsonSerialization['pagesCipher'] as String,
      wordsCipher: jsonSerialization['wordsCipher'] as String,
      markedWordIndexesCipher:
          jsonSerialization['markedWordIndexesCipher'] as String,
      voiceNoteCipher: jsonSerialization['voiceNoteCipher'] as String?,
    );
  }

  /// The id of the object.
  _isc.UuidValue id;

  _isc.UuidValue ownerId;

  _isc.UuidValue bookId;

  bool isFavorite;

  DateTime createdAt;

  DateTime updatedAt;

  int keyVersion;

  String quoteCipher;

  String? noteCipher;

  String pageNumbersCipher;

  String pagesCipher;

  String wordsCipher;

  String markedWordIndexesCipher;

  /// Duration and the id of the local recording, encrypted together.
  String? voiceNoteCipher;

  /// Returns a shallow copy of this [SyncedQuote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SyncedQuote copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    _isc.UuidValue? bookId,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? keyVersion,
    String? quoteCipher,
    String? noteCipher,
    String? pageNumbersCipher,
    String? pagesCipher,
    String? wordsCipher,
    String? markedWordIndexesCipher,
    String? voiceNoteCipher,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncedQuote',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'bookId': bookId.toJson(),
      'isFavorite': isFavorite,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'keyVersion': keyVersion,
      'quoteCipher': quoteCipher,
      if (noteCipher != null) 'noteCipher': noteCipher,
      'pageNumbersCipher': pageNumbersCipher,
      'pagesCipher': pagesCipher,
      'wordsCipher': wordsCipher,
      'markedWordIndexesCipher': markedWordIndexesCipher,
      if (voiceNoteCipher != null) 'voiceNoteCipher': voiceNoteCipher,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncedQuote',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'bookId': bookId.toJson(),
      'isFavorite': isFavorite,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'keyVersion': keyVersion,
      'quoteCipher': quoteCipher,
      if (noteCipher != null) 'noteCipher': noteCipher,
      'pageNumbersCipher': pageNumbersCipher,
      'pagesCipher': pagesCipher,
      'wordsCipher': wordsCipher,
      'markedWordIndexesCipher': markedWordIndexesCipher,
      if (voiceNoteCipher != null) 'voiceNoteCipher': voiceNoteCipher,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SyncedQuoteImpl extends SyncedQuote {
  _SyncedQuoteImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    required _isc.UuidValue bookId,
    bool? isFavorite,
    required DateTime createdAt,
    required DateTime updatedAt,
    int? keyVersion,
    required String quoteCipher,
    String? noteCipher,
    required String pageNumbersCipher,
    required String pagesCipher,
    required String wordsCipher,
    required String markedWordIndexesCipher,
    String? voiceNoteCipher,
  }) : super._(
         id: id,
         ownerId: ownerId,
         bookId: bookId,
         isFavorite: isFavorite,
         createdAt: createdAt,
         updatedAt: updatedAt,
         keyVersion: keyVersion,
         quoteCipher: quoteCipher,
         noteCipher: noteCipher,
         pageNumbersCipher: pageNumbersCipher,
         pagesCipher: pagesCipher,
         wordsCipher: wordsCipher,
         markedWordIndexesCipher: markedWordIndexesCipher,
         voiceNoteCipher: voiceNoteCipher,
       );

  /// Returns a shallow copy of this [SyncedQuote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SyncedQuote copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    _isc.UuidValue? bookId,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? keyVersion,
    String? quoteCipher,
    Object? noteCipher = _Undefined,
    String? pageNumbersCipher,
    String? pagesCipher,
    String? wordsCipher,
    String? markedWordIndexesCipher,
    Object? voiceNoteCipher = _Undefined,
  }) {
    return SyncedQuote(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      bookId: bookId ?? this.bookId,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      keyVersion: keyVersion ?? this.keyVersion,
      quoteCipher: quoteCipher ?? this.quoteCipher,
      noteCipher: noteCipher is String? ? noteCipher : this.noteCipher,
      pageNumbersCipher: pageNumbersCipher ?? this.pageNumbersCipher,
      pagesCipher: pagesCipher ?? this.pagesCipher,
      wordsCipher: wordsCipher ?? this.wordsCipher,
      markedWordIndexesCipher:
          markedWordIndexesCipher ?? this.markedWordIndexesCipher,
      voiceNoteCipher: voiceNoteCipher is String?
          ? voiceNoteCipher
          : this.voiceNoteCipher,
    );
  }
}
