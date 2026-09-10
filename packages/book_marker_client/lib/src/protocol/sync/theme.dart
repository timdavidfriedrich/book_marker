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

/// A theme. Same shape as a shelf: the name is content, the rest is
/// presentation.
abstract class SyncedTheme
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SyncedTheme._({
    _isc.UuidValue? id,
    required this.ownerId,
    this.accent,
    this.symbol,
    required this.createdAt,
    required this.updatedAt,
    int? keyVersion,
    required this.nameCipher,
  }) : id = id ?? const _isc.Uuid().v4obj(),
       keyVersion = keyVersion ?? 1;

  factory SyncedTheme({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    String? accent,
    String? symbol,
    required DateTime createdAt,
    required DateTime updatedAt,
    int? keyVersion,
    required String nameCipher,
  }) = _SyncedThemeImpl;

  factory SyncedTheme.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncedTheme(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      accent: jsonSerialization['accent'] as String?,
      symbol: jsonSerialization['symbol'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      keyVersion: jsonSerialization['keyVersion'] as int?,
      nameCipher: jsonSerialization['nameCipher'] as String,
    );
  }

  /// The id of the object.
  _isc.UuidValue id;

  _isc.UuidValue ownerId;

  String? accent;

  String? symbol;

  DateTime createdAt;

  DateTime updatedAt;

  int keyVersion;

  String nameCipher;

  /// Returns a shallow copy of this [SyncedTheme]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SyncedTheme copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    String? accent,
    String? symbol,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? keyVersion,
    String? nameCipher,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncedTheme',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      if (accent != null) 'accent': accent,
      if (symbol != null) 'symbol': symbol,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'keyVersion': keyVersion,
      'nameCipher': nameCipher,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncedTheme',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      if (accent != null) 'accent': accent,
      if (symbol != null) 'symbol': symbol,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'keyVersion': keyVersion,
      'nameCipher': nameCipher,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SyncedThemeImpl extends SyncedTheme {
  _SyncedThemeImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue ownerId,
    String? accent,
    String? symbol,
    required DateTime createdAt,
    required DateTime updatedAt,
    int? keyVersion,
    required String nameCipher,
  }) : super._(
         id: id,
         ownerId: ownerId,
         accent: accent,
         symbol: symbol,
         createdAt: createdAt,
         updatedAt: updatedAt,
         keyVersion: keyVersion,
         nameCipher: nameCipher,
       );

  /// Returns a shallow copy of this [SyncedTheme]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SyncedTheme copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    Object? accent = _Undefined,
    Object? symbol = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? keyVersion,
    String? nameCipher,
  }) {
    return SyncedTheme(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      accent: accent is String? ? accent : this.accent,
      symbol: symbol is String? ? symbol : this.symbol,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      keyVersion: keyVersion ?? this.keyVersion,
      nameCipher: nameCipher ?? this.nameCipher,
    );
  }
}
