import 'package:serverpod/serverpod.dart';
import 'package:serverpod_cloud_storage_s3_compat/serverpod_cloud_storage_s3_compat.dart';

import 'adapters/recognition/echo_text_recognition_provider.dart';
import 'adapters/recognition/gemini_text_recognition_provider.dart';
import 'adapters/recognition/text_recognition_provider.dart';
import 'domain/attachments.dart';
import 'domain/config_source.dart';

const _geminiProvider = 'gemini';
const _echoProvider = 'echo';
const _minioProvider = 'minio';
const _databaseProvider = 'database';

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

  /// Chosen once at boot, because Serverpod registers storage backends at
  /// startup rather than per request.
  ///
  /// The database backend is not a stub: it keeps blobs in Postgres, which is
  /// wrong at scale and exactly right for exercising the whole attachment path
  /// on a machine with no object store and no access keys.
  CloudStorage attachmentStorage() {
    final attachments = const ConfigSource().read().attachments;
    return switch (attachments.provider) {
      _minioProvider => S3CompatCloudStorage(
        storageId: attachmentStorageId,
        accessKey: _password('minioAccessKey'),
        secretKey: _password('minioSecretKey'),
        bucket: attachments.bucket,
        region: attachments.region,
        // * never public. Every object here is ciphertext, but a public bucket
        // * would still leak how many attachments an account has and when
        public: false,
        endpoints: CustomEndpointConfig(
          baseUri: Uri.parse(attachments.endpoint),
          serviceName: 'MinIO',
        ),
        uploadStrategy: MultipartPostUploadStrategy(),
      ),
      _databaseProvider => DatabaseCloudStorage(attachmentStorageId),
      _ => throw StateError(
        'Unknown attachments.provider "${attachments.provider}" in app_config.yaml',
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
