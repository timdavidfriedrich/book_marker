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
import 'package:book_marker_client/src/protocol/sync/sync_write.dart'
    as _ihx5no0d;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'config/client_config.dart' as _ikmgnzhy;
import 'config/plan_limits.dart' as _ios57rmt;
import 'config/recognition_config.dart' as _i96enlzs;
import 'config/runtime_config.dart' as _iadewe5j;
import 'config/sync_limits.dart' as _ivlkv61n;
import 'entitlements/account_blocked_exception.dart' as _i42k8jky;
import 'entitlements/entitlement.dart' as _id6kwse3;
import 'entitlements/entitlement_view.dart' as _ik9sk60n;
import 'entitlements/ocr_quota_exhausted_exception.dart' as _ik0msexu;
import 'entitlements/ocr_result.dart' as _ib23r0hr;
import 'entitlements/ocr_unavailable_exception.dart' as _ivem8n6h;
import 'entitlements/ocr_usage.dart' as _i13b5r7e;
import 'sync/book.dart' as _i8t9sm2n;
import 'sync/quote.dart' as _ivf4v01a;
import 'sync/shelf.dart' as _ibxgxncl;
import 'sync/shelf_book.dart' as _isij2asi;
import 'sync/sync_batch_too_large_exception.dart' as _ivzk7mwa;
import 'sync/sync_result.dart' as _ibtdwinl;
import 'sync/sync_write.dart' as _it8m259u;
import 'sync/theme.dart' as _itq42fc1;
import 'sync/theme_quote.dart' as _ih8stdgt;
export 'config/client_config.dart';
export 'config/plan_limits.dart';
export 'config/recognition_config.dart';
export 'config/runtime_config.dart';
export 'config/sync_limits.dart';
export 'entitlements/account_blocked_exception.dart';
export 'entitlements/entitlement.dart';
export 'entitlements/entitlement_view.dart';
export 'entitlements/ocr_quota_exhausted_exception.dart';
export 'entitlements/ocr_result.dart';
export 'entitlements/ocr_unavailable_exception.dart';
export 'entitlements/ocr_usage.dart';
export 'sync/book.dart';
export 'sync/quote.dart';
export 'sync/shelf.dart';
export 'sync/shelf_book.dart';
export 'sync/sync_batch_too_large_exception.dart';
export 'sync/sync_result.dart';
export 'sync/sync_write.dart';
export 'sync/theme.dart';
export 'sync/theme_quote.dart';
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
    if (t == _ivlkv61n.SyncLimits) {
      return _ivlkv61n.SyncLimits.fromJson(data) as T;
    }
    if (t == _i42k8jky.AccountBlockedException) {
      return _i42k8jky.AccountBlockedException.fromJson(data) as T;
    }
    if (t == _id6kwse3.Entitlement) {
      return _id6kwse3.Entitlement.fromJson(data) as T;
    }
    if (t == _ik9sk60n.EntitlementView) {
      return _ik9sk60n.EntitlementView.fromJson(data) as T;
    }
    if (t == _ik0msexu.OcrQuotaExhaustedException) {
      return _ik0msexu.OcrQuotaExhaustedException.fromJson(data) as T;
    }
    if (t == _ib23r0hr.OcrResult) {
      return _ib23r0hr.OcrResult.fromJson(data) as T;
    }
    if (t == _ivem8n6h.OcrUnavailableException) {
      return _ivem8n6h.OcrUnavailableException.fromJson(data) as T;
    }
    if (t == _i13b5r7e.OcrUsage) {
      return _i13b5r7e.OcrUsage.fromJson(data) as T;
    }
    if (t == _i8t9sm2n.SyncedBook) {
      return _i8t9sm2n.SyncedBook.fromJson(data) as T;
    }
    if (t == _ivf4v01a.SyncedQuote) {
      return _ivf4v01a.SyncedQuote.fromJson(data) as T;
    }
    if (t == _ibxgxncl.SyncedShelf) {
      return _ibxgxncl.SyncedShelf.fromJson(data) as T;
    }
    if (t == _isij2asi.SyncedShelfBook) {
      return _isij2asi.SyncedShelfBook.fromJson(data) as T;
    }
    if (t == _ivzk7mwa.SyncBatchTooLargeException) {
      return _ivzk7mwa.SyncBatchTooLargeException.fromJson(data) as T;
    }
    if (t == _ibtdwinl.SyncResult) {
      return _ibtdwinl.SyncResult.fromJson(data) as T;
    }
    if (t == _it8m259u.SyncWrite) {
      return _it8m259u.SyncWrite.fromJson(data) as T;
    }
    if (t == _itq42fc1.SyncedTheme) {
      return _itq42fc1.SyncedTheme.fromJson(data) as T;
    }
    if (t == _ih8stdgt.SyncedThemeQuote) {
      return _ih8stdgt.SyncedThemeQuote.fromJson(data) as T;
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
    if (t == _isc.getType<_ivlkv61n.SyncLimits?>()) {
      return (data != null ? _ivlkv61n.SyncLimits.fromJson(data) : null) as T;
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
    if (t == _isc.getType<_ik9sk60n.EntitlementView?>()) {
      return (data != null ? _ik9sk60n.EntitlementView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ik0msexu.OcrQuotaExhaustedException?>()) {
      return (data != null
              ? _ik0msexu.OcrQuotaExhaustedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ib23r0hr.OcrResult?>()) {
      return (data != null ? _ib23r0hr.OcrResult.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ivem8n6h.OcrUnavailableException?>()) {
      return (data != null
              ? _ivem8n6h.OcrUnavailableException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i13b5r7e.OcrUsage?>()) {
      return (data != null ? _i13b5r7e.OcrUsage.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8t9sm2n.SyncedBook?>()) {
      return (data != null ? _i8t9sm2n.SyncedBook.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ivf4v01a.SyncedQuote?>()) {
      return (data != null ? _ivf4v01a.SyncedQuote.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ibxgxncl.SyncedShelf?>()) {
      return (data != null ? _ibxgxncl.SyncedShelf.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isij2asi.SyncedShelfBook?>()) {
      return (data != null ? _isij2asi.SyncedShelfBook.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivzk7mwa.SyncBatchTooLargeException?>()) {
      return (data != null
              ? _ivzk7mwa.SyncBatchTooLargeException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ibtdwinl.SyncResult?>()) {
      return (data != null ? _ibtdwinl.SyncResult.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_it8m259u.SyncWrite?>()) {
      return (data != null ? _it8m259u.SyncWrite.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itq42fc1.SyncedTheme?>()) {
      return (data != null ? _itq42fc1.SyncedTheme.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ih8stdgt.SyncedThemeQuote?>()) {
      return (data != null ? _ih8stdgt.SyncedThemeQuote.fromJson(data) : null)
          as T;
    }
    if (t == List<_ihx5no0d.SyncWrite>) {
      return (data as List)
              .map((e) => deserialize<_ihx5no0d.SyncWrite>(e))
              .toList()
          as T;
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
      _ivlkv61n.SyncLimits => 'SyncLimits',
      _i42k8jky.AccountBlockedException => 'AccountBlockedException',
      _id6kwse3.Entitlement => 'Entitlement',
      _ik9sk60n.EntitlementView => 'EntitlementView',
      _ik0msexu.OcrQuotaExhaustedException => 'OcrQuotaExhaustedException',
      _ib23r0hr.OcrResult => 'OcrResult',
      _ivem8n6h.OcrUnavailableException => 'OcrUnavailableException',
      _i13b5r7e.OcrUsage => 'OcrUsage',
      _i8t9sm2n.SyncedBook => 'SyncedBook',
      _ivf4v01a.SyncedQuote => 'SyncedQuote',
      _ibxgxncl.SyncedShelf => 'SyncedShelf',
      _isij2asi.SyncedShelfBook => 'SyncedShelfBook',
      _ivzk7mwa.SyncBatchTooLargeException => 'SyncBatchTooLargeException',
      _ibtdwinl.SyncResult => 'SyncResult',
      _it8m259u.SyncWrite => 'SyncWrite',
      _itq42fc1.SyncedTheme => 'SyncedTheme',
      _ih8stdgt.SyncedThemeQuote => 'SyncedThemeQuote',
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
      case _ivlkv61n.SyncLimits():
        return 'SyncLimits';
      case _i42k8jky.AccountBlockedException():
        return 'AccountBlockedException';
      case _id6kwse3.Entitlement():
        return 'Entitlement';
      case _ik9sk60n.EntitlementView():
        return 'EntitlementView';
      case _ik0msexu.OcrQuotaExhaustedException():
        return 'OcrQuotaExhaustedException';
      case _ib23r0hr.OcrResult():
        return 'OcrResult';
      case _ivem8n6h.OcrUnavailableException():
        return 'OcrUnavailableException';
      case _i13b5r7e.OcrUsage():
        return 'OcrUsage';
      case _i8t9sm2n.SyncedBook():
        return 'SyncedBook';
      case _ivf4v01a.SyncedQuote():
        return 'SyncedQuote';
      case _ibxgxncl.SyncedShelf():
        return 'SyncedShelf';
      case _isij2asi.SyncedShelfBook():
        return 'SyncedShelfBook';
      case _ivzk7mwa.SyncBatchTooLargeException():
        return 'SyncBatchTooLargeException';
      case _ibtdwinl.SyncResult():
        return 'SyncResult';
      case _it8m259u.SyncWrite():
        return 'SyncWrite';
      case _itq42fc1.SyncedTheme():
        return 'SyncedTheme';
      case _ih8stdgt.SyncedThemeQuote():
        return 'SyncedThemeQuote';
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
    if (dataClassName == 'SyncLimits') {
      return deserialize<_ivlkv61n.SyncLimits>(data['data']);
    }
    if (dataClassName == 'AccountBlockedException') {
      return deserialize<_i42k8jky.AccountBlockedException>(data['data']);
    }
    if (dataClassName == 'Entitlement') {
      return deserialize<_id6kwse3.Entitlement>(data['data']);
    }
    if (dataClassName == 'EntitlementView') {
      return deserialize<_ik9sk60n.EntitlementView>(data['data']);
    }
    if (dataClassName == 'OcrQuotaExhaustedException') {
      return deserialize<_ik0msexu.OcrQuotaExhaustedException>(data['data']);
    }
    if (dataClassName == 'OcrResult') {
      return deserialize<_ib23r0hr.OcrResult>(data['data']);
    }
    if (dataClassName == 'OcrUnavailableException') {
      return deserialize<_ivem8n6h.OcrUnavailableException>(data['data']);
    }
    if (dataClassName == 'OcrUsage') {
      return deserialize<_i13b5r7e.OcrUsage>(data['data']);
    }
    if (dataClassName == 'SyncedBook') {
      return deserialize<_i8t9sm2n.SyncedBook>(data['data']);
    }
    if (dataClassName == 'SyncedQuote') {
      return deserialize<_ivf4v01a.SyncedQuote>(data['data']);
    }
    if (dataClassName == 'SyncedShelf') {
      return deserialize<_ibxgxncl.SyncedShelf>(data['data']);
    }
    if (dataClassName == 'SyncedShelfBook') {
      return deserialize<_isij2asi.SyncedShelfBook>(data['data']);
    }
    if (dataClassName == 'SyncBatchTooLargeException') {
      return deserialize<_ivzk7mwa.SyncBatchTooLargeException>(data['data']);
    }
    if (dataClassName == 'SyncResult') {
      return deserialize<_ibtdwinl.SyncResult>(data['data']);
    }
    if (dataClassName == 'SyncWrite') {
      return deserialize<_it8m259u.SyncWrite>(data['data']);
    }
    if (dataClassName == 'SyncedTheme') {
      return deserialize<_itq42fc1.SyncedTheme>(data['data']);
    }
    if (dataClassName == 'SyncedThemeQuote') {
      return deserialize<_ih8stdgt.SyncedThemeQuote>(data['data']);
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
