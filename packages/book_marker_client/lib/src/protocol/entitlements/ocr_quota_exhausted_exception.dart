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

/// Thrown when the rolling windows are full. Carries the numbers so the app can
/// say which window ran out and show the readout without a second call.
///
/// The app treats this as a signal to fall back to on-device recognition, not
/// as an error: a scan is never lost to a spent quota.
abstract class OcrQuotaExhaustedException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  OcrQuotaExhaustedException._({
    required this.usedDay,
    required this.usedWeek,
    required this.usedMonth,
    required this.limitDay,
    required this.limitWeek,
    required this.limitMonth,
  });

  factory OcrQuotaExhaustedException({
    required int usedDay,
    required int usedWeek,
    required int usedMonth,
    required int limitDay,
    required int limitWeek,
    required int limitMonth,
  }) = _OcrQuotaExhaustedExceptionImpl;

  factory OcrQuotaExhaustedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OcrQuotaExhaustedException(
      usedDay: jsonSerialization['usedDay'] as int,
      usedWeek: jsonSerialization['usedWeek'] as int,
      usedMonth: jsonSerialization['usedMonth'] as int,
      limitDay: jsonSerialization['limitDay'] as int,
      limitWeek: jsonSerialization['limitWeek'] as int,
      limitMonth: jsonSerialization['limitMonth'] as int,
    );
  }

  int usedDay;

  int usedWeek;

  int usedMonth;

  int limitDay;

  int limitWeek;

  int limitMonth;

  /// Returns a shallow copy of this [OcrQuotaExhaustedException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OcrQuotaExhaustedException copyWith({
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
    int? limitDay,
    int? limitWeek,
    int? limitMonth,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OcrQuotaExhaustedException',
      'usedDay': usedDay,
      'usedWeek': usedWeek,
      'usedMonth': usedMonth,
      'limitDay': limitDay,
      'limitWeek': limitWeek,
      'limitMonth': limitMonth,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OcrQuotaExhaustedException',
      'usedDay': usedDay,
      'usedWeek': usedWeek,
      'usedMonth': usedMonth,
      'limitDay': limitDay,
      'limitWeek': limitWeek,
      'limitMonth': limitMonth,
    };
  }

  @override
  String toString() {
    return 'OcrQuotaExhaustedException(usedDay: $usedDay, usedWeek: $usedWeek, usedMonth: $usedMonth, limitDay: $limitDay, limitWeek: $limitWeek, limitMonth: $limitMonth)';
  }
}

class _OcrQuotaExhaustedExceptionImpl extends OcrQuotaExhaustedException {
  _OcrQuotaExhaustedExceptionImpl({
    required int usedDay,
    required int usedWeek,
    required int usedMonth,
    required int limitDay,
    required int limitWeek,
    required int limitMonth,
  }) : super._(
         usedDay: usedDay,
         usedWeek: usedWeek,
         usedMonth: usedMonth,
         limitDay: limitDay,
         limitWeek: limitWeek,
         limitMonth: limitMonth,
       );

  /// Returns a shallow copy of this [OcrQuotaExhaustedException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OcrQuotaExhaustedException copyWith({
    int? usedDay,
    int? usedWeek,
    int? usedMonth,
    int? limitDay,
    int? limitWeek,
    int? limitMonth,
  }) {
    return OcrQuotaExhaustedException(
      usedDay: usedDay ?? this.usedDay,
      usedWeek: usedWeek ?? this.usedWeek,
      usedMonth: usedMonth ?? this.usedMonth,
      limitDay: limitDay ?? this.limitDay,
      limitWeek: limitWeek ?? this.limitWeek,
      limitMonth: limitMonth ?? this.limitMonth,
    );
  }
}
