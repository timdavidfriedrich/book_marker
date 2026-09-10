import 'dart:convert';

import 'package:book_marker_server/src/domain/sync_writes.dart';
import 'package:book_marker_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const writes = SyncWrites();
final limits = SyncLimits(maxWritesPerBatch: 500, maxRowsPerTable: 100000);

final owner = UuidValue.fromString('44444444-4444-4444-8444-444444444444');
final intruder = UuidValue.fromString('55555555-5555-4555-8555-555555555555');

SyncWrite put(String table, UuidValue id, Map<String, Object?> data) =>
    SyncWrite(
      table: table,
      operation: operationPut,
      rowId: id,
      data: json.encode(data),
    );

Map<String, Object?> book({
  String status = 'reading',
  String title = 'CIPHER',
}) => {
  'status': status,
  'created_at': '2026-09-10T10:00:00.000000',
  'last_used_at': '2026-09-10T10:00:00.000000',
  'updated_at': '2026-09-10T10:00:00.000000',
  'key_version': 1,
  'title_cipher': title,
  'authors_cipher': 'AUTHORS',
};

void main() {
  withServerpod('Given a sync batch', (sessionBuilder, endpoints) {
    test('when a book is put then it lands with the session owner', () async {
      final session = sessionBuilder.build();
      final id = UuidValue.fromString('a0000000-0000-4000-8000-000000000001');
      final result = await writes.apply(session, owner, [
        put('books', id, book()),
      ], limits);

      expect(result.applied, 1);
      expect(result.rejected, 0);
      final row = await SyncedBook.db.findById(session, id);
      expect(row!.ownerId, owner);
      expect(row.titleCipher, 'CIPHER');
      expect(row.createdAt, DateTime.utc(2026, 9, 10, 10));
    });

    test('when the client sends an owner then the session wins', () async {
      final session = sessionBuilder.build();
      final id = UuidValue.fromString('a0000000-0000-4000-8000-000000000002');
      final forged = {...book(), 'owner_id': intruder.toString()};
      final result = await writes.apply(session, owner, [
        put('books', id, forged),
      ], limits);

      expect(result.applied, 1);
      expect((await SyncedBook.db.findById(session, id))!.ownerId, owner);
    });

    test('when a put targets another owner row then nothing changes', () async {
      final session = sessionBuilder.build();
      final id = UuidValue.fromString('a0000000-0000-4000-8000-000000000003');
      await writes.apply(session, owner, [
        put('books', id, book(title: 'MINE')),
      ], limits);
      await writes.apply(session, intruder, [
        put('books', id, book(title: 'STOLEN')),
      ], limits);

      expect((await SyncedBook.db.findById(session, id))!.titleCipher, 'MINE');
    });

    test('when a boolean arrives as 1 then it is stored as true', () async {
      final session = sessionBuilder.build();
      final id = UuidValue.fromString('b0000000-0000-4000-8000-000000000001');
      final result = await writes.apply(session, owner, [
        put('quotes', id, {
          'book_id': 'a0000000-0000-4000-8000-000000000001',
          'is_favorite': 1,
          'created_at': '2026-09-10T10:00:00.000000',
          'updated_at': '2026-09-10T10:00:00.000000',
          'key_version': 1,
          'quote_cipher': 'Q',
          'page_numbers_cipher': 'P',
          'pages_cipher': 'PG',
          'words_cipher': 'W',
          'marked_word_indexes_cipher': 'M',
        }),
      ], limits);

      expect(result.applied, 1);
      expect((await SyncedQuote.db.findById(session, id))!.isFavorite, isTrue);
    });

    test('when a patch touches one column then the rest survives', () async {
      final session = sessionBuilder.build();
      final id = UuidValue.fromString('a0000000-0000-4000-8000-000000000004');
      await writes.apply(session, owner, [
        put('books', id, book(title: 'KEEP')),
      ], limits);
      final result = await writes.apply(session, owner, [
        SyncWrite(
          table: 'books',
          operation: operationPatch,
          rowId: id,
          data: json.encode({'status': 'finished'}),
        ),
      ], limits);

      expect(result.applied, 1);
      final row = await SyncedBook.db.findById(session, id);
      expect(row!.status, 'finished');
      expect(row.titleCipher, 'KEEP');
    });

    test('when a delete belongs to another owner then the row stays', () async {
      final session = sessionBuilder.build();
      final id = UuidValue.fromString('a0000000-0000-4000-8000-000000000005');
      await writes.apply(session, owner, [put('books', id, book())], limits);
      await writes.apply(session, intruder, [
        SyncWrite(
          table: 'books',
          operation: operationDelete,
          rowId: id,
          data: null,
        ),
      ], limits);
      expect(await SyncedBook.db.findById(session, id), isNotNull);

      await writes.apply(session, owner, [
        SyncWrite(
          table: 'books',
          operation: operationDelete,
          rowId: id,
          data: null,
        ),
      ], limits);
      expect(await SyncedBook.db.findById(session, id), isNull);
    });

    test(
      'when the batch is unacceptable then it is reported, not thrown',
      () async {
        final session = sessionBuilder.build();
        final id = UuidValue.fromString('c0000000-0000-4000-8000-000000000001');

        final unknownTable = await writes.apply(session, owner, [
          put('secrets', id, {'a': 'b'}),
        ], limits);
        expect(unknownTable.rejected, 1);
        expect(unknownTable.rejectionReason, contains('unknown table'));

        final serverOwned = await writes.apply(session, owner, [
          put('entitlements', id, {'plan': 'premium'}),
        ], limits);
        expect(serverOwned.rejected, 1);

        final badColumn = await writes.apply(session, owner, [
          put('books', id, {...book(), 'plan': 'premium'}),
        ], limits);
        expect(badColumn.rejected, 1);
        expect(badColumn.rejectionReason, contains('not writable'));

        final incomplete = await writes.apply(session, owner, [
          put('books', id, {'status': 'reading'}),
        ], limits);
        expect(incomplete.rejected, 1);
        expect(incomplete.rejectionReason, contains('incomplete'));

        expect(await SyncedBook.db.findById(session, id), isNull);
      },
    );

    test('when the batch is oversized then it throws', () async {
      final session = sessionBuilder.build();
      final id = UuidValue.fromString('d0000000-0000-4000-8000-000000000001');
      expect(
        () => writes.apply(
          session,
          owner,
          [put('books', id, book()), put('books', id, book())],
          SyncLimits(maxWritesPerBatch: 1, maxRowsPerTable: 10),
        ),
        throwsA(isA<SyncBatchTooLargeException>()),
      );
    });

    test('when the row cap is reached then further puts are refused', () async {
      final session = sessionBuilder.build();
      final capped = SyncLimits(maxWritesPerBatch: 500, maxRowsPerTable: 1);
      final first = UuidValue.fromString(
        'e0000000-0000-4000-8000-000000000001',
      );
      final second = UuidValue.fromString(
        'e0000000-0000-4000-8000-000000000002',
      );
      final owner = UuidValue.fromString(
        '66666666-6666-4666-8666-666666666666',
      );

      await writes.apply(session, owner, [put('books', first, book())], capped);
      final result = await writes.apply(session, owner, [
        put('books', second, book()),
      ], capped);
      expect(result.rejected, 1);
      expect(result.rejectionReason, contains('row limit'));
      expect(await SyncedBook.db.findById(session, second), isNull);
    });
  });
}
