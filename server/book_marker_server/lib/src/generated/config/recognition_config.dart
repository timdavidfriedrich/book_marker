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

/// Which text-recognition adapter the OCR proxy uses, and whether the app
/// should default its cloud toggle to on.
abstract class RecognitionConfig
    implements _is.SerializableModel, _is.ProtocolSerialization {
  RecognitionConfig._({
    required this.provider,
    required this.cloudEnabledByDefault,
  });

  factory RecognitionConfig({
    required String provider,
    required bool cloudEnabledByDefault,
  }) = _RecognitionConfigImpl;

  factory RecognitionConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return RecognitionConfig(
      provider: jsonSerialization['provider'] as String,
      cloudEnabledByDefault: _is.BoolJsonExtension.fromJson(
        jsonSerialization['cloudEnabledByDefault'],
      ),
    );
  }

  String provider;

  bool cloudEnabledByDefault;

  /// Returns a shallow copy of this [RecognitionConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RecognitionConfig copyWith({
    String? provider,
    bool? cloudEnabledByDefault,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RecognitionConfig',
      'provider': provider,
      'cloudEnabledByDefault': cloudEnabledByDefault,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RecognitionConfig',
      'provider': provider,
      'cloudEnabledByDefault': cloudEnabledByDefault,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _RecognitionConfigImpl extends RecognitionConfig {
  _RecognitionConfigImpl({
    required String provider,
    required bool cloudEnabledByDefault,
  }) : super._(
         provider: provider,
         cloudEnabledByDefault: cloudEnabledByDefault,
       );

  /// Returns a shallow copy of this [RecognitionConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RecognitionConfig copyWith({
    String? provider,
    bool? cloudEnabledByDefault,
  }) {
    return RecognitionConfig(
      provider: provider ?? this.provider,
      cloudEnabledByDefault:
          cloudEnabledByDefault ?? this.cloudEnabledByDefault,
    );
  }
}
