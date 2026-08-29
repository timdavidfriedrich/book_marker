import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/captured_page.dart';
import 'package:feature_capture/domain/page_detection_repository.dart';
import 'package:feature_capture/domain/text_recognition_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/page_quad.dart';

const _fullFrameTolerance = 0.02;
const _recognitionSize = 2600;
const _storedSize = 1600;

@injectable
class RecognizeCapturedPageUseCase {
  RecognizeCapturedPageUseCase(this._pageDetectionRepository, this._textRecognitionRepository);

  final PageDetectionRepository _pageDetectionRepository;
  final TextRecognitionRepository _textRecognitionRepository;

  Future<AppResult<CapturedPage>> call({
    required String imagePath,
    required PageQuad? pageQuad,
  }) async {
    final quad = pageQuad ?? await _detect(imagePath);
    if (quad == null || _coversFullFrame(quad)) return _recognize(imagePath, imagePath);
    // * a large crop is recognised, a smaller one is kept, so quality and storage are separate
    final recognitionPath = await _crop(imagePath, quad, _recognitionSize);
    final storedPath = recognitionPath == null ? null : await _crop(imagePath, quad, _storedSize);
    if (recognitionPath == null || storedPath == null) return _recognize(imagePath, imagePath);
    return _recognize(recognitionPath, storedPath);
  }

  Future<AppResult<CapturedPage>> _recognize(String recognitionPath, String storedPath) async {
    return switch (await _textRecognitionRepository.recognizePage(recognitionPath)) {
      Success(:final data) => Success(CapturedPage(imagePath: storedPath, page: data)),
      Failure(:final error) => Failure(error),
    };
  }

  Future<PageQuad?> _detect(String imagePath) async {
    if (await _pageDetectionRepository.detectInImage(imagePath) case Success(:final data)) {
      return data.quad;
    }
    return null;
  }

  Future<String?> _crop(String imagePath, PageQuad quad, int maxSize) async {
    final result = await _pageDetectionRepository.cropToQuad(
      imagePath: imagePath,
      quad: quad,
      maxSize: maxSize,
    );
    return switch (result) {
      Success(:final data) => data,
      Failure() => null,
    };
  }

  bool _coversFullFrame(PageQuad quad) {
    return _isNear(quad.topLeft, 0, 0) &&
        _isNear(quad.topRight, 1, 0) &&
        _isNear(quad.bottomRight, 1, 1) &&
        _isNear(quad.bottomLeft, 0, 1);
  }

  bool _isNear(PagePoint point, double x, double y) {
    return (point.x - x).abs() < _fullFrameTolerance && (point.y - y).abs() < _fullFrameTolerance;
  }
}
