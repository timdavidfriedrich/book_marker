import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
import 'package:shared/domain/entities/page_quad.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
const _minOutputSize = 64;
const _equationCount = 8;
const _epsilon = 1e-9;
const _outwardPadding = 0.01;

class const PageImageCropper() {
  Future<String?> crop({
    required String imagePath,
    required PageQuad quad,
    required int maxSize,
  }) async {
    final image = await _decodeImage(imagePath);
    try {
      final corners = _cornersInPixels(quad, image.width, image.height);
      final (:width, :height) = _outputSize(corners, maxSize);
      final transform = _transform(corners, width.toDouble(), height.toDouble());
      if (transform == null) return null;
      final recorder = ui.PictureRecorder();
      ui.Canvas(recorder)
        ..transform(transform)
        ..drawImage(image, ui.Offset.zero, ui.Paint()..filterQuality = ui.FilterQuality.medium);
      final picture = recorder.endRecording();
      try {
        return await _writeImage(await picture.toImage(width, height));
      } finally {
        picture.dispose();
      }
    } finally {
      image.dispose();
    }
  }

  Future<ui.Image> _decodeImage(String imagePath) async {
    final codec = await ui.instantiateImageCodec(await File(imagePath).readAsBytes());
    try {
      return (await codec.getNextFrame()).image;
    } finally {
      codec.dispose();
    }
  }

  Future<String?> _writeImage(ui.Image image) async {
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      if (data == null) return null;
      final directory = await getTemporaryDirectory();
      final file = File("${directory.path}/page_${_uuid.v4()}.png");
      await file.writeAsBytes(data.buffer.asUint8List());
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

  ({int width, int height}) _outputSize(List<ui.Offset> corners, int maxSize) {
    final width = math.max((corners[0] - corners[1]).distance, (corners[3] - corners[2]).distance);
    final height = math.max((corners[0] - corners[3]).distance, (corners[1] - corners[2]).distance);
    final longest = math.max(width, height);
    final scale = longest > maxSize ? maxSize / longest : 1.0;
    return (
      width: math.max(_minOutputSize, (width * scale).round()),
      height: math.max(_minOutputSize, (height * scale).round()),
    );
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
