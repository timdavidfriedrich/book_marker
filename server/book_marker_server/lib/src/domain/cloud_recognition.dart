import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../adapters/recognition/text_recognition_provider.dart';
import '../composition.dart';
import '../generated/protocol.dart';
import 'config_source.dart';
import 'entitlements.dart';
import 'ocr_quota.dart';

const _config = ConfigSource();
const _entitlements = Entitlements();
const _quota = OcrQuota();
const _composition = Composition();

/// Gate 1 end to end, in the order the plan specifies: cheapest check first,
/// and the provider call outside the admission transaction.
///
/// Every refusal in here is something the app answers by falling back to
/// on-device recognition. A scan is never lost to a gate.
class CloudRecognition {
  const CloudRecognition();

  Future<OcrResult> recognize(
    final Session session,
    final UuidValue ownerId,
    final ByteData image,
  ) async {
    // * checked here as well as in createToken and upload, deliberately: a ten
    // * minute token already in a client's hands proves nothing about status
    final entitlement = await _entitlements.ensureForUser(
      session,
      ownerId,
      transaction: null,
    );
    if (entitlement.status == statusBlocked) {
      throw AccountBlockedException(reason: entitlement.blockedReason);
    }

    final limits = _config.limitsFor(entitlement.plan);
    final bytes = image.buffer.asUint8List(
      image.offsetInBytes,
      image.lengthInBytes,
    );
    if (bytes.length > limits.maxImageBytes) {
      throw OcrUnavailableException(
        reason:
            'image is ${bytes.length} bytes, the limit is ${limits.maxImageBytes}',
      );
    }

    final provider = _composition.textRecognitionProvider(session);
    final requestId = await _quota.reserve(
      session,
      ownerId,
      limits,
      provider.name,
    );
    if (requestId == null) {
      final counts = await _quota.countUsage(session, ownerId);
      throw OcrQuotaExhaustedException(
        usedDay: counts.day,
        usedWeek: counts.week,
        usedMonth: counts.month,
        limitDay: limits.ocrPerDay,
        limitWeek: limits.ocrPerWeek,
        limitMonth: limits.ocrPerMonth,
      );
    }

    return _callProvider(session, ownerId, provider, requestId, bytes);
  }

  Future<OcrResult> _callProvider(
    final Session session,
    final UuidValue ownerId,
    final TextRecognitionProvider provider,
    final UuidValue requestId,
    final Uint8List bytes,
  ) async {
    final RecognizedPage page;
    try {
      page = await provider.recognize(bytes);
    } on Object catch (error) {
      // * the slot goes back. A scan that never happened must not cost the user
      // * anything, and the app is about to fall back to on-device anyway
      await _quota.release(session, requestId);
      throw OcrUnavailableException(reason: error.toString());
    }

    final counts = await _quota.complete(
      session,
      ownerId,
      requestId,
      inputTokens: page.inputTokens,
      outputTokens: page.outputTokens,
    );
    return OcrResult(
      text: page.text,
      engine: provider.name,
      requestId: requestId,
      usedDay: counts.day,
      usedWeek: counts.week,
      usedMonth: counts.month,
    );
  }
}
