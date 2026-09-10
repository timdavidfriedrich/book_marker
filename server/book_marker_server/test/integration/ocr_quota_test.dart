import 'package:book_marker_server/src/domain/ocr_quota.dart';
import 'package:book_marker_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const quota = OcrQuota();
final threePerDay = PlanLimits(
  ocrPerDay: 3,
  ocrPerWeek: 10,
  ocrPerMonth: 20,
  maxImageBytes: 2097152,
  attachmentsEnabled: false,
);

void main() {
  withServerpod('Given the cloud OCR quota', (sessionBuilder, endpoints) {
    test('when the day limit is reached then admission is refused', () async {
      final session = sessionBuilder.build();
      final owner = UuidValue.fromString(
        '77777777-7777-4777-8777-000000000001',
      );

      final granted = <UuidValue>[];
      for (var attempt = 0; attempt < 4; attempt += 1) {
        final id = await quota.reserve(session, owner, threePerDay, 'echo');
        if (id != null) granted.add(id);
      }

      expect(granted.length, 3);
      expect((await quota.countUsage(session, owner)).day, 3);
    });

    test('when a scan fails then the slot comes back', () async {
      final session = sessionBuilder.build();
      final owner = UuidValue.fromString(
        '77777777-7777-4777-8777-000000000002',
      );

      final first = await quota.reserve(session, owner, threePerDay, 'echo');
      await quota.release(session, first!);

      expect((await quota.countUsage(session, owner)).day, 0);
      expect(
        await quota.reserve(session, owner, threePerDay, 'echo'),
        isNotNull,
      );
    });

    test(
      'when a scan completes then the entitlement counters are rewritten',
      () async {
        final session = sessionBuilder.build();
        final owner = UuidValue.fromString(
          '77777777-7777-4777-8777-000000000003',
        );
        await Entitlement.db.insertRow(
          session,
          Entitlement(
            ownerId: owner,
            plan: 'free',
            status: 'active',
            usedDay: 0,
            usedWeek: 0,
            usedMonth: 0,
            updatedAt: DateTime.now().toUtc(),
          ),
        );

        final id = await quota.reserve(session, owner, threePerDay, 'echo');
        final counts = await quota.complete(
          session,
          owner,
          id!,
          inputTokens: 1083,
          outputTokens: 412,
        );

        expect(counts.day, 1);
        final row = await Entitlement.db.findFirstRow(
          session,
          where: (t) => t.ownerId.equals(owner),
        );
        expect(row!.usedDay, 1);
        expect(row.usedMonth, 1);
        final usage = await OcrUsage.db.findById(session, id);
        expect(usage!.status, ocrCompleted);
        expect(usage.inputTokens, 1083);
      },
    );

    test(
      'when a reservation goes stale then the next attempt frees it',
      () async {
        final session = sessionBuilder.build();
        final owner = UuidValue.fromString(
          '77777777-7777-4777-8777-000000000004',
        );
        for (var attempt = 0; attempt < 3; attempt += 1) {
          await OcrUsage.db.insertRow(
            session,
            OcrUsage(
              ownerId: owner,
              createdAt: DateTime.now().toUtc().subtract(
                const Duration(minutes: 30),
              ),
              engine: 'echo',
              status: ocrReserved,
            ),
          );
        }
        expect((await quota.countUsage(session, owner)).day, 3);

        expect(
          await quota.reserve(session, owner, threePerDay, 'echo'),
          isNotNull,
        );
        expect((await quota.countUsage(session, owner)).day, 1);
      },
    );
  });

  withServerpod(
    'Given five concurrent scans and one slot left',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      test('when they race then exactly one is admitted', () async {
        final session = sessionBuilder.build();
        final owner = UuidValue.fromString(
          '88888888-8888-4888-8888-000000000001',
        );
        await OcrUsage.db.deleteWhere(
          session,
          where: (t) => t.ownerId.equals(owner),
        );

        final oneLeft = PlanLimits(
          ocrPerDay: 1,
          ocrPerWeek: 10,
          ocrPerMonth: 20,
          maxImageBytes: 2097152,
          attachmentsEnabled: false,
        );

        final results = await Future.wait([
          for (var attempt = 0; attempt < 5; attempt += 1)
            quota.reserve(sessionBuilder.build(), owner, oneLeft, 'echo'),
        ]);

        expect(results.whereType<UuidValue>().length, 1);
        expect((await quota.countUsage(session, owner)).day, 1);
        await OcrUsage.db.deleteWhere(
          session,
          where: (t) => t.ownerId.equals(owner),
        );
      });
    },
  );
}
