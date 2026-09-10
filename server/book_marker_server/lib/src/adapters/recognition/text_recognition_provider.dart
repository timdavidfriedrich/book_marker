/// What a page of text costs and what it says.
///
/// Token counts are recorded on the usage row, not to bill anyone, but so the
/// price of a change of model or resolution can be seen rather than guessed.
class RecognizedPage {
  const RecognizedPage({
    required this.text,
    required this.inputTokens,
    required this.outputTokens,
  });

  final String text;
  final int? inputTokens;
  final int? outputTokens;
}

/// The seam that keeps this backend model-agnostic. Swapping vendors is a new
/// implementation plus one line in app_config.yaml, with no app release.
///
/// Implementations must never write the image to disk, never log it, and never
/// keep it after the call returns.
abstract class TextRecognitionProvider {
  String get name;

  Future<RecognizedPage> recognize(final List<int> image);
}

/// Thrown when the provider itself failed. The endpoint releases the quota
/// reservation and the app falls back to on-device recognition; a scan is never
/// lost to a provider being down.
class TextRecognitionFailure implements Exception {
  const TextRecognitionFailure(this.reason);

  final String reason;

  @override
  String toString() => 'TextRecognitionFailure: $reason';
}
