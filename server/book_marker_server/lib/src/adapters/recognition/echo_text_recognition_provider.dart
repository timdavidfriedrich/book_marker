import 'text_recognition_provider.dart';

/// The second implementation, so the interface is a real one rather than a
/// description of Gemini. It also lets the whole quota path be exercised on a
/// machine with no API key and no billing account.
///
/// Selected with `recognition.provider: echo` in app_config.yaml.
class EchoTextRecognitionProvider implements TextRecognitionProvider {
  const EchoTextRecognitionProvider();

  @override
  String get name => 'echo';

  @override
  Future<RecognizedPage> recognize(final List<int> image) async {
    return RecognizedPage(
      text:
          'echo provider: ${image.length} bytes received, no model was called',
      inputTokens: null,
      outputTokens: null,
    );
  }
}
