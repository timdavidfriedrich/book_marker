import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/ocr_remote_data_source.dart';
import 'package:shared/data/models/remote_ocr_result.dart';

// * measured, not guessed: 1083.5 input tokens is about 2.48 Mpx of effective
// * resolution, so the provider downscales before tiling and anything above
// * this buys nothing but bandwidth
const _longEdge = 2300;
const _qualitySteps = [85, 75, 65];

abstract class CloudTextRecognitionDataSource {
  Future<RemoteOcrResult> recognizeFile(String imagePath, int maxBytes);
}

@Injectable(as: CloudTextRecognitionDataSource)
class const CloudTextRecognitionDataSourceImpl(
  final OcrRemoteDataSource _remoteDataSource,
) implements CloudTextRecognitionDataSource {
  // * every image is normalised here regardless of which branch produced it.
  // * Three paths in the capture use case hand over the ORIGINAL file: page
  // * detection found nothing, the quad covered the whole frame, or the crop
  // * failed and fell back. Those are 2 to 3 MB from the camera and unbounded
  // * from the picker, so the size bound has to be enforced at the boundary
  // * rather than hoped for upstream.
  @override
  Future<RemoteOcrResult> recognizeFile(String imagePath, int maxBytes) async {
    final bytes = await _normalise(imagePath, maxBytes);
    return _remoteDataSource.recognizePage(bytes);
  }

  Future<Uint8List> _normalise(String imagePath, int maxBytes) async {
    final decoded = img.decodeImage(await File(imagePath).readAsBytes());
    if (decoded == null) {
      throw const CloudScanUnavailableException("the image could not be decoded");
    }
    final scaled = decoded.width >= decoded.height
        ? img.copyResize(decoded, width: _longEdge)
        : img.copyResize(decoded, height: _longEdge);

    // * stepping the quality down terminates: the last step is used whatever it
    // * weighs, and the server refuses anything still over the limit rather
    // * than this looping forever on a pathological image
    for (final quality in _qualitySteps) {
      final encoded = img.encodeJpg(scaled, quality: quality);
      if (encoded.length <= maxBytes || quality == _qualitySteps.last) {
        return encoded;
      }
    }
    throw const CloudScanUnavailableException("unreachable");
  }
}
