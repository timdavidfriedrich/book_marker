import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

const operationPut = 'put';
const operationPatch = 'patch';
const operationDelete = 'delete';

const _idColumn = 'id';
const _ownerColumn = 'owner_id';

/// Applies a device's CRUD batch to Postgres.
///
/// Three rules hold everywhere in here:
///
/// - `owner_id` comes from the session and is written over whatever the client
///   sent, and every statement is additionally scoped to it, so a forged id
///   cannot touch another account's row.
/// - Column names reach SQL only from the allowlist below, never from the
///   request. Values always go through parameters.
/// - A write the server will never accept is counted and reported, not thrown.
///   A 4xx would block the client's upload queue permanently, taking every
///   later write with it.
class SyncWrites {
  const SyncWrites();

  Future<SyncResult> apply(
    final Session session,
    final UuidValue ownerId,
    final List<SyncWrite> writes,
    final SyncLimits limits,
  ) async {
    if (writes.length > limits.maxWritesPerBatch) {
      // * unreachable for a client that chunks to the configured limit, so this
      // * is a hostile or broken one and should fail loudly rather than be
      // * silently truncated
      throw SyncBatchTooLargeException(
        size: writes.length,
        limit: limits.maxWritesPerBatch,
      );
    }

    final valid = <_ValidWrite>[];
    var rejected = 0;
    String? reason;
    for (final write in writes) {
      final result = _validate(write);
      switch (result) {
        case _ValidWrite():
          valid.add(result);
        case _RejectedWrite():
          rejected += 1;
          reason ??= result.reason;
      }
    }

    if (valid.isEmpty) {
      return SyncResult(
        applied: 0,
        rejected: rejected,
        rejectionReason: reason,
      );
    }

    // * one transaction for the whole batch, applied synchronously. PowerSync's
    // * checkpoint model treats a returned upload as durable, so queueing any
    // * of this for later would drop client writes on the floor
    await session.db.transaction((final transaction) async {
      final counts = await _rowCounts(session, ownerId, valid, transaction);
      for (final write in valid) {
        final overCap =
            write.operation == operationPut &&
            (counts[write.table] ?? 0) >= limits.maxRowsPerTable;
        if (overCap) {
          rejected += 1;
          reason ??= 'row limit reached for ${write.table}';
          continue;
        }
        await _execute(session, ownerId, write, transaction);
      }
    });

    return SyncResult(
      applied: valid.length - rejected,
      rejected: rejected,
      rejectionReason: reason,
    );
  }

  Future<Map<String, int>> _rowCounts(
    final Session session,
    final UuidValue ownerId,
    final List<_ValidWrite> writes,
    final Transaction transaction,
  ) async {
    final tables = writes
        .where((final write) => write.operation == operationPut)
        .map((final write) => write.table)
        .toSet();
    final counts = <String, int>{};
    for (final table in tables) {
      final rows = await session.db.unsafeQuery(
        'SELECT count(*) FROM "$table" WHERE "$_ownerColumn" = @owner',
        parameters: QueryParameters.named({'owner': ownerId.toString()}),
        transaction: transaction,
      );
      counts[table] = rows.first.first! as int;
    }
    return counts;
  }

  Future<void> _execute(
    final Session session,
    final UuidValue ownerId,
    final _ValidWrite write,
    final Transaction transaction,
  ) {
    final parameters = <String, Object?>{
      'id': write.rowId.toString(),
      'owner': ownerId.toString(),
      for (final entry in write.values.entries) 'v_${entry.key}': entry.value,
    };
    return session.db.unsafeQuery(
      switch (write.operation) {
        operationDelete => _deleteSql(write),
        operationPatch => _patchSql(write),
        _ => _putSql(write),
      },
      parameters: QueryParameters.named(parameters),
      transaction: transaction,
    );
  }

  String _deleteSql(final _ValidWrite write) =>
      'DELETE FROM "${write.table}" '
      'WHERE "$_idColumn" = @id::uuid AND "$_ownerColumn" = @owner::uuid';

  // * the WHERE on the conflict branch is what stops a client claiming a row id
  // * that already belongs to somebody else: the insert simply does nothing
  String _putSql(final _ValidWrite write) {
    final columns = write.values.keys.toList();
    final names = [
      '"$_idColumn"',
      '"$_ownerColumn"',
      ...columns.map((it) => '"$it"'),
    ];
    final values = ['@id::uuid', '@owner::uuid', ...columns.map(_placeholder)];
    final updates = columns.map((it) => '"$it" = EXCLUDED."$it"').join(', ');
    return 'INSERT INTO "${write.table}" (${names.join(', ')}) '
        'VALUES (${values.join(', ')}) '
        'ON CONFLICT ("$_idColumn") DO UPDATE SET $updates '
        'WHERE "${write.table}"."$_ownerColumn" = @owner::uuid';
  }

  String _patchSql(final _ValidWrite write) {
    final updates = write.values.keys
        .map((it) => '"$it" = ${_placeholder(it)}')
        .join(', ');
    return 'UPDATE "${write.table}" SET $updates '
        'WHERE "$_idColumn" = @id::uuid AND "$_ownerColumn" = @owner::uuid';
  }
}

String _placeholder(final String column) =>
    '@v_$column::${_columnTypes[column] ?? 'text'}';

_WriteOutcome _validate(final SyncWrite write) {
  final columns = _writableColumns[write.table];
  if (columns == null) {
    return _RejectedWrite('unknown table ${write.table}');
  }
  if (write.operation == operationDelete) {
    return _ValidWrite(
      table: write.table,
      operation: operationDelete,
      rowId: write.rowId,
      values: const {},
    );
  }
  if (write.operation != operationPut && write.operation != operationPatch) {
    return _RejectedWrite('unknown operation ${write.operation}');
  }

  final data = _decode(write.data);
  if (data == null) return _RejectedWrite('unreadable payload');

  final values = <String, String?>{};
  for (final entry in data.entries) {
    // * silently dropped rather than rejected: id and owner_id are always in a
    // * PowerSync put, and the server owns both
    if (entry.key == _idColumn || entry.key == _ownerColumn) continue;
    if (!columns.contains(entry.key)) {
      return _RejectedWrite(
        'column ${entry.key} is not writable on ${write.table}',
      );
    }
    values[entry.key] = _toText(entry.value);
  }

  final required = _requiredColumns[write.table] ?? const <String>{};
  if (write.operation == operationPut &&
      !values.keys.toSet().containsAll(required)) {
    return _RejectedWrite('incomplete row for ${write.table}');
  }
  if (values.isEmpty) return _RejectedWrite('nothing to write');

  return _ValidWrite(
    table: write.table,
    operation: write.operation,
    rowId: write.rowId,
    values: values,
  );
}

Map<String, Object?>? _decode(final String? data) {
  if (data == null) return null;
  try {
    final decoded = json.decode(data);
    return decoded is Map<String, dynamic> ? decoded : null;
  } on FormatException {
    return null;
  }
}

// * everything crosses as text and is cast per column, because PowerSync sends
// * a boolean as 1 or 0 and Postgres will not cast an integer to a boolean,
// * while it does accept '1'::boolean
String? _toText(final Object? value) => switch (value) {
  null => null,
  final bool it => it.toString(),
  final String it => it,
  _ => value.toString(),
};

sealed class _WriteOutcome {
  const _WriteOutcome();
}

class _ValidWrite extends _WriteOutcome {
  const _ValidWrite({
    required this.table,
    required this.operation,
    required this.rowId,
    required this.values,
  });

  final String table;
  final String operation;
  final UuidValue rowId;
  final Map<String, String?> values;
}

class _RejectedWrite extends _WriteOutcome {
  const _RejectedWrite(this.reason);

  final String reason;
}

const _columnTypes = <String, String>{
  'book_id': 'uuid',
  'shelf_id': 'uuid',
  'theme_id': 'uuid',
  'quote_id': 'uuid',
  'created_at': 'timestamp',
  'last_used_at': 'timestamp',
  'updated_at': 'timestamp',
  'key_version': 'bigint',
  'is_favorite': 'boolean',
};

// * `entitlements` is deliberately absent. It is server owned, so a write to it
// * is rejected rather than applied, and the device only ever reads it.
const _writableColumns = <String, Set<String>>{
  'books': {
    'status',
    'created_at',
    'last_used_at',
    'updated_at',
    'key_version',
    'title_cipher',
    'authors_cipher',
    'isbn_cipher',
    'cover_cipher',
  },
  'quotes': {
    'book_id',
    'is_favorite',
    'created_at',
    'updated_at',
    'key_version',
    'quote_cipher',
    'note_cipher',
    'page_numbers_cipher',
    'pages_cipher',
    'words_cipher',
    'marked_word_indexes_cipher',
    'voice_note_cipher',
  },
  'shelves': {
    'accent',
    'symbol',
    'created_at',
    'updated_at',
    'key_version',
    'name_cipher',
  },
  'themes': {
    'accent',
    'symbol',
    'created_at',
    'updated_at',
    'key_version',
    'name_cipher',
  },
  'shelf_books': {'shelf_id', 'book_id', 'updated_at'},
  'theme_quotes': {'theme_id', 'quote_id', 'updated_at'},
};

const _requiredColumns = <String, Set<String>>{
  'books': {
    'status',
    'created_at',
    'last_used_at',
    'updated_at',
    'key_version',
    'title_cipher',
    'authors_cipher',
  },
  'quotes': {
    'book_id',
    'is_favorite',
    'created_at',
    'updated_at',
    'key_version',
    'quote_cipher',
    'page_numbers_cipher',
    'pages_cipher',
    'words_cipher',
    'marked_word_indexes_cipher',
  },
  'shelves': {'created_at', 'updated_at', 'key_version', 'name_cipher'},
  'themes': {'created_at', 'updated_at', 'key_version', 'name_cipher'},
  'shelf_books': {'shelf_id', 'book_id', 'updated_at'},
  'theme_quotes': {'theme_id', 'quote_id', 'updated_at'},
};
