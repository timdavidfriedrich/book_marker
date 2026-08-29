import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/camera_frame.dart';
import 'package:feature_capture/domain/capture_mode.dart';
import 'package:feature_capture/domain/page_detection_repository.dart';
import 'package:feature_capture/presentation/capture/page_detection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/page_quad.dart';

const _detectionIntervalMs = 120;
const _smoothingFactor = 0.4;
const _maxMissedDetections = 4;

@injectable
class PageDetectionCubit extends Cubit<PageDetectionState> {
  PageDetectionCubit(this._pageDetectionRepository)
    : super(const PageDetectionState(mode: CaptureMode.auto, quad: null, frameAspectRatio: null));

  final PageDetectionRepository _pageDetectionRepository;
  final Stopwatch _sinceLastDetection = Stopwatch()..start();
  bool _isDetecting = false;
  int _missedDetections = 0;

  void selectMode(CaptureMode mode) {
    _missedDetections = 0;
    emit(PageDetectionState(mode: mode, quad: null, frameAspectRatio: state.frameAspectRatio));
  }

  Future<void> frameReceived(CameraFrame frame) async {
    if (_isDetecting || state.mode != CaptureMode.auto) return;
    if (_sinceLastDetection.elapsedMilliseconds < _detectionIntervalMs) return;
    _isDetecting = true;
    final result = await _pageDetectionRepository.detectInFrame(frame);
    _sinceLastDetection.reset();
    _isDetecting = false;
    if (isClosed || state.mode != CaptureMode.auto) return;
    final frameAspectRatio = _aspectRatioOf(frame);
    if (result case Success(data: final PageQuad detected)) {
      _missedDetections = 0;
      final previous = state.quad;
      emit(
        PageDetectionState(
          mode: state.mode,
          quad: previous == null ? detected : _smoothed(previous, detected),
          frameAspectRatio: frameAspectRatio,
        ),
      );
      return;
    }
    _missedDetections++;
    if (_missedDetections < _maxMissedDetections) return;
    emit(
      PageDetectionState(mode: state.mode, quad: null, frameAspectRatio: frameAspectRatio),
    );
  }

  double _aspectRatioOf(CameraFrame frame) {
    final isRotated = frame.rotationDegrees == 90 || frame.rotationDegrees == 270;
    return isRotated ? frame.height / frame.width : frame.width / frame.height;
  }

  PageQuad _smoothed(PageQuad previous, PageQuad next) {
    return PageQuad(
      topLeft: _smoothedPoint(previous.topLeft, next.topLeft),
      topRight: _smoothedPoint(previous.topRight, next.topRight),
      bottomRight: _smoothedPoint(previous.bottomRight, next.bottomRight),
      bottomLeft: _smoothedPoint(previous.bottomLeft, next.bottomLeft),
    );
  }

  PagePoint _smoothedPoint(PagePoint previous, PagePoint next) {
    return PagePoint(
      x: previous.x + (next.x - previous.x) * _smoothingFactor,
      y: previous.y + (next.y - previous.y) * _smoothingFactor,
    );
  }
}
