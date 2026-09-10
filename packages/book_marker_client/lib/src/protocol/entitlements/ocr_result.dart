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

/// What a cloud scan produced, plus the refreshed counters so the quota readout
/// updates immediately instead of waiting for a sync round trip.
///
/// There is no per-word geometry here, deliberately. The marking and correction
/// UI is built on ML Kit's boxes and exists to compensate for ML Kit's errors;
/// aligning cloud text back onto them would be a second recognition problem.
abstract class OcrResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OcrResult._({
    required this.text,
    required this.engine,
    required this.requestId,
    required this.usedDay,
    required this.usedWeek,
    required this.usedMonth,
  });

  factory OcrResult({
    required String text,
    required String engine,
    required _isc.UuidValue requestId,
    required int usedDay,
    required int usedWeek,
    required int usedMonth,
  }) = _OcrResultImpl;

  factory OcrResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return OcrResult(
      text: jsonSerialization['text'] as String,
      engine: jsonSerialization['engine'] as String,
      requestId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['requestId'],
      ),
      usedDay: jsonSerialization['usedDay'] as int,
      usedWeek: jsonSerialization['usedWeek'] as int,
      usedMonth: jsonSerialization['usedMonth'] as int,
    );
  }

  String text;

  String engine;

  _isc.UuidValue requestId;

  int usedDay;

  int usedWeek;

  int usedMonth;

  /// Returns a shallow copy of this [OcrResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OcrResult copyWith({
    String? text,
    String? engine,
    _isc.UuidValue? requestId,
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OcrResult',
      'text': text,
      'engine': engine,
      'requestId': requestId.toJson(),
      'usedDay': usedDay,
      'usedWeek': usedWeek,
      'usedMonth': usedMonth,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OcrResult',
      'text': text,
      'engine': engine,
      'requestId': requestId.toJson(),
      'usedDay': usedDay,
      'usedWeek': usedWeek,
      'usedMonth': usedMonth,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _OcrResultImpl extends OcrResult {
  _OcrResultImpl({
    required String text,
    required String engine,
    required _isc.UuidValue requestId,
    required int usedDay,
    required int usedWeek,
    required int usedMonth,
  }) : super._(
         text: text,
         engine: engine,
         requestId: requestId,
         usedDay: usedDay,
         usedWeek: usedWeek,
         usedMonth: usedMonth,
       );

  /// Returns a shallow copy of this [OcrResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OcrResult copyWith({
    String? text,
    String? engine,
    _isc.UuidValue? requestId,
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
  }) {
    return OcrResult(
      text: text ?? this.text,
      engine: engine ?? this.engine,
      requestId: requestId ?? this.requestId,
      usedDay: usedDay ?? this.usedDay,
      usedWeek: usedWeek ?? this.usedWeek,
      usedMonth: usedMonth ?? this.usedMonth,
    );
  }
}
