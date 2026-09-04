import 'package:camera/camera.dart';

sealed class CameraState {
  const CameraState();
}

class const CameraStarting() extends CameraState;

class const CameraUnavailable() extends CameraState;

class const CameraReady({
  required final CameraController controller,
  required final bool isTorchOn,
}) extends CameraState;
