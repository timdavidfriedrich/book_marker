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

/// Which quotes belong to which theme. Same reasoning as shelf_books.
abstract class SyncedThemeQuote
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SyncedThemeQuote._({
    _isc.UuidValue? id,
    required this.ownerId,
    required this.themeId,
    required this.quoteId,
    required this.updatedAt,
  }) : id = id ?? const _isc.Uuid().v4obj();

  factory SyncedThemeQuote({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    required _isc.UuidValue themeId,
    required _isc.UuidValue quoteId,
    required DateTime updatedAt,
  }) = _SyncedThemeQuoteImpl;

  factory SyncedThemeQuote.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncedThemeQuote(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      themeId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['themeId'],
      ),
      quoteId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['quoteId'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The id of the object.
  _isc.UuidValue id;

  _isc.UuidValue ownerId;

  _isc.UuidValue themeId;

  _isc.UuidValue quoteId;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SyncedThemeQuote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SyncedThemeQuote copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    _isc.UuidValue? themeId,
    _isc.UuidValue? quoteId,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncedThemeQuote',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'themeId': themeId.toJson(),
      'quoteId': quoteId.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncedThemeQuote',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'themeId': themeId.toJson(),
      'quoteId': quoteId.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _SyncedThemeQuoteImpl extends SyncedThemeQuote {
  _SyncedThemeQuoteImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    required _isc.UuidValue themeId,
    required _isc.UuidValue quoteId,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         themeId: themeId,
         quoteId: quoteId,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SyncedThemeQuote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SyncedThemeQuote copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    _isc.UuidValue? themeId,
    _isc.UuidValue? quoteId,
    DateTime? updatedAt,
  }) {
    return SyncedThemeQuote(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      themeId: themeId ?? this.themeId,
      quoteId: quoteId ?? this.quoteId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
