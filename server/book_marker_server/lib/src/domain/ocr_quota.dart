import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'owner_lock.dart';

const ocrReserved = 'reserved';
const ocrCompleted = 'completed';
const ocrFailed = 'failed';

// * a request that crashed between reserving and completing would otherwise
// * hold its slot forever. Released the next time the same user asks, which is
// * exactly when it matters and needs no scheduler to be running
const _staleReservation = Duration(minutes: 5);

class OcrUsageCounts {
  const OcrUsageCounts({
    required this.day,
    required this.week,
    required this.month,
  });

  final int day;
  final int week;
  final int month;

  bool exceeds(final PlanLimits limits) =>
      day >= limits.ocrPerDay ||
      week >= limits.ocrPerWeek ||
      month >= limits.ocrPerMonth;
}

/// Gate 1: admission to cloud recognition.
///
/// The whole point is the advisory lock. Without it two concurrent requests
/// both read `used_day = 2` against a limit of 3, both pass, and both scan:
/// under READ COMMITTED neither sees the other's uncommitted insert, so
/// counting from a log does not fix it by itself.
///
/// The provider call happens OUTSIDE this transaction. It is a multi-second
/// round trip to another company's servers, and holding a per-user lock across
/// it would serialise a user's scans behind the slowest one.
class OcrQuota {
  const OcrQuota();

  /// Returns the id of the reservation, or null when a window is full.
  Future<UuidValue?> reserve(
    final Session session,
    final UuidValue ownerId,
    final PlanLimits limits,
    final String engine,
  ) {
    return session.db.transaction((final transaction) async {
      await lockOwner(session, ownerId, transaction);
      await _releaseStale(session, ownerId, transaction);
      final counts = await countUsage(
        session,
        ownerId,
        transaction: transaction,
      );
      if (counts.exceeds(limits)) return null;
      final row = await OcrUsage.db.insertRow(
        session,
        OcrUsage(
          ownerId: ownerId,
          createdAt: DateTime.now().toUtc(),
          engine: engine,
          status: ocrReserved,
        ),
        transaction: transaction,
      );
      return row.id;
    });
  }

  /// Marks the reservation used and rewrites the counters the device reads.
  Future<OcrUsageCounts> complete(
    final Session session,
    final UuidValue ownerId,
    final UuidValue requestId, {
    required final int? inputTokens,
    required final int? outputTokens,
  }) async {
    await _setStatus(
      session,
      requestId,
      ocrCompleted,
      inputTokens: inputTokens,
      outputTokens: outputTokens,
    );
    final counts = await countUsage(session, ownerId);
    await _writeCounters(session, ownerId, counts);
    return counts;
  }

  /// Hands the slot back after a provider failure, so a scan that never
  /// happened does not cost the user anything.
  Future<void> release(final Session session, final UuidValue requestId) =>
      _setStatus(
        session,
        requestId,
        ocrFailed,
        inputTokens: null,
        outputTokens: null,
      );

  // * rolling windows, not calendar ones: one query, three counts, and no burst
  // * at midnight. `failed` is excluded, `reserved` is not, so a scan in flight
  // * holds its slot
  Future<OcrUsageCounts> countUsage(
    final Session session,
    final UuidValue ownerId, {
    final Transaction? transaction,
  }) async {
    final rows = await session.db.unsafeQuery(
      "SELECT "
      "count(*) FILTER (WHERE created_at > now() - interval '1 day') AS used_day, "
      "count(*) FILTER (WHERE created_at > now() - interval '7 days') AS used_week, "
      "count(*) FILTER (WHERE created_at > now() - interval '30 days') AS used_month "
      'FROM ocr_usage WHERE owner_id = @owner::uuid AND status <> @failed',
      parameters: QueryParameters.named({
        'owner': ownerId.toString(),
        'failed': ocrFailed,
      }),
      transaction: transaction,
    );
    final row = rows.first;
    return OcrUsageCounts(
      day: row[0]! as int,
      week: row[1]! as int,
      month: row[2]! as int,
    );
  }

  Future<void> _releaseStale(
    final Session session,
    final UuidValue ownerId,
    final Transaction transaction,
  ) async {
    await session.db.unsafeQuery(
      'UPDATE ocr_usage SET status = @failed '
      'WHERE owner_id = @owner::uuid AND status = @reserved '
      "AND created_at < now() - interval '${_staleReservation.inMinutes} minutes'",
      parameters: QueryParameters.named({
        'owner': ownerId.toString(),
        'failed': ocrFailed,
        'reserved': ocrReserved,
      }),
      transaction: transaction,
    );
  }

  Future<void> _setStatus(
    final Session session,
    final UuidValue requestId,
    final String status, {
    required final int? inputTokens,
    required final int? outputTokens,
  }) async {
    final row = await OcrUsage.db.findById(session, requestId);
    if (row == null) return;
    await OcrUsage.db.updateRow(
      session,
      row.copyWith(
        status: status,
        inputTokens: inputTokens,
        outputTokens: outputTokens,
      ),
    );
  }

  Future<void> _writeCounters(
    final Session session,
    final UuidValue ownerId,
    final OcrUsageCounts counts,
  ) async {
    final entitlement = await Entitlement.db.findFirstRow(
      session,
      where: (final t) => t.ownerId.equals(ownerId),
    );
    if (entitlement == null) return;
    await Entitlement.db.updateRow(
      session,
      entitlement.copyWith(
        usedDay: counts.day,
        usedWeek: counts.week,
        usedMonth: counts.month,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }
}
