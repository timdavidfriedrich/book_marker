import 'package:book_marker_server/src/domain/entitlements.dart';
import 'package:book_marker_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const entitlements = Entitlements();

void main() {
  withServerpod('Given registerBackup', (sessionBuilder, endpoints) {
    test(
      'when registering twice then the second call does not overwrite',
      () async {
        final session = sessionBuilder.build();
        final ownerId = UuidValue.fromString(
          '22222222-2222-4222-8222-222222222222',
        );
        await entitlements.createForUser(session, ownerId, transaction: null);

        final first = await entitlements.registerBackup(
          session,
          ownerId,
          'first',
        );
        final second = await entitlements.registerBackup(
          session,
          ownerId,
          'second',
        );

        expect(first.backupVerifier, 'first');
        expect(second.backupVerifier, 'first');
        expect(second.backupInitializedAt, first.backupInitializedAt);
      },
    );

    test(
      'when no backup exists then the view reports a null verifier',
      () async {
        final session = sessionBuilder.build();
        final ownerId = UuidValue.fromString(
          '33333333-3333-4333-8333-333333333333',
        );
        final row = await entitlements.createForUser(
          session,
          ownerId,
          transaction: null,
        );
        expect(entitlements.toView(row).backupVerifier, isNull);
        expect(entitlements.toView(row).plan, planFree);
        expect(entitlements.toView(row).status, statusActive);
      },
    );
  });

  withServerpod(
    'Given two devices registering at once',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      test('when both find no verifier then exactly one wins', () async {
        final session = sessionBuilder.build();
        final ownerId = UuidValue.fromString(
          '11111111-1111-4111-8111-111111111111',
        );
        await Entitlement.db.deleteWhere(
          session,
          where: (t) => t.ownerId.equals(ownerId),
        );
        await entitlements.createForUser(session, ownerId, transaction: null);

        final results = await Future.wait([
          entitlements.registerBackup(
            sessionBuilder.build(),
            ownerId,
            'device-a',
          ),
          entitlements.registerBackup(
            sessionBuilder.build(),
            ownerId,
            'device-b',
          ),
        ]);

        final winners = results.map((row) => row.backupVerifier).toSet();
        expect(
          winners.length,
          1,
          reason: 'both callers must see the same verifier',
        );
        expect(winners.single, anyOf('device-a', 'device-b'));

        final stored = await entitlements.findForUser(session, ownerId);
        expect(stored!.backupVerifier, winners.single);
        expect(stored.backupInitializedAt, isNotNull);

        await Entitlement.db.deleteWhere(
          session,
          where: (t) => t.ownerId.equals(ownerId),
        );
      });
    },
  );
}
