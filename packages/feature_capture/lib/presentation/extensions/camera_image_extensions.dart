import 'package:camera/camera.dart';
import 'package:feature_capture/domain/camera_frame.dart';

extension CameraImageExtensions on CameraImage {
  CameraFrame toCameraFrame(int rotationDegrees) {
    final plane = planes.first;
    return CameraFrame(
      bytes: plane.bytes,
      width: width,
      height: height,
      bytesPerRow: plane.bytesPerRow,
      bytesPerPixel: plane.bytesPerPixel ?? 1,
      rotationDegrees: rotationDegrees,
    );
  }
}
