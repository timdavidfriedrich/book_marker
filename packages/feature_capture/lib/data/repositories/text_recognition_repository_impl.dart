import 'dart:io';
import 'dart:ui' as ui;

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_capture/data/data_sources/cloud_text_recognition_data_source.dart';
import 'package:feature_capture/data/data_sources/spell_check_data_source.dart';
import 'package:feature_capture/domain/mark_text.dart';
import 'package:feature_capture/domain/repositories/text_recognition_repository.dart';
import 'package:feature_capture/domain/word_quality.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/app_config.dart';
import 'package:shared/domain/entities/recognized_page.dart';
import 'package:shared/domain/entities/recognized_word.dart';
import 'package:shared/domain/entities/spell_check_report.dart';
import 'package:shared/domain/repositories/app_config_repository.dart';

const _edgeMargin = 0.18;
const _maxPageNumber = 3000;
final _pageNumberPattern = RegExp(r"^\d{1,4}$");

@Injectable(as: TextRecognitionRepository)
class const TextRecognitionRepositoryImpl(
  final SpellCheckDataSource _spellCheckDataSource,
  final CloudTextRecognitionDataSource _cloudDataSource,
  final AppConfigRepository _appConfigRepository,
) implements TextRecognitionRepository {
  // * the cloud result is preferred and never required. Out of quota, blocked,
  // * signed out, offline and a provider outage all land in the same place:
  // * recognise on device instead. A scan is never lost to a gate.
  @override
  Future<AppResult<RecognizedPage>> recognizePage(String imagePath) async {
    final config = await _config();
    if (config != null && config.cloudRecognitionEnabledByDefault) {
      final page = await _recognizeInCloud(imagePath, config.free.maxImageBytes);
      if (page != null) return Success(page);
    }
    return recognizeOnDevice(imagePath);
  }

  Future<AppConfig?> _config() async {
    return switch (await _appConfigRepository.watchConfig().first) {
      Success(:final data) => data,
      Failure() => null,
    };
  }

  // * no per-word geometry comes back, so `words` and `lines` stay empty and
  // * `text` carries everything. Building an alignment layer onto ML Kit's
  // * boxes would be a second recognition problem, not a fix
  Future<RecognizedPage?> _recognizeInCloud(String imagePath, int maxBytes) async {
    try {
      final imageSize = await _readImageSize(imagePath);
      final result = await _cloudDataSource.recognizeFile(imagePath, maxBytes);
      return RecognizedPage(
        lines: const [],
        words: const [],
        detectedPageNumber: null,
        aspectRatio: imageSize.width / imageSize.height,
        text: result.text,
      );
    } on Object {
      return null;
    }
  }

  Future<AppResult<RecognizedPage>> recognizeOnDevice(String imagePath) async {
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
    try {
      final imageSize = await _readImageSize(imagePath);
      final recognizedText = await recognizer.processImage(InputImage.fromFilePath(imagePath));
      final lines = <RecognizedLine>[];
      final elements = <RecognizedWord>[];
      for (final block in recognizedText.blocks) {
        for (final line in block.lines) {
          final lineIndex = lines.length;
          lines.add(_toRecognizedLine(line, imageSize));
          for (final element in line.elements) {
            elements.add(_toRecognizedWord(element, lineIndex, imageSize));
          }
        }
      }
      var words = mergeSplitWords(markWrappedWords(elements));
      var spelling = await _spellCheckDataSource.checkPage(_texts(words));
      if (spelling != null) {
        final joined = await _joinBrokenWords(words, spelling);
        if (joined != null) {
          words = joined;
          spelling = await _spellCheckDataSource.checkPage(_texts(words));
        }
      }
      return Success(
        RecognizedPage(
          lines: lines,
          words: markUncertainWords(words, spelling),
          detectedPageNumber: _detectPageNumber(lines),
          aspectRatio: imageSize.width / imageSize.height,
          text: lines.map((line) => line.text).join("\n"),
        ),
      );
    } on Object {
      return const Failure(UnexpectedError());
    } finally {
      await recognizer.close();
    }
  }

  Future<List<RecognizedWord>?> _joinBrokenWords(
    List<RecognizedWord> words,
    SpellCheckReport spelling,
  ) async {
    final candidates = joinCandidates(words, spelling.misspelled);
    if (candidates.isEmpty) return null;
    final unknownJoins = await _spellCheckDataSource.checkWords([
      for (final candidate in candidates) candidate.joined,
    ]);
    if (unknownJoins == null) return null;
    final accepted = <int>{};
    for (var index = 0; index < candidates.length; index++) {
      final candidate = candidates[index];
      final joinIsWord = !unknownJoins.contains(index);
      // * two unknown fragments at a line break are one broken word, even if the join is misread
      final bothUnknown =
          spelling.misspelled.contains(candidate.index) &&
          spelling.misspelled.contains(candidate.index + 1);
      if (joinIsWord || (candidate.crossesLine && bothUnknown)) accepted.add(candidate.index);
    }
    if (accepted.isEmpty) return null;
    return applyJoins(words, accepted);
  }

  List<String> _texts(List<RecognizedWord> words) => [for (final word in words) word.text];

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

  RecognizedWord _toRecognizedWord(TextElement element, int lineIndex, ui.Size imageSize) {
    final box = element.boundingBox;
    return RecognizedWord(
      text: element.text,
      left: (box.left / imageSize.width).clamp(0.0, 1.0),
      top: (box.top / imageSize.height).clamp(0.0, 1.0),
      width: (box.width / imageSize.width).clamp(0.0, 1.0),
      height: (box.height / imageSize.height).clamp(0.0, 1.0),
      lineIndex: lineIndex,
      pageIndex: 0,
      confidence: element.confidence,
      isUncertain: false,
      joinsWithNext: false,
    );
  }

  int? _detectPageNumber(List<RecognizedLine> lines) {
    int? best;
    var bestScore = double.infinity;
    for (final line in lines) {
      final text = line.text.trim();
      if (!_pageNumberPattern.hasMatch(text)) continue;
      final value = int.tryParse(text);
      if (value == null || value > _maxPageNumber) continue;
      final topDistance = line.top;
      final bottomDistance = 1 - (line.top + line.height);
      final edgeDistance = topDistance < bottomDistance ? topDistance : bottomDistance;
      if (edgeDistance > _edgeMargin) continue;
      // * bias slightly toward the bottom margin, where page numbers sit more often
      final score = edgeDistance + (bottomDistance < topDistance ? 0.0 : 0.01);
      if (score < bestScore) {
        best = value;
        bestScore = score;
      }
    }
    return best;
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
