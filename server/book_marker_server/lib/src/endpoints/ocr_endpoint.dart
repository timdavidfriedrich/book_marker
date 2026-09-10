import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../domain/cloud_recognition.dart';
import '../domain/entitlements.dart';
import '../generated/protocol.dart';

const _recognition = CloudRecognition();

/// The cloud OCR proxy. It exists so the model provider's API key never ships
/// in an app binary, and so the per-user limits are enforced somewhere the user
/// cannot edit.
///
/// The image is not end-to-end encrypted and cannot be: it reaches this server
/// in the clear and is forwarded in the clear. What it never does is touch the
/// disk, a log, or anything stored. Everything the app *keeps* stays E2E; this
/// one request in flight is not, and the privacy policy has to say so.
class OcrEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<OcrResult> recognizePage(
    final Session session,
    final ByteData image,
  ) => _recognition.recognize(session, authenticatedOwnerId(session), image);
}
