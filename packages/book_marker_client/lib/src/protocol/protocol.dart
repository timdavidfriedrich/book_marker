/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'config/client_config.dart' as _ikmgnzhy;
import 'config/plan_limits.dart' as _ios57rmt;
import 'config/recognition_config.dart' as _i96enlzs;
import 'config/runtime_config.dart' as _iadewe5j;
import 'entitlements/account_blocked_exception.dart' as _i42k8jky;
import 'entitlements/entitlement.dart' as _id6kwse3;
import 'entitlements/ocr_usage.dart' as _i13b5r7e;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'sync/sync_probe.dart' as _i8t4kps3;
export 'config/client_config.dart';
export 'config/plan_limits.dart';
export 'config/recognition_config.dart';
export 'config/runtime_config.dart';
export 'entitlements/account_blocked_exception.dart';
export 'entitlements/entitlement.dart';
export 'entitlements/ocr_usage.dart';
export 'greetings/greeting.dart';
export 'sync/sync_probe.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ikmgnzhy.ClientConfig) {
      return _ikmgnzhy.ClientConfig.fromJson(data) as T;
    }
    if (t == _ios57rmt.PlanLimits) {
      return _ios57rmt.PlanLimits.fromJson(data) as T;
    }
    if (t == _i96enlzs.RecognitionConfig) {
      return _i96enlzs.RecognitionConfig.fromJson(data) as T;
    }
    if (t == _iadewe5j.RuntimeConfig) {
      return _iadewe5j.RuntimeConfig.fromJson(data) as T;
    }
    if (t == _i42k8jky.AccountBlockedException) {
      return _i42k8jky.AccountBlockedException.fromJson(data) as T;
    }
    if (t == _id6kwse3.Entitlement) {
      return _id6kwse3.Entitlement.fromJson(data) as T;
    }
    if (t == _i13b5r7e.OcrUsage) {
      return _i13b5r7e.OcrUsage.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _i8t4kps3.SyncProbe) {
      return _i8t4kps3.SyncProbe.fromJson(data) as T;
    }
    if (t == _isc.getType<_ikmgnzhy.ClientConfig?>()) {
      return (data != null ? _ikmgnzhy.ClientConfig.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ios57rmt.PlanLimits?>()) {
      return (data != null ? _ios57rmt.PlanLimits.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i96enlzs.RecognitionConfig?>()) {
      return (data != null ? _i96enlzs.RecognitionConfig.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iadewe5j.RuntimeConfig?>()) {
      return (data != null ? _iadewe5j.RuntimeConfig.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i42k8jky.AccountBlockedException?>()) {
      return (data != null
              ? _i42k8jky.AccountBlockedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_id6kwse3.Entitlement?>()) {
      return (data != null ? _id6kwse3.Entitlement.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i13b5r7e.OcrUsage?>()) {
      return (data != null ? _i13b5r7e.OcrUsage.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8t4kps3.SyncProbe?>()) {
      return (data != null ? _i8t4kps3.SyncProbe.fromJson(data) : null) as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ikmgnzhy.ClientConfig => 'ClientConfig',
      _ios57rmt.PlanLimits => 'PlanLimits',
      _i96enlzs.RecognitionConfig => 'RecognitionConfig',
      _iadewe5j.RuntimeConfig => 'RuntimeConfig',
      _i42k8jky.AccountBlockedException => 'AccountBlockedException',
      _id6kwse3.Entitlement => 'Entitlement',
      _i13b5r7e.OcrUsage => 'OcrUsage',
      _izw8z7ou.Greeting => 'Greeting',
      _i8t4kps3.SyncProbe => 'SyncProbe',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('book_marker.', '');
    }

    switch (data) {
      case _ikmgnzhy.ClientConfig():
        return 'ClientConfig';
      case _ios57rmt.PlanLimits():
        return 'PlanLimits';
      case _i96enlzs.RecognitionConfig():
        return 'RecognitionConfig';
      case _iadewe5j.RuntimeConfig():
        return 'RuntimeConfig';
      case _i42k8jky.AccountBlockedException():
        return 'AccountBlockedException';
      case _id6kwse3.Entitlement():
        return 'Entitlement';
      case _i13b5r7e.OcrUsage():
        return 'OcrUsage';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _i8t4kps3.SyncProbe():
        return 'SyncProbe';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ClientConfig') {
      return deserialize<_ikmgnzhy.ClientConfig>(data['data']);
    }
    if (dataClassName == 'PlanLimits') {
      return deserialize<_ios57rmt.PlanLimits>(data['data']);
    }
    if (dataClassName == 'RecognitionConfig') {
      return deserialize<_i96enlzs.RecognitionConfig>(data['data']);
    }
    if (dataClassName == 'RuntimeConfig') {
      return deserialize<_iadewe5j.RuntimeConfig>(data['data']);
    }
    if (dataClassName == 'AccountBlockedException') {
      return deserialize<_i42k8jky.AccountBlockedException>(data['data']);
    }
    if (dataClassName == 'Entitlement') {
      return deserialize<_id6kwse3.Entitlement>(data['data']);
    }
    if (dataClassName == 'OcrUsage') {
      return deserialize<_i13b5r7e.OcrUsage>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'SyncProbe') {
      return deserialize<_i8t4kps3.SyncProbe>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('book_marker', this);
    _iacc.Protocol().registerHostProtocol('book_marker', this);
  }

  @override
  String getModuleName() => 'book_marker';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
