import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_capture/data/page_image_cropper.dart';
import 'package:feature_capture/data/page_quad_detector.dart';
import 'package:feature_capture/data/page_quad_refiner.dart';
import 'package:feature_capture/domain/camera_frame.dart';
import 'package:feature_capture/domain/page_detection.dart';
import 'package:feature_capture/domain/page_detection_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/page_quad.dart';

const _detector = PageQuadDetector();
const _refiner = PageQuadRefiner();
const _cropper = PageImageCropper();
const _frameAnalysisSize = 180;
const _stillAnalysisSize = 320;
const _stillWidth = 960;
const _rgbaBytesPerPixel = 4;

@Injectable(as: PageDetectionRepository)
class const PageDetectionRepositoryImpl() implements PageDetectionRepository {
  @override
  Future<AppResult<PageQuad?>> detectInFrame(CameraFrame frame) async {
    try {
      final (:values, :width, :height) = _gridFromFrame(frame);
      return Success(_detector.detect(luminance: values, width: width, height: height));
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<PageDetection>> detectInImage(String imagePath) async {
    try {
      final image = await _decodeImage(imagePath, _stillWidth);
      try {
        final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
        if (data == null) return const Failure(UnexpectedError());
        final luminance = _luminanceFromRgba(
          data.buffer.asUint8List(),
          image.width,
          image.height,
        );
        final grid = _downsample(luminance, image.width, image.height, _stillAnalysisSize);
        final coarse = _detector.detect(
          luminance: grid.values,
          width: grid.width,
          height: grid.height,
        );
        return Success(
          PageDetection(
            quad: coarse == null
                ? null
                : _refiner.refine(
                    luminance: luminance,
                    width: image.width,
                    height: image.height,
                    quad: coarse,
                  ),
            aspectRatio: image.width / image.height,
          ),
        );
      } finally {
        image.dispose();
      }
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<String>> cropToQuad({
    required String imagePath,
    required PageQuad quad,
    required int maxSize,
  }) async {
    try {
      final croppedPath = await _cropper.crop(
        imagePath: imagePath,
        quad: quad,
        maxSize: maxSize,
      );
      if (croppedPath == null) return const Failure(UnexpectedError());
      return Success(croppedPath);
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  ({Uint8List values, int width, int height}) _gridFromFrame(CameraFrame frame) {
    final isRotated = frame.rotationDegrees == 90 || frame.rotationDegrees == 270;
    final sourceWidth = isRotated ? frame.height : frame.width;
    final sourceHeight = isRotated ? frame.width : frame.height;
    final (:width, :height) = _gridSize(sourceWidth, sourceHeight, _frameAnalysisSize);
    final values = Uint8List(width * height);
    for (var y = 0; y < height; y++) {
      final uprightY = y * sourceHeight ~/ height;
      for (var x = 0; x < width; x++) {
        final uprightX = x * sourceWidth ~/ width;
        final (sourceX, sourceY) = _toSourcePixel(frame, uprightX, uprightY);
        values[y * width + x] = _frameLuminanceAt(frame, sourceX, sourceY);
      }
    }
    return (values: values, width: width, height: height);
  }

  Uint8List _luminanceFromRgba(Uint8List bytes, int width, int height) {
    final values = Uint8List(width * height);
    for (var index = 0; index < values.length; index++) {
      final offset = index * _rgbaBytesPerPixel;
      values[index] = (bytes[offset] + bytes[offset + 1] * 2 + bytes[offset + 2]) >> 2;
    }
    return values;
  }

  ({Uint8List values, int width, int height}) _downsample(
    Uint8List luminance,
    int sourceWidth,
    int sourceHeight,
    int targetSize,
  ) {
    final (:width, :height) = _gridSize(sourceWidth, sourceHeight, targetSize);
    if (width == sourceWidth && height == sourceHeight) {
      return (values: luminance, width: width, height: height);
    }
    final values = Uint8List(width * height);
    for (var y = 0; y < height; y++) {
      final startY = y * sourceHeight ~/ height;
      final endY = math.max(startY + 1, (y + 1) * sourceHeight ~/ height);
      for (var x = 0; x < width; x++) {
        final startX = x * sourceWidth ~/ width;
        final endX = math.max(startX + 1, (x + 1) * sourceWidth ~/ width);
        var sum = 0;
        var count = 0;
        for (var sourceY = startY; sourceY < endY; sourceY++) {
          final rowStart = sourceY * sourceWidth;
          for (var sourceX = startX; sourceX < endX; sourceX++) {
            sum += luminance[rowStart + sourceX];
            count++;
          }
        }
        values[y * width + x] = sum ~/ count;
      }
    }
    return (values: values, width: width, height: height);
  }

  ({int width, int height}) _gridSize(int sourceWidth, int sourceHeight, int targetSize) {
    final longest = math.max(sourceWidth, sourceHeight);
    if (longest <= targetSize) return (width: sourceWidth, height: sourceHeight);
    final scale = targetSize / longest;
    return (
      width: math.max(1, (sourceWidth * scale).round()),
      height: math.max(1, (sourceHeight * scale).round()),
    );
  }

  (int, int) _toSourcePixel(CameraFrame frame, int x, int y) {
    return switch (frame.rotationDegrees) {
      90 => (y, frame.height - 1 - x),
      180 => (frame.width - 1 - x, frame.height - 1 - y),
      270 => (frame.width - 1 - y, x),
      _ => (x, y),
    };
  }

  int _frameLuminanceAt(CameraFrame frame, int x, int y) {
    final index = y * frame.bytesPerRow + x * frame.bytesPerPixel;
    if (frame.bytesPerPixel == 1) return frame.bytes[index];
    return (frame.bytes[index] + frame.bytes[index + 1] * 2 + frame.bytes[index + 2]) >> 2;
  }

  Future<ui.Image> _decodeImage(String imagePath, int targetWidth) async {
    final codec = await ui.instantiateImageCodec(
      await File(imagePath).readAsBytes(),
      targetWidth: targetWidth,
    );
    try {
      return (await codec.getNextFrame()).image;
    } finally {
      codec.dispose();
    }
  }
}
