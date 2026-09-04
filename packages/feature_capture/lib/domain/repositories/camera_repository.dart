import 'package:camera/camera.dart';
import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/camera_frame.dart';

abstract class CameraRepository {
  Future<AppResult<CameraController>> open(void Function(CameraFrame frame) onFrame);

  Future<AppResult<()>> close(CameraController camera);

  Future<AppResult<()>> setTorch(CameraController camera, {required bool isOn});

  Future<AppResult<String>> takePicture(CameraController camera);

  Future<AppResult<List<String>>> pickImages();
}
