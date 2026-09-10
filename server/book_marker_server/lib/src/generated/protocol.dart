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
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'config/client_config.dart' as _ikmgnzhy;
import 'config/plan_limits.dart' as _ios57rmt;
import 'config/recognition_config.dart' as _i96enlzs;
import 'config/runtime_config.dart' as _iadewe5j;
import 'entitlements/account_blocked_exception.dart' as _i42k8jky;
import 'entitlements/entitlement.dart' as _id6kwse3;
import 'entitlements/entitlement_view.dart' as _ik9sk60n;
import 'entitlements/ocr_usage.dart' as _i13b5r7e;
import 'sync/book.dart' as _i8t9sm2n;
import 'sync/quote.dart' as _ivf4v01a;
import 'sync/shelf.dart' as _ibxgxncl;
import 'sync/shelf_book.dart' as _isij2asi;
import 'sync/theme.dart' as _itq42fc1;
import 'sync/theme_quote.dart' as _ih8stdgt;
export 'config/client_config.dart';
export 'config/plan_limits.dart';
export 'config/recognition_config.dart';
export 'config/runtime_config.dart';
export 'entitlements/account_blocked_exception.dart';
export 'entitlements/entitlement.dart';
export 'entitlements/entitlement_view.dart';
export 'entitlements/ocr_usage.dart';
export 'sync/book.dart';
export 'sync/quote.dart';
export 'sync/shelf.dart';
export 'sync/shelf_book.dart';
export 'sync/theme.dart';
export 'sync/theme_quote.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'books',
      dartName: 'SyncedBook',
      schema: 'public',
      module: 'book_marker',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
          columnDefault: 'random',
        ),
        _isp.ColumnDefinition(
          name: 'owner_id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'created_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'last_used_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updated_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'key_version',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _isp.ColumnDefinition(
          name: 'title_cipher',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'authors_cipher',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'isbn_cipher',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'cover_cipher',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'books_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'owner_id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'entitlements',
      dartName: 'Entitlement',
      schema: 'public',
      module: 'book_marker',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
          columnDefault: 'random',
        ),
        _isp.ColumnDefinition(
          name: 'owner_id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'plan',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'free\'',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'active\'',
        ),
        _isp.ColumnDefinition(
          name: 'blocked_reason',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'blocked_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'backup_verifier',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'backup_initialized_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'used_day',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'used_week',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'used_month',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'updated_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'store',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'product_id',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'purchase_token',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'purchased_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'refunded_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'entitlements_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'owner_id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'ocr_usage',
      dartName: 'OcrUsage',
      schema: 'public',
      module: 'book_marker',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
          columnDefault: 'random',
        ),
        _isp.ColumnDefinition(
          name: 'owner_id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'created_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'engine',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'reserved\'',
        ),
        _isp.ColumnDefinition(
          name: 'input_tokens',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'output_tokens',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'ocr_usage_owner_time_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'owner_id',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'created_at',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'quotes',
      dartName: 'SyncedQuote',
      schema: 'public',
      module: 'book_marker',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
          columnDefault: 'random',
        ),
        _isp.ColumnDefinition(
          name: 'owner_id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'book_id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'is_favorite',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'created_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updated_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'key_version',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _isp.ColumnDefinition(
          name: 'quote_cipher',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'note_cipher',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'page_numbers_cipher',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'pages_cipher',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'words_cipher',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'marked_word_indexes_cipher',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'voice_note_cipher',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'quotes_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'owner_id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'quotes_book_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'book_id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'shelf_books',
      dartName: 'SyncedShelfBook',
      schema: 'public',
      module: 'book_marker',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
          columnDefault: 'random',
        ),
        _isp.ColumnDefinition(
          name: 'owner_id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'shelf_id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'book_id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'updated_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'shelf_books_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'owner_id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'shelf_books_pair_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'shelf_id',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'book_id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'shelves',
      dartName: 'SyncedShelf',
      schema: 'public',
      module: 'book_marker',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
          columnDefault: 'random',
        ),
        _isp.ColumnDefinition(
          name: 'owner_id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'accent',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'symbol',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'created_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updated_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'key_version',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _isp.ColumnDefinition(
          name: 'name_cipher',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'shelves_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'owner_id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'theme_quotes',
      dartName: 'SyncedThemeQuote',
      schema: 'public',
      module: 'book_marker',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
          columnDefault: 'random',
        ),
        _isp.ColumnDefinition(
          name: 'owner_id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'theme_id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'quote_id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'updated_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'theme_quotes_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'owner_id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'theme_quotes_pair_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'theme_id',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'quote_id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'themes',
      dartName: 'SyncedTheme',
      schema: 'public',
      module: 'book_marker',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
          columnDefault: 'random',
        ),
        _isp.ColumnDefinition(
          name: 'owner_id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'accent',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'symbol',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'created_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updated_at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'key_version',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _isp.ColumnDefinition(
          name: 'name_cipher',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'themes_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'owner_id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

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
      } on _is.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _ik9sk60n.EntitlementView) {
      return _ik9sk60n.EntitlementView.fromJson(data) as T;
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
    if (t == _itq42fc1.SyncedTheme) {
      return _itq42fc1.SyncedTheme.fromJson(data) as T;
    }
    if (t == _ih8stdgt.SyncedThemeQuote) {
      return _ih8stdgt.SyncedThemeQuote.fromJson(data) as T;
    }
    if (t == _is.getType<_ikmgnzhy.ClientConfig?>()) {
      return (data != null ? _ikmgnzhy.ClientConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ios57rmt.PlanLimits?>()) {
      return (data != null ? _ios57rmt.PlanLimits.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i96enlzs.RecognitionConfig?>()) {
      return (data != null ? _i96enlzs.RecognitionConfig.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iadewe5j.RuntimeConfig?>()) {
      return (data != null ? _iadewe5j.RuntimeConfig.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i42k8jky.AccountBlockedException?>()) {
      return (data != null
              ? _i42k8jky.AccountBlockedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_id6kwse3.Entitlement?>()) {
      return (data != null ? _id6kwse3.Entitlement.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ik9sk60n.EntitlementView?>()) {
      return (data != null ? _ik9sk60n.EntitlementView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i13b5r7e.OcrUsage?>()) {
      return (data != null ? _i13b5r7e.OcrUsage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8t9sm2n.SyncedBook?>()) {
      return (data != null ? _i8t9sm2n.SyncedBook.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ivf4v01a.SyncedQuote?>()) {
      return (data != null ? _ivf4v01a.SyncedQuote.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ibxgxncl.SyncedShelf?>()) {
      return (data != null ? _ibxgxncl.SyncedShelf.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_isij2asi.SyncedShelfBook?>()) {
      return (data != null ? _isij2asi.SyncedShelfBook.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_itq42fc1.SyncedTheme?>()) {
      return (data != null ? _itq42fc1.SyncedTheme.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ih8stdgt.SyncedThemeQuote?>()) {
      return (data != null ? _ih8stdgt.SyncedThemeQuote.fromJson(data) : null)
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
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
      _ik9sk60n.EntitlementView => 'EntitlementView',
      _i13b5r7e.OcrUsage => 'OcrUsage',
      _i8t9sm2n.SyncedBook => 'SyncedBook',
      _ivf4v01a.SyncedQuote => 'SyncedQuote',
      _ibxgxncl.SyncedShelf => 'SyncedShelf',
      _isij2asi.SyncedShelfBook => 'SyncedShelfBook',
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
      case _i42k8jky.AccountBlockedException():
        return 'AccountBlockedException';
      case _id6kwse3.Entitlement():
        return 'Entitlement';
      case _ik9sk60n.EntitlementView():
        return 'EntitlementView';
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
      case _itq42fc1.SyncedTheme():
        return 'SyncedTheme';
      case _ih8stdgt.SyncedThemeQuote():
        return 'SyncedThemeQuote';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
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
    if (dataClassName == 'EntitlementView') {
      return deserialize<_ik9sk60n.EntitlementView>(data['data']);
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
    if (dataClassName == 'SyncedTheme') {
      return deserialize<_itq42fc1.SyncedTheme>(data['data']);
    }
    if (dataClassName == 'SyncedThemeQuote') {
      return deserialize<_ih8stdgt.SyncedThemeQuote>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('book_marker', this);
    _iacs.Protocol().registerHostProtocol('book_marker', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _id6kwse3.Entitlement:
        return _id6kwse3.Entitlement.t;
      case _i13b5r7e.OcrUsage:
        return _i13b5r7e.OcrUsage.t;
      case _i8t9sm2n.SyncedBook:
        return _i8t9sm2n.SyncedBook.t;
      case _ivf4v01a.SyncedQuote:
        return _ivf4v01a.SyncedQuote.t;
      case _ibxgxncl.SyncedShelf:
        return _ibxgxncl.SyncedShelf.t;
      case _isij2asi.SyncedShelfBook:
        return _isij2asi.SyncedShelfBook.t;
      case _itq42fc1.SyncedTheme:
        return _itq42fc1.SyncedTheme.t;
      case _ih8stdgt.SyncedThemeQuote:
        return _ih8stdgt.SyncedThemeQuote.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

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
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
