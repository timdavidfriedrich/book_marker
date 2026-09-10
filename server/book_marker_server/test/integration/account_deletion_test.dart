import 'dart:convert';

import 'package:book_marker_server/src/domain/account_deletion.dart';
import 'package:book_marker_server/src/domain/entitlements.dart';
import 'package:book_marker_server/src/domain/ocr_quota.dart';
import 'package:book_marker_server/src/domain/sync_writes.dart';
import 'package:book_marker_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const deletion = AccountDeletion();
const writes = SyncWrites();
const entitlements = Entitlements();

final limits = SyncLimits(maxWritesPerBatch: 500, maxRowsPerTable: 100000);

void main() {
  withServerpod('Given account deletion', (sessionBuilder, endpoints) {
    test(
      'when it runs then every owned row goes and the neighbours stay',
      () async {
        final session = sessionBuilder.build();
        final mine = await const AuthUsers().create(session);
        final theirs = await const AuthUsers().create(session);

        Future<void> seed(UuidValue owner, String title) async {
          await entitlements.createForUser(session, owner, transaction: null);
          await OcrUsage.db.insertRow(
            session,
            OcrUsage(
              ownerId: owner,
              createdAt: DateTime.now().toUtc(),
              engine: 'echo',
              status: ocrCompleted,
            ),
          );
          await writes.apply(session, owner, [
            SyncWrite(
              table: 'books',
              operation: operationPut,
              rowId: UuidValue.fromString(
                '00000000-0000-4000-8000-${owner.toString().substring(24)}',
              ),
              data: json.encode({
                'status': 'reading',
                'created_at': '2026-09-10T10:00:00.000000',
                'last_used_at': '2026-09-10T10:00:00.000000',
                'updated_at': '2026-09-10T10:00:00.000000',
                'key_version': 1,
                'title_cipher': title,
                'authors_cipher': 'A',
              }),
            ),
          ], limits);
        }

        await seed(mine.id, 'MINE');
        await seed(theirs.id, 'THEIRS');

        await deletion.delete(session, mine.id);

        expect(
          await SyncedBook.db.find(
            session,
            where: (t) => t.ownerId.equals(mine.id),
          ),
          isEmpty,
        );
        expect(
          await OcrUsage.db.find(
            session,
            where: (t) => t.ownerId.equals(mine.id),
          ),
          isEmpty,
        );
        expect(await entitlements.findForUser(session, mine.id), isNull);
        expect(await AuthUser.db.findById(session, mine.id), isNull);

        final survivors = await SyncedBook.db.find(
          session,
          where: (t) => t.ownerId.equals(theirs.id),
        );
        expect(survivors.single.titleCipher, 'THEIRS');
        expect(await entitlements.findForUser(session, theirs.id), isNotNull);
        expect(await AuthUser.db.findById(session, theirs.id), isNotNull);
      },
    );
  });
}
