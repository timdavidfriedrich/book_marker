import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';

const _channel = MethodChannel("de.timdavidfriedrich.book_marker/jpeg_encoder");
const _encodeMethod = "encode";
const _rgbaChannels = 4;

@injectable
class const JpegEncoderDataSource() {
  Future<Uint8List> encode({
    required Uint8List pixels,
    required int width,
    required int height,
    required int quality,
  }) async {
    final encoded = await _platformEncoded(pixels, width, height, quality);
    return encoded ?? await _isolateEncoded(pixels, width, height, quality);
  }

  // * the closure must not be built in an async body, whose context is unsendable
  Future<Uint8List> _isolateEncoded(
    Uint8List pixels,
    int width,
    int height,
    int quality,
  ) {
    return Isolate.run(() => _encodeJpeg(pixels, width, height, quality));
  }

  Future<Uint8List?> _platformEncoded(
    Uint8List pixels,
    int width,
    int height,
    int quality,
  ) async {
    try {
      return await _channel.invokeMethod<Uint8List>(_encodeMethod, {
        "pixels": pixels,
        "width": width,
        "height": height,
        "quality": quality,
      });
    } on Object {
      return null;
    }
  }
}

Uint8List _encodeJpeg(Uint8List pixels, int width, int height, int quality) {
  return img.encodeJpg(
    img.Image.fromBytes(
      width: width,
      height: height,
      bytes: pixels.buffer,
      numChannels: _rgbaChannels,
      order: img.ChannelOrder.rgba,
    ),
    quality: quality,
  );
}
