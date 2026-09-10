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

/// One row change from a device, as PowerSync's CRUD queue recorded it.
///
/// `data` is a JSON object of column names to values, or null for a delete.
/// `owner_id` is never read from it: SyncEndpoint.upload overwrites it from the
/// session, so a client that forges the field changes nothing.
abstract class SyncWrite
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SyncWrite._({
    required this.table,
    required this.operation,
    required this.rowId,
    this.data,
  });

  factory SyncWrite({
    required String table,
    required String operation,
    required _is.UuidValue rowId,
    String? data,
  }) = _SyncWriteImpl;

  factory SyncWrite.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncWrite(
      table: jsonSerialization['table'] as String,
      operation: jsonSerialization['operation'] as String,
      rowId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['rowId']),
      data: jsonSerialization['data'] as String?,
    );
  }

  /// The table's public name, matching the PowerSync view: books, quotes,
  /// shelves, themes, shelf_books, theme_quotes.
  String table;

  /// put | patch | delete
  String operation;

  _is.UuidValue rowId;

  String? data;

  /// Returns a shallow copy of this [SyncWrite]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SyncWrite copyWith({
    String? table,
    String? operation,
    _is.UuidValue? rowId,
    String? data,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncWrite',
      'table': table,
      'operation': operation,
      'rowId': rowId.toJson(),
      if (data != null) 'data': data,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncWrite',
      'table': table,
      'operation': operation,
      'rowId': rowId.toJson(),
      if (data != null) 'data': data,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SyncWriteImpl extends SyncWrite {
  _SyncWriteImpl({
    required String table,
    required String operation,
    required _is.UuidValue rowId,
    String? data,
  }) : super._(
         table: table,
         operation: operation,
         rowId: rowId,
         data: data,
       );

  /// Returns a shallow copy of this [SyncWrite]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SyncWrite copyWith({
    String? table,
    String? operation,
    _is.UuidValue? rowId,
    Object? data = _Undefined,
  }) {
    return SyncWrite(
      table: table ?? this.table,
      operation: operation ?? this.operation,
      rowId: rowId ?? this.rowId,
      data: data is String? ? data : this.data,
    );
  }
}
