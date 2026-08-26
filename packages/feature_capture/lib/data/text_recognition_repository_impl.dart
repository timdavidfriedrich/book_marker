import 'dart:io';
import 'dart:ui' as ui;

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/recognized_page.dart';
import 'package:feature_capture/domain/text_recognition_repository.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:injectable/injectable.dart';

const _minMargin = 0.15;
final _pageNumberPattern = RegExp(r"^\d{1,4}$");

@Injectable(as: TextRecognitionRepository)
class const TextRecognitionRepositoryImpl() implements TextRecognitionRepository {
  @override
  Future<AppResult<RecognizedPage>> recognizePage(String imagePath) async {
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
    try {
      final imageSize = await _readImageSize(imagePath);
      final recognizedText = await recognizer.processImage(InputImage.fromFilePath(imagePath));
      final lines = <RecognizedLine>[];
      for (final block in recognizedText.blocks) {
        for (final line in block.lines) {
          lines.add(_toRecognizedLine(line, imageSize));
        }
      }
      return Success(
        RecognizedPage(
          lines: lines,
          detectedPageNumber: _detectPageNumber(lines),
          aspectRatio: imageSize.width / imageSize.height,
        ),
      );
    } on Object {
      return const Failure(UnexpectedError());
    } finally {
      await recognizer.close();
    }
  }

  RecognizedLine _toRecognizedLine(TextLine line, ui.Size imageSize) {
    final box = line.boundingBox;
    return RecognizedLine(
      text: line.text,
      left: (box.left / imageSize.width).clamp(0.0, 1.0),
      top: (box.top / imageSize.height).clamp(0.0, 1.0),
      width: (box.width / imageSize.width).clamp(0.0, 1.0),
      height: (box.height / imageSize.height).clamp(0.0, 1.0),
    );
  }

  int? _detectPageNumber(List<RecognizedLine> lines) {
    final candidates = lines.where((line) {
      final text = line.text.trim();
      final isNearEdge = line.top < _minMargin || line.top + line.height > 1 - _minMargin;
      return _pageNumberPattern.hasMatch(text) && isNearEdge;
    }).toList()..sort((first, second) => second.top.compareTo(first.top));
    if (candidates.isEmpty) return null;
    return int.tryParse(candidates.first.text.trim());
  }

  Future<ui.Size> _readImageSize(String imagePath) async {
    final bytes = await File(imagePath).readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;
    final size = ui.Size(image.width.toDouble(), image.height.toDouble());
    image.dispose();
    return size;
  }
}
