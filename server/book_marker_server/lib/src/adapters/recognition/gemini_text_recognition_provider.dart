import 'dart:convert';

import 'package:http/http.dart' as http;

import 'text_recognition_provider.dart';

const _endpoint = 'https://generativelanguage.googleapis.com/v1beta/models';
const _mimeType = 'image/jpeg';
const _timeout = Duration(seconds: 60);

// * plain and literal on purpose. Anything that invites the model to summarise,
// * tidy or translate turns a transcription into a paraphrase, and a quote that
// * has been paraphrased is worse than no quote at all.
const _prompt =
    'Transcribe every word of text in this photograph of a book page. '
    'Preserve the original reading order and line breaks. Do not translate, '
    'summarise, correct spelling, or add commentary. If the page contains no '
    'text, return an empty response.';

/// Cloud recognition through Gemini.
///
/// The image is streamed straight into the request body and dropped when the
/// call returns: never written to disk, never logged, never associated with
/// anything stored. This is the one place where user content leaves the server
/// in the clear, and it is why the privacy policy has to name it.
class GeminiTextRecognitionProvider implements TextRecognitionProvider {
  const GeminiTextRecognitionProvider(this._apiKey, this._model);

  final String _apiKey;
  final String _model;

  @override
  String get name => 'gemini';

  @override
  Future<RecognizedPage> recognize(final List<int> image) async {
    final response = await _post(image);
    if (response.statusCode != 200) {
      throw TextRecognitionFailure('gemini returned ${response.statusCode}');
    }

    final body = json.decode(response.body);
    if (body is! Map<String, dynamic>) {
      throw const TextRecognitionFailure('gemini returned an unreadable body');
    }
    return RecognizedPage(
      text: _textOf(body),
      inputTokens: _tokenCount(body, 'promptTokenCount'),
      outputTokens: _tokenCount(body, 'candidatesTokenCount'),
    );
  }

  Future<http.Response> _post(final List<int> image) async {
    try {
      return await http
          .post(
            Uri.parse('$_endpoint/$_model:generateContent'),
            headers: {
              'content-type': 'application/json',
              'x-goog-api-key': _apiKey,
            },
            body: json.encode({
              'contents': [
                {
                  'parts': [
                    {'text': _prompt},
                    {
                      'inline_data': {
                        'mime_type': _mimeType,
                        'data': base64Encode(image),
                      },
                    },
                  ],
                },
              ],
            }),
          )
          .timeout(_timeout);
    } on Object catch (error) {
      throw TextRecognitionFailure('gemini unreachable: $error');
    }
  }
}

// * an empty page is a valid answer, not a failure: a photograph of a blank
// * page should fall through to "nothing recognised" rather than spend the
// * user's quota on a retry
String _textOf(final Map<String, dynamic> body) {
  final candidates = body['candidates'];
  if (candidates is! List || candidates.isEmpty) return '';
  final content = (candidates.first as Map<String, dynamic>)['content'];
  if (content is! Map<String, dynamic>) return '';
  final parts = content['parts'];
  if (parts is! List) return '';
  return parts
      .whereType<Map<String, dynamic>>()
      .map((final part) => part['text'])
      .whereType<String>()
      .join()
      .trim();
}

int? _tokenCount(final Map<String, dynamic> body, final String key) {
  final usage = body['usageMetadata'];
  if (usage is! Map<String, dynamic>) return null;
  final value = usage[key];
  return value is int ? value : null;
}
