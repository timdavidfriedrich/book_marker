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

/// The tunable numbers for one plan, read from app_config.yaml.
///
/// The server reads these to ENFORCE and the app reads the same values to
/// DISPLAY. Keeping one copy is what stops a user being refused a scan the UI
/// said they had.
abstract class PlanLimits
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PlanLimits._({
    required this.ocrPerDay,
    required this.ocrPerWeek,
    required this.ocrPerMonth,
    required this.maxImageBytes,
    required this.maxAttachmentBytes,
    required this.attachmentsEnabled,
  });

  factory PlanLimits({
    required int ocrPerDay,
    required int ocrPerWeek,
    required int ocrPerMonth,
    required int maxImageBytes,
    required int maxAttachmentBytes,
    required bool attachmentsEnabled,
  }) = _PlanLimitsImpl;

  factory PlanLimits.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlanLimits(
      ocrPerDay: jsonSerialization['ocrPerDay'] as int,
      ocrPerWeek: jsonSerialization['ocrPerWeek'] as int,
      ocrPerMonth: jsonSerialization['ocrPerMonth'] as int,
      maxImageBytes: jsonSerialization['maxImageBytes'] as int,
      maxAttachmentBytes: jsonSerialization['maxAttachmentBytes'] as int,
      attachmentsEnabled: _is.BoolJsonExtension.fromJson(
        jsonSerialization['attachmentsEnabled'],
      ),
    );
  }

  int ocrPerDay;

  int ocrPerWeek;

  int ocrPerMonth;

  int maxImageBytes;

  /// Per attachment. maxRequestSize in the Serverpod config is the outer
  /// guard, and it has to allow for base64 in the envelope.
  int maxAttachmentBytes;

  bool attachmentsEnabled;

  /// Returns a shallow copy of this [PlanLimits]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PlanLimits copyWith({
    int? ocrPerDay,
    int? ocrPerWeek,
    int? ocrPerMonth,
    int? maxImageBytes,
    int? maxAttachmentBytes,
    bool? attachmentsEnabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlanLimits',
      'ocrPerDay': ocrPerDay,
      'ocrPerWeek': ocrPerWeek,
      'ocrPerMonth': ocrPerMonth,
      'maxImageBytes': maxImageBytes,
      'maxAttachmentBytes': maxAttachmentBytes,
      'attachmentsEnabled': attachmentsEnabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlanLimits',
      'ocrPerDay': ocrPerDay,
      'ocrPerWeek': ocrPerWeek,
      'ocrPerMonth': ocrPerMonth,
      'maxImageBytes': maxImageBytes,
      'maxAttachmentBytes': maxAttachmentBytes,
      'attachmentsEnabled': attachmentsEnabled,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _PlanLimitsImpl extends PlanLimits {
  _PlanLimitsImpl({
    required int ocrPerDay,
    required int ocrPerWeek,
    required int ocrPerMonth,
    required int maxImageBytes,
    required int maxAttachmentBytes,
    required bool attachmentsEnabled,
  }) : super._(
         ocrPerDay: ocrPerDay,
         ocrPerWeek: ocrPerWeek,
         ocrPerMonth: ocrPerMonth,
         maxImageBytes: maxImageBytes,
         maxAttachmentBytes: maxAttachmentBytes,
         attachmentsEnabled: attachmentsEnabled,
       );

  /// Returns a shallow copy of this [PlanLimits]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PlanLimits copyWith({
    int? ocrPerDay,
    int? ocrPerWeek,
    int? ocrPerMonth,
    int? maxImageBytes,
    int? maxAttachmentBytes,
    bool? attachmentsEnabled,
  }) {
    return PlanLimits(
      ocrPerDay: ocrPerDay ?? this.ocrPerDay,
      ocrPerWeek: ocrPerWeek ?? this.ocrPerWeek,
      ocrPerMonth: ocrPerMonth ?? this.ocrPerMonth,
      maxImageBytes: maxImageBytes ?? this.maxImageBytes,
      maxAttachmentBytes: maxAttachmentBytes ?? this.maxAttachmentBytes,
      attachmentsEnabled: attachmentsEnabled ?? this.attachmentsEnabled,
    );
  }
}
