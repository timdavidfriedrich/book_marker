import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:feature_capture/data/data_sources/jpeg_encoder_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared/domain/entities/page_quad.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
const _minOutputSize = 64;
const _equationCount = 8;
const _epsilon = 1e-9;
const _outwardPadding = 0.01;
const _jpegQuality = 85;
const _decodeHeadroom = 1.15;

@injectable
class const PageImageCropper(
  final JpegEncoderDataSource _jpegEncoderDataSource,
) {
  Future<String?> crop({
    required String imagePath,
    required PageQuad quad,
    required int maxSize,
  }) async {
    final buffer = await ui.ImmutableBuffer.fromUint8List(
      await File(imagePath).readAsBytes(),
    );
    final descriptor = await ui.ImageDescriptor.encoded(buffer);
    final ({int width, int height}) output;
    final ui.Image image;
    try {
      final extent = _quadExtent(_cornersInPixels(quad, descriptor.width, descriptor.height));
      output = _outputSize(extent, maxSize);
      image = await _decode(descriptor, _decodeWidth(descriptor.width, extent, output));
    } finally {
      descriptor.dispose();
      buffer.dispose();
    }
    try {
      final corners = _cornersInPixels(quad, image.width, image.height);
      final transform = _transform(corners, output.width.toDouble(), output.height.toDouble());
      if (transform == null) return null;
      final recorder = ui.PictureRecorder();
      ui.Canvas(recorder)
        ..transform(transform)
        ..drawImage(image, ui.Offset.zero, ui.Paint()..filterQuality = ui.FilterQuality.high);
      final picture = recorder.endRecording();
      try {
        return await _writeImage(await picture.toImage(output.width, output.height));
      } finally {
        picture.dispose();
      }
    } finally {
      image.dispose();
    }
  }

  Future<ui.Image> _decode(ui.ImageDescriptor descriptor, int targetWidth) async {
    final codec = await descriptor.instantiateCodec(targetWidth: targetWidth);
    try {
      return (await codec.getNextFrame()).image;
    } finally {
      codec.dispose();
    }
  }

  Future<String?> _writeImage(ui.Image image) async {
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      if (data == null) return null;
      final pixels = data.buffer.asUint8List();
      final width = image.width;
      final height = image.height;
      final encoded = await _jpegEncoderDataSource.encode(
        pixels: pixels,
        width: width,
        height: height,
        quality: _jpegQuality,
      );
      final directory = await getTemporaryDirectory();
      final file = File("${directory.path}/page_${_uuid.v4()}.jpg");
      await file.writeAsBytes(encoded);
      return file.path;
    } finally {
      image.dispose();
    }
  }

  List<ui.Offset> _cornersInPixels(PageQuad quad, int width, int height) {
    final corners = [
      for (final point in [quad.topLeft, quad.topRight, quad.bottomRight, quad.bottomLeft])
        ui.Offset(point.x * width, point.y * height),
    ];
    final centerX = corners.fold(0.0, (sum, corner) => sum + corner.dx) / corners.length;
    final centerY = corners.fold(0.0, (sum, corner) => sum + corner.dy) / corners.length;
    return [
      for (final corner in corners)
        ui.Offset(
          (centerX + (corner.dx - centerX) * (1 + _outwardPadding)).clamp(0, width.toDouble()),
          (centerY + (corner.dy - centerY) * (1 + _outwardPadding)).clamp(0, height.toDouble()),
        ),
    ];
  }

  ({double width, double height}) _quadExtent(List<ui.Offset> corners) {
    return (
      width: math.max((corners[0] - corners[1]).distance, (corners[3] - corners[2]).distance),
      height: math.max((corners[0] - corners[3]).distance, (corners[1] - corners[2]).distance),
    );
  }

  ({int width, int height}) _outputSize(({double width, double height}) extent, int maxSize) {
    final longest = math.max(extent.width, extent.height);
    final scale = longest > maxSize ? maxSize / longest : 1.0;
    return (
      width: math.max(_minOutputSize, (extent.width * scale).round()),
      height: math.max(_minOutputSize, (extent.height * scale).round()),
    );
  }

  int _decodeWidth(
    int sourceWidth,
    ({double width, double height}) extent,
    ({int width, int height}) output,
  ) {
    final needed =
        math.max(output.width / extent.width, output.height / extent.height) * _decodeHeadroom;
    if (needed >= 1) return sourceWidth;
    return math.max(_minOutputSize, (sourceWidth * needed).round());
  }

  Float64List? _transform(List<ui.Offset> corners, double width, double height) {
    final targets = [
      ui.Offset.zero,
      ui.Offset(width, 0),
      ui.Offset(width, height),
      ui.Offset(0, height),
    ];
    final equations = List.generate(
      _equationCount,
      (_) => List<double>.filled(_equationCount + 1, 0),
    );
    for (var index = 0; index < corners.length; index++) {
      final source = corners[index];
      final target = targets[index];
      final row = index * 2;
      equations[row][0] = source.dx;
      equations[row][1] = source.dy;
      equations[row][2] = 1;
      equations[row][6] = -target.dx * source.dx;
      equations[row][7] = -target.dx * source.dy;
      equations[row][8] = target.dx;
      equations[row + 1][3] = source.dx;
      equations[row + 1][4] = source.dy;
      equations[row + 1][5] = 1;
      equations[row + 1][6] = -target.dy * source.dx;
      equations[row + 1][7] = -target.dy * source.dy;
      equations[row + 1][8] = target.dy;
    }
    final solution = _solve(equations);
    if (solution == null) return null;
    final transform = Float64List(16);
    transform[0] = solution[0];
    transform[1] = solution[3];
    transform[3] = solution[6];
    transform[4] = solution[1];
    transform[5] = solution[4];
    transform[7] = solution[7];
    transform[10] = 1;
    transform[12] = solution[2];
    transform[13] = solution[5];
    transform[15] = 1;
    return transform;
  }

  List<double>? _solve(List<List<double>> equations) {
    for (var column = 0; column < _equationCount; column++) {
      var pivot = column;
      for (var row = column + 1; row < _equationCount; row++) {
        if (equations[row][column].abs() > equations[pivot][column].abs()) pivot = row;
      }
      if (equations[pivot][column].abs() < _epsilon) return null;
      final swapped = equations[column];
      equations[column] = equations[pivot];
      equations[pivot] = swapped;
      for (var row = 0; row < _equationCount; row++) {
        if (row == column) continue;
        final factor = equations[row][column] / equations[column][column];
        if (factor == 0) continue;
        for (var index = column; index <= _equationCount; index++) {
          equations[row][index] -= factor * equations[column][index];
        }
      }
    }
    return [
      for (var row = 0; row < _equationCount; row++)
        equations[row][_equationCount] / equations[row][row],
    ];
  }
}
