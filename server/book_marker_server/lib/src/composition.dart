import 'package:serverpod/serverpod.dart';

import 'adapters/recognition/echo_text_recognition_provider.dart';
import 'adapters/recognition/gemini_text_recognition_provider.dart';
import 'adapters/recognition/text_recognition_provider.dart';
import 'domain/config_source.dart';

const _geminiProvider = 'gemini';
const _echoProvider = 'echo';

/// The single file that names concrete implementations. Everything else depends
/// on the interface, which is what makes an adapter swappable by editing
/// app_config.yaml rather than by shipping an app release.
class Composition {
  const Composition();

  TextRecognitionProvider textRecognitionProvider(final Session session) {
    final recognition = const ConfigSource().read().recognition;
    return switch (recognition.provider) {
      _geminiProvider => GeminiTextRecognitionProvider(
        _password('geminiApiKey'),
        recognition.model,
      ),
      _echoProvider => const EchoTextRecognitionProvider(),
      _ => throw StateError(
        'Unknown recognition.provider "${recognition.provider}" in app_config.yaml',
      ),
    };
  }
}

String _password(final String key) {
  final value = Serverpod.instance.getPassword(key);
  if (value == null) {
    throw StateError('Missing "$key" in config/passwords.yaml');
  }
  return value;
}
