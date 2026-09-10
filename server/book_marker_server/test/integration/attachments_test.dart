import 'dart:typed_data';

import 'package:book_marker_server/src/domain/attachments.dart';
import 'package:book_marker_server/src/domain/entitlements.dart';
import 'package:book_marker_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const attachments = Attachments();
const entitlements = Entitlements();

ByteData bytesOf(String value) =>
    ByteData.view(Uint8List.fromList(value.codeUnits).buffer);

String stringOf(ByteData data) => String.fromCharCodes(
  data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
);

Future<void> setPlan(Session session, UuidValue owner, String plan) async {
  final row = await entitlements.ensureForUser(
    session,
    owner,
    transaction: null,
  );
  await Entitlement.db.updateRow(session, row.copyWith(plan: plan));
}

void main() {
  withServerpod('Given attachment storage', (sessionBuilder, endpoints) {
    test('when premium then a blob round trips and stays opaque', () async {
      final session = sessionBuilder.build();
      final owner = UuidValue.fromString(
        '99999999-9999-4999-8999-000000000001',
      );
      await setPlan(session, owner, planPremium);

      await attachments.store(
        session,
        owner,
        'page-one',
        bytesOf('CIPHERTEXT-BLOB'),
      );
      final loaded = await attachments.load(session, owner, 'page-one');
      expect(stringOf(loaded), 'CIPHERTEXT-BLOB');

      await attachments.remove(session, owner, 'page-one');
      expect(
        () => attachments.load(session, owner, 'page-one'),
        throwsA(anything),
      );
    });

    test('when free then uploading is refused permanently', () async {
      final session = sessionBuilder.build();
      final owner = UuidValue.fromString(
        '99999999-9999-4999-8999-000000000002',
      );
      await setPlan(session, owner, planFree);

      expect(
        () => attachments.store(session, owner, 'page-one', bytesOf('X')),
        throwsA(isA<AttachmentNotEntitledException>()),
      );
    });

    test('when a plan lapses then existing blobs stay readable', () async {
      final session = sessionBuilder.build();
      final owner = UuidValue.fromString(
        '99999999-9999-4999-8999-000000000003',
      );
      await setPlan(session, owner, planPremium);
      await attachments.store(session, owner, 'kept', bytesOf('STILL-MINE'));

      await setPlan(session, owner, planFree);
      expect(
        stringOf(await attachments.load(session, owner, 'kept')),
        'STILL-MINE',
      );
      expect(
        () => attachments.store(session, owner, 'new-one', bytesOf('X')),
        throwsA(isA<AttachmentNotEntitledException>()),
      );
    });

    test('when blocked then nothing is readable or writable', () async {
      final session = sessionBuilder.build();
      final owner = UuidValue.fromString(
        '99999999-9999-4999-8999-000000000004',
      );
      await setPlan(session, owner, planPremium);
      await attachments.store(session, owner, 'before', bytesOf('X'));

      final row = await entitlements.findForUser(session, owner);
      await Entitlement.db.updateRow(
        session,
        row!.copyWith(status: statusBlocked),
      );

      expect(
        () => attachments.load(session, owner, 'before'),
        throwsA(isA<AccountBlockedException>()),
      );
      expect(
        () => attachments.store(session, owner, 'after', bytesOf('X')),
        throwsA(isA<AccountBlockedException>()),
      );
    });

    test(
      'when the id could climb out of the prefix then it is refused',
      () async {
        final session = sessionBuilder.build();
        final owner = UuidValue.fromString(
          '99999999-9999-4999-8999-000000000005',
        );
        await setPlan(session, owner, planPremium);

        for (final id in ['../other-owner/secret', 'a/b', '', 'x' * 65]) {
          expect(
            () => attachments.store(session, owner, id, bytesOf('X')),
            throwsA(isA<AttachmentNotEntitledException>()),
            reason: 'id "$id" must be refused',
          );
        }
      },
    );

    test('when a blob is stored twice then it is indexed once', () async {
      final session = sessionBuilder.build();
      final owner = UuidValue.fromString(
        '99999999-9999-4999-8999-000000000008',
      );
      await setPlan(session, owner, planPremium);

      await attachments.store(session, owner, 'page', bytesOf('SHORT'));
      await attachments.store(session, owner, 'page', bytesOf('LONGER-BLOB'));

      final rows = await AttachmentObject.db.find(
        session,
        where: (t) => t.ownerId.equals(owner),
      );
      expect(rows.length, 1);
      expect(rows.single.sizeBytes, 'LONGER-BLOB'.length);
      expect(
        await attachments.storedBytes(session, owner),
        'LONGER-BLOB'.length,
      );

      await attachments.removeAll(session, owner);
      expect(await attachments.storedBytes(session, owner), 0);
      expect(
        () => attachments.load(session, owner, 'page'),
        throwsA(anything),
      );
    });

    test(
      'when two owners use the same id then the blobs do not collide',
      () async {
        final session = sessionBuilder.build();
        final mine = UuidValue.fromString(
          '99999999-9999-4999-8999-000000000006',
        );
        final theirs = UuidValue.fromString(
          '99999999-9999-4999-8999-000000000007',
        );
        await setPlan(session, mine, planPremium);
        await setPlan(session, theirs, planPremium);

        await attachments.store(session, mine, 'shared-id', bytesOf('MINE'));
        await attachments.store(
          session,
          theirs,
          'shared-id',
          bytesOf('THEIRS'),
        );

        expect(
          stringOf(await attachments.load(session, mine, 'shared-id')),
          'MINE',
        );
        expect(
          stringOf(await attachments.load(session, theirs, 'shared-id')),
          'THEIRS',
        );
      },
    );
  });
}
