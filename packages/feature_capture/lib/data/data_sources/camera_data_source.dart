import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';

// * a lower preset cannot fill a page crop at recognition size
const _resolutionPresets = [ResolutionPreset.max, ResolutionPreset.ultraHigh];

@injectable
class const CameraDataSource() {
  Future<CameraController?> open(
    void Function(CameraImage image, int rotationDegrees) onFrame,
  ) async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return null;
    final description = cameras.first;
    final camera = await _initialize(description);
    if (camera == null) return null;
    await camera
        .startImageStream((image) => onFrame(image, description.sensorOrientation))
        .catchError((Object _) {});
    return camera;
  }

  Future<void> close(CameraController camera) async {
    if (camera.value.isStreamingImages) {
      await camera.stopImageStream().catchError((Object _) {});
    }
    await camera.setFlashMode(FlashMode.off).catchError((Object _) {});
    await camera.dispose();
  }

  Future<void> setTorch(CameraController camera, {required bool isOn}) {
    return camera.setFlashMode(isOn ? FlashMode.torch : FlashMode.off);
  }

  Future<String> takePicture(CameraController camera) async {
    if (camera.value.isStreamingImages) await camera.stopImageStream();
    return (await camera.takePicture()).path;
  }

  Future<CameraController?> _initialize(CameraDescription description) async {
    for (final preset in _resolutionPresets) {
      final camera = CameraController(
        description,
        preset,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      try {
        await camera.initialize();
        return camera;
      } on Object {
        try {
          await camera.dispose();
        } on Object {
          continue;
        }
      }
    }
    return null;
  }
}
