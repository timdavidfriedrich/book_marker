import 'dart:typed_data';

class const CameraFrame({
  required final Uint8List bytes,
  required final int width,
  required final int height,
  required final int bytesPerRow,
  required final int bytesPerPixel,
  required final int rotationDegrees,
});
