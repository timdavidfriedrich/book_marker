import 'dart:async';

import 'package:camera/camera.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/repositories/camera_repository.dart';
import 'package:feature_capture/presentation/capture/camera_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/camera_frame.dart';

@injectable
class CameraCubit extends Cubit<CameraState> {
  CameraCubit(this._cameraRepository) : super(const CameraStarting());

  final CameraRepository _cameraRepository;
  final StreamController<CameraFrame> _frames = StreamController<CameraFrame>.broadcast();

  Stream<CameraFrame> get frames => _frames.stream;

  Future<void> start() async {
    if (state is CameraReady) return;
    final result = await _cameraRepository.open(_frameReceived);
    if (isClosed) return;
    emit(switch (result) {
      Success(:final data) => CameraReady(controller: data, isTorchOn: false),
      Failure() => const CameraUnavailable(),
    });
  }

  Future<AppResult<()>> toggleTorch() async {
    if (state case CameraReady(:final controller, :final isTorchOn)) {
      final isOn = !isTorchOn;
      final result = await _cameraRepository.setTorch(controller, isOn: isOn);
      if (result case Failure(:final error)) return Failure(error);
      if (!isClosed) emit(CameraReady(controller: controller, isTorchOn: isOn));
    }
    return const Success(());
  }

  // * null means there was nothing to do, which is not an error
  Future<AppResult<List<String>>?> capture() async {
    if (state case CameraReady(:final controller)) {
      final result = await _cameraRepository.takePicture(controller);
      await _release(controller);
      return switch (result) {
        Success(:final data) => Success([data]),
        Failure(:final error) => Failure(error),
      };
    }
    return null;
  }

  Future<AppResult<List<String>>?> pickImages() async {
    final result = await _cameraRepository.pickImages();
    if (result case Success(:final data) when data.isEmpty) return null;
    if (state case CameraReady(:final controller)) await _release(controller);
    return result;
  }

  @override
  Future<void> close() async {
    if (state case CameraReady(:final controller)) {
      await _cameraRepository.close(controller);
    }
    await _frames.close();
    return super.close();
  }

  void _frameReceived(CameraFrame frame) {
    if (_frames.isClosed) return;
    _frames.add(frame);
  }

  Future<void> _release(CameraController controller) async {
    if (!isClosed) emit(const CameraStarting());
    await _cameraRepository.close(controller);
  }
}
