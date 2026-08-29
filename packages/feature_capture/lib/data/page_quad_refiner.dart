import 'dart:math' as math;
import 'dart:typed_data';

import 'package:shared/domain/entities/page_quad.dart';

const _sampleCount = 24;
const _sampleStart = 0.12;
const _sampleEnd = 0.88;
const _searchRadiusRatio = 0.015;
const _gradientStep = 2;
const _minGradient = 10;
const _minSamples = 6;
const _maxShiftRatio = 0.06;
const _epsilon = 1e-6;

class const PageQuadRefiner() {
  PageQuad refine({
    required Uint8List luminance,
    required int width,
    required int height,
    required PageQuad quad,
  }) {
    final corners = [
      _toPixel(quad.topLeft, width, height),
      _toPixel(quad.topRight, width, height),
      _toPixel(quad.bottomRight, width, height),
      _toPixel(quad.bottomLeft, width, height),
    ];
    final radius = math.max(2, (math.max(width, height) * _searchRadiusRatio).round());
    final edges = [
      for (var index = 0; index < corners.length; index++)
        _fitEdge(
          luminance,
          width,
          height,
          corners[index],
          corners[(index + 1) % corners.length],
          radius,
        ),
    ];
    final maxShift = math.max(width, height) * _maxShiftRatio;
    return PageQuad(
      topLeft: _toNormalized(_intersect(edges[3], edges[0], corners[0], maxShift), width, height),
      topRight: _toNormalized(_intersect(edges[0], edges[1], corners[1], maxShift), width, height),
      bottomRight: _toNormalized(
        _intersect(edges[1], edges[2], corners[2], maxShift),
        width,
        height,
      ),
      bottomLeft: _toNormalized(_intersect(edges[2], edges[3], corners[3], maxShift), width, height),
    );
  }

  _Line _fitEdge(
    Uint8List luminance,
    int width,
    int height,
    PagePoint from,
    PagePoint to,
    int radius,
  ) {
    final coarse = _lineThrough(from, to);
    final length = _distance(from, to);
    if (length < _epsilon) return coarse;
    final normalX = -(to.y - from.y) / length;
    final normalY = (to.x - from.x) / length;
    final points = <PagePoint>[];
    for (var index = 0; index < _sampleCount; index++) {
      final position = _sampleStart + (_sampleEnd - _sampleStart) * index / (_sampleCount - 1);
      final anchorX = from.x + (to.x - from.x) * position;
      final anchorY = from.y + (to.y - from.y) * position;
      final offset = _strongestEdgeOffset(
        luminance,
        width,
        height,
        anchorX,
        anchorY,
        normalX,
        normalY,
        radius,
      );
      if (offset == null) continue;
      points.add(PagePoint(x: anchorX + normalX * offset, y: anchorY + normalY * offset));
    }
    if (points.length < _minSamples) return coarse;
    return _fitLine(points) ?? coarse;
  }

  double? _strongestEdgeOffset(
    Uint8List luminance,
    int width,
    int height,
    double anchorX,
    double anchorY,
    double normalX,
    double normalY,
    int radius,
  ) {
    var bestGradient = 0;
    double? bestOffset;
    for (var offset = -radius; offset <= radius; offset++) {
      final ahead = _sample(
        luminance,
        width,
        height,
        anchorX + normalX * (offset + _gradientStep),
        anchorY + normalY * (offset + _gradientStep),
      );
      final behind = _sample(
        luminance,
        width,
        height,
        anchorX + normalX * (offset - _gradientStep),
        anchorY + normalY * (offset - _gradientStep),
      );
      if (ahead == null || behind == null) continue;
      final gradient = (ahead - behind).abs();
      if (gradient > bestGradient) {
        bestGradient = gradient;
        bestOffset = offset.toDouble();
      }
    }
    if (bestGradient < _minGradient) return null;
    return bestOffset;
  }

  int? _sample(Uint8List luminance, int width, int height, double x, double y) {
    final pixelX = x.round();
    final pixelY = y.round();
    if (pixelX < 0 || pixelY < 0 || pixelX >= width || pixelY >= height) return null;
    return luminance[pixelY * width + pixelX];
  }

  _Line _lineThrough(PagePoint from, PagePoint to) {
    final length = math.max(_epsilon, _distance(from, to));
    final normalX = -(to.y - from.y) / length;
    final normalY = (to.x - from.x) / length;
    return _Line(
      normalX: normalX,
      normalY: normalY,
      offset: normalX * from.x + normalY * from.y,
    );
  }

  _Line? _fitLine(List<PagePoint> points) {
    var meanX = 0.0;
    var meanY = 0.0;
    for (final point in points) {
      meanX += point.x;
      meanY += point.y;
    }
    meanX /= points.length;
    meanY /= points.length;
    var xx = 0.0;
    var xy = 0.0;
    var yy = 0.0;
    for (final point in points) {
      final deltaX = point.x - meanX;
      final deltaY = point.y - meanY;
      xx += deltaX * deltaX;
      xy += deltaX * deltaY;
      yy += deltaY * deltaY;
    }
    final trace = xx + yy;
    final determinant = xx * yy - xy * xy;
    final eigenvalue =
        trace / 2 + math.sqrt(math.max(0.0, trace * trace / 4 - determinant));
    var directionX = xy;
    var directionY = eigenvalue - xx;
    if (directionX.abs() < _epsilon && directionY.abs() < _epsilon) {
      directionX = eigenvalue - yy;
      directionY = xy;
    }
    final length = math.sqrt(directionX * directionX + directionY * directionY);
    if (length < _epsilon) return null;
    final normalX = -directionY / length;
    final normalY = directionX / length;
    return _Line(
      normalX: normalX,
      normalY: normalY,
      offset: normalX * meanX + normalY * meanY,
    );
  }

  PagePoint _intersect(_Line first, _Line second, PagePoint fallback, double maxShift) {
    final determinant = first.normalX * second.normalY - first.normalY * second.normalX;
    if (determinant.abs() < _epsilon) return fallback;
    final point = PagePoint(
      x: (first.offset * second.normalY - first.normalY * second.offset) / determinant,
      y: (first.normalX * second.offset - first.offset * second.normalX) / determinant,
    );
    if (_distance(point, fallback) > maxShift) return fallback;
    return point;
  }

  PagePoint _toPixel(PagePoint point, int width, int height) {
    return PagePoint(x: point.x * width, y: point.y * height);
  }

  PagePoint _toNormalized(PagePoint point, int width, int height) {
    return PagePoint(
      x: (point.x / width).clamp(0.0, 1.0),
      y: (point.y / height).clamp(0.0, 1.0),
    );
  }

  double _distance(PagePoint from, PagePoint to) {
    final deltaX = to.x - from.x;
    final deltaY = to.y - from.y;
    return math.sqrt(deltaX * deltaX + deltaY * deltaY);
  }
}

class const _Line({
  required final double normalX,
  required final double normalY,
  required final double offset,
});
