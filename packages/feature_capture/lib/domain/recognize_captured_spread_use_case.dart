import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/mark_text.dart';
import 'package:feature_capture/domain/recognize_captured_page_use_case.dart';
import 'package:feature_capture/domain/recognized_page.dart';
import 'package:feature_capture/domain/recognized_spread.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/captured_shot.dart';

@injectable
class RecognizeCapturedSpreadUseCase {
  RecognizeCapturedSpreadUseCase(this._recognizeCapturedPageUseCase);

  final RecognizeCapturedPageUseCase _recognizeCapturedPageUseCase;

  Future<AppResult<RecognizedSpread>> call(List<CapturedShot> shots) async {
    final pages = <SpreadPage>[];
    final words = <RecognizedWord>[];
    final breaks = <int>[];
    final detectedPageNumbers = <int>[];
    var lineOffset = 0;
    for (final shot in shots) {
      final result = await _recognizeCapturedPageUseCase(
        imagePath: shot.imagePath,
        pageQuad: shot.pageQuad,
      );
      if (result case Failure(:final error)) return Failure(error);
      if (result case Success(:final data)) {
        if (words.isNotEmpty) breaks.add(words.length - 1);
        words.addAll(_placed(data.page.words, pages.length, lineOffset));
        pages.add(SpreadPage(imagePath: data.imagePath, aspectRatio: data.page.aspectRatio));
        lineOffset += data.page.lines.length;
        if (data.page.detectedPageNumber case final int number
            when !detectedPageNumbers.contains(number)) {
          detectedPageNumbers.add(number);
        }
      }
    }
    if (pages.isEmpty) return const Failure(UnexpectedError());
    var combined = words;
    for (final index in breaks) {
      combined = markWrappedPageBreak(combined, index);
    }
    return Success(
      RecognizedSpread(
        pages: pages,
        words: combined,
        detectedPageNumbers: detectedPageNumbers,
      ),
    );
  }

  List<RecognizedWord> _placed(List<RecognizedWord> words, int pageIndex, int lineOffset) {
    return [
      for (final word in words)
        RecognizedWord(
          text: word.text,
          left: word.left,
          top: word.top,
          width: word.width,
          height: word.height,
          lineIndex: word.lineIndex + lineOffset,
          pageIndex: pageIndex,
          confidence: word.confidence,
          isUncertain: word.isUncertain,
          joinsWithNext: word.joinsWithNext,
          suggestions: word.suggestions,
        ),
    ];
  }
}
