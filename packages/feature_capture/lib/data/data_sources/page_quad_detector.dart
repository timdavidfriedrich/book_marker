import 'dart:math' as math;
import 'dart:typed_data';

import 'package:shared/domain/entities/page_quad.dart';

const _minGridSize = 32;
const _thetaBins = 180;
const _magnitudeLevels = 2048;
const _closeRadius = 3;
const _blurRadius = 1;
const _edgeFraction = 0.08;
const _minGradient = 20;
const _minEdgePoints = 80;
const _maxEdgePoints = 6000;
const _gradientSpread = 8;
const _peakRatio = 0.28;
const _minVotes = 14;
const _maxPeaks = 16;
const _peakThetaSeparation = 10;
const _peakRhoSeparationRatio = 0.06;
const _axisTolerance = 35;
const _maxLinesPerAxis = 6;
const _minLineSeparationRatio = 0.22;
const _minAreaRatio = 0.10;
const _maxAreaRatio = 0.92;
const _borderMargin = 0.025;
const _cornerSlack = 0.02;
const _spreadAspect = 1.15;
const _splitBand = 0.2;
const _minAspect = 0.2;
const _maxAspect = 5.0;
const _quadratureTolerance = 25.0;
const _straightAngle = 90.0;
const _supportSamples = 18;
const _supportStart = 0.08;
const _supportEnd = 0.92;
const _supportRadius = 2;
const _minEdgeSupport = 0.55;

final _cosTable = List<double>.generate(
  _thetaBins,
  (index) => math.cos(index * math.pi / _thetaBins),
);
final _sinTable = List<double>.generate(
  _thetaBins,
  (index) => math.sin(index * math.pi / _thetaBins),
);

class const PageQuadDetector() {
  PageQuad? detect({
    required Uint8List luminance,
    required int width,
    required int height,
  }) {
    if (width < _minGridSize || height < _minGridSize) return null;
    final blurred = _blur(_closeText(luminance, width, height), width, height);
    final (:magnitude, :angle) = _gradients(blurred, width, height);
    final threshold = _gradientThreshold(magnitude);
    if (threshold == null) return null;
    final points = _edgePoints(magnitude, width, height, threshold);
    if (points.length < _minEdgePoints) return null;
    final lines = _houghLines(points, angle, width, height);
    if (lines.length < 4) return null;
    return _bestQuad(lines, magnitude, width, height, threshold);
  }

  double confidenceOf({
    required Uint8List luminance,
    required int width,
    required int height,
    required PageQuad quad,
  }) {
    if (width < _minGridSize || height < _minGridSize) return 0;
    final blurred = _blur(_closeText(luminance, width, height), width, height);
    final magnitude = _gradients(blurred, width, height).magnitude;
    final threshold = _gradientThreshold(magnitude);
    if (threshold == null) return 0;
    final corners = [
      _pixel(quad.topLeft, width, height),
      _pixel(quad.topRight, width, height),
      _pixel(quad.bottomRight, width, height),
      _pixel(quad.bottomLeft, width, height),
    ];
    var weakest = 1.0;
    for (var index = 0; index < corners.length; index++) {
      final support = _edgeSupport(
        corners[index],
        corners[(index + 1) % corners.length],
        magnitude,
        width,
        height,
        threshold,
      );
      if (support < weakest) weakest = support;
    }
    return weakest;
  }

  PagePoint _pixel(PagePoint point, int width, int height) {
    return PagePoint(x: point.x * width, y: point.y * height);
  }

  Uint8List _closeText(Uint8List luminance, int width, int height) {
    final dilated = _morphology(luminance, width, height, takeMaximum: true);
    return _morphology(dilated, width, height, takeMaximum: false);
  }

  Uint8List _morphology(
    Uint8List source,
    int width,
    int height, {
    required bool takeMaximum,
  }) {
    final horizontal = Uint8List(width * height);
    for (var y = 0; y < height; y++) {
      final row = y * width;
      for (var x = 0; x < width; x++) {
        var best = source[row + x];
        for (var offset = -_closeRadius; offset <= _closeRadius; offset++) {
          final sampleX = x + offset;
          if (sampleX < 0 || sampleX >= width) continue;
          final value = source[row + sampleX];
          if (takeMaximum ? value > best : value < best) best = value;
        }
        horizontal[row + x] = best;
      }
    }
    final result = Uint8List(width * height);
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        var best = horizontal[y * width + x];
        for (var offset = -_closeRadius; offset <= _closeRadius; offset++) {
          final sampleY = y + offset;
          if (sampleY < 0 || sampleY >= height) continue;
          final value = horizontal[sampleY * width + x];
          if (takeMaximum ? value > best : value < best) best = value;
        }
        result[y * width + x] = best;
      }
    }
    return result;
  }

  Uint8List _blur(Uint8List luminance, int width, int height) {
    final horizontal = Uint8List(width * height);
    for (var y = 0; y < height; y++) {
      final row = y * width;
      for (var x = 0; x < width; x++) {
        var sum = 0;
        var count = 0;
        for (var offset = -_blurRadius; offset <= _blurRadius; offset++) {
          final sampleX = x + offset;
          if (sampleX < 0 || sampleX >= width) continue;
          sum += luminance[row + sampleX];
          count++;
        }
        horizontal[row + x] = sum ~/ count;
      }
    }
    final blurred = Uint8List(width * height);
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        var sum = 0;
        var count = 0;
        for (var offset = -_blurRadius; offset <= _blurRadius; offset++) {
          final sampleY = y + offset;
          if (sampleY < 0 || sampleY >= height) continue;
          sum += horizontal[sampleY * width + x];
          count++;
        }
        blurred[y * width + x] = sum ~/ count;
      }
    }
    return blurred;
  }

  ({Int32List magnitude, Uint8List angle}) _gradients(
    Uint8List blurred,
    int width,
    int height,
  ) {
    final magnitude = Int32List(width * height);
    final angle = Uint8List(width * height);
    for (var y = 1; y < height - 1; y++) {
      for (var x = 1; x < width - 1; x++) {
        final index = y * width + x;
        final topLeft = blurred[index - width - 1];
        final top = blurred[index - width];
        final topRight = blurred[index - width + 1];
        final left = blurred[index - 1];
        final right = blurred[index + 1];
        final bottomLeft = blurred[index + width - 1];
        final bottom = blurred[index + width];
        final bottomRight = blurred[index + width + 1];
        final horizontal = (topRight + 2 * right + bottomRight) - (topLeft + 2 * left + bottomLeft);
        final vertical = (bottomLeft + 2 * bottom + bottomRight) - (topLeft + 2 * top + topRight);
        magnitude[index] = horizontal.abs() + vertical.abs();
        var degrees = (math.atan2(vertical, horizontal) * _thetaBins / math.pi).round();
        degrees %= _thetaBins;
        if (degrees < 0) degrees += _thetaBins;
        angle[index] = degrees;
      }
    }
    return (magnitude: magnitude, angle: angle);
  }

  int? _gradientThreshold(Int32List magnitude) {
    final histogram = Int32List(_magnitudeLevels);
    for (final value in magnitude) {
      histogram[math.min(value, _magnitudeLevels - 1)]++;
    }
    final target = ((1 - _edgeFraction) * magnitude.length).round();
    var seen = 0;
    for (var value = 0; value < _magnitudeLevels; value++) {
      seen += histogram[value];
      if (seen >= target) return math.max(value, _minGradient);
    }
    return null;
  }

  Int32List _edgePoints(Int32List magnitude, int width, int height, int threshold) {
    final found = <int>[];
    for (var y = 1; y < height - 1; y++) {
      for (var x = 1; x < width - 1; x++) {
        final index = y * width + x;
        if (magnitude[index] >= threshold) found.add(index);
      }
    }
    if (found.length <= _maxEdgePoints) return Int32List.fromList(found);
    final stride = (found.length / _maxEdgePoints).ceil();
    final sampled = <int>[];
    for (var index = 0; index < found.length; index += stride) {
      sampled.add(found[index]);
    }
    return Int32List.fromList(sampled);
  }

  List<_Line> _houghLines(Int32List points, Uint8List angle, int width, int height) {
    final diagonal = math.sqrt(width * width + height * height).ceil();
    final rhoCount = 2 * diagonal + 1;
    final accumulator = Int32List(_thetaBins * rhoCount);
    for (final index in points) {
      final x = index % width;
      final y = index ~/ width;
      final center = angle[index];
      for (var offset = -_gradientSpread; offset <= _gradientSpread; offset++) {
        final theta = (center + offset + _thetaBins) % _thetaBins;
        final rho = (x * _cosTable[theta] + y * _sinTable[theta]).round() + diagonal;
        accumulator[theta * rhoCount + rho]++;
      }
    }
    var maximum = 0;
    for (final votes in accumulator) {
      if (votes > maximum) maximum = votes;
    }
    if (maximum < _minVotes) return const [];
    final minimum = math.max(_minVotes, (maximum * _peakRatio).round());
    final candidates = <_Line>[];
    for (var theta = 0; theta < _thetaBins; theta++) {
      final base = theta * rhoCount;
      for (var rho = 1; rho < rhoCount - 1; rho++) {
        final votes = accumulator[base + rho];
        if (votes < minimum) continue;
        if (votes < accumulator[base + rho - 1] || votes < accumulator[base + rho + 1]) continue;
        candidates.add(_Line(theta: theta, rho: (rho - diagonal).toDouble(), votes: votes));
      }
    }
    candidates.sort((first, second) => second.votes.compareTo(first.votes));
    final separation = math.max(width, height) * _peakRhoSeparationRatio;
    final peaks = <_Line>[];
    for (final candidate in candidates) {
      if (peaks.length >= _maxPeaks) break;
      final isDuplicate = peaks.any(
        (peak) =>
            _thetaDistance(peak.theta, candidate.theta) < _peakThetaSeparation &&
            (peak.rho - candidate.rho).abs() < separation,
      );
      if (!isDuplicate) peaks.add(candidate);
    }
    return peaks;
  }

  int _thetaDistance(int first, int second) {
    final difference = (first - second).abs();
    return math.min(difference, _thetaBins - difference);
  }

  PageQuad? _bestQuad(
    List<_Line> lines,
    Int32List magnitude,
    int width,
    int height,
    int threshold,
  ) {
    final vertical = <_Line>[];
    final horizontal = <_Line>[];
    for (final line in lines) {
      if (_thetaDistance(line.theta, 0) <= _axisTolerance) {
        if (vertical.length < _maxLinesPerAxis) vertical.add(line);
      } else if (_thetaDistance(line.theta, _thetaBins ~/ 2) <= _axisTolerance) {
        if (horizontal.length < _maxLinesPerAxis) horizontal.add(line);
      }
    }
    if (vertical.length < 2 || horizontal.length < 2) return null;

    final candidates = <PageQuad>[];
    for (var first = 0; first < vertical.length - 1; first++) {
      for (var second = first + 1; second < vertical.length; second++) {
        for (var third = 0; third < horizontal.length - 1; third++) {
          for (var fourth = third + 1; fourth < horizontal.length; fourth++) {
            final quad = _quadFrom(
              vertical[first],
              vertical[second],
              horizontal[third],
              horizontal[fourth],
              width,
              height,
            );
            if (quad != null) candidates.add(quad);
          }
        }
      }
    }
    candidates.sort((first, second) => _area(second).compareTo(_area(first)));

    for (final candidate in candidates) {
      if (!_hasEdgeSupport(candidate, magnitude, width, height, threshold)) continue;
      if (_area(candidate) > width * height * _maxAreaRatio) return null;
      if (_coversFrame(candidate, width, height)) return null;
      final page =
          _splitSpread(candidate, vertical, magnitude, width, height, threshold) ?? candidate;
      return PageQuad(
        topLeft: _normalized(page.topLeft, width, height),
        topRight: _normalized(page.topRight, width, height),
        bottomRight: _normalized(page.bottomRight, width, height),
        bottomLeft: _normalized(page.bottomLeft, width, height),
      );
    }
    return null;
  }

  PageQuad? _splitSpread(
    PageQuad quad,
    List<_Line> vertical,
    Int32List magnitude,
    int width,
    int height,
    int threshold,
  ) {
    final leftHeight = _distance(quad.topLeft, quad.bottomLeft);
    if (leftHeight <= 0) return null;
    if (_distance(quad.topLeft, quad.topRight) / leftHeight < _spreadAspect) return null;

    _Line? gutter;
    for (final line in vertical) {
      final top = _intersectSegment(line, quad.topLeft, quad.topRight);
      final bottom = _intersectSegment(line, quad.bottomLeft, quad.bottomRight);
      if (top == null || bottom == null) continue;
      if ((top.position - 0.5).abs() > _splitBand) continue;
      if ((bottom.position - 0.5).abs() > _splitBand) continue;
      if (gutter == null || line.votes > gutter.votes) gutter = line;
    }
    if (gutter == null) return null;
    final top = _intersectSegment(gutter, quad.topLeft, quad.topRight);
    final bottom = _intersectSegment(gutter, quad.bottomLeft, quad.bottomRight);
    if (top == null || bottom == null) return null;

    final left = PageQuad(
      topLeft: quad.topLeft,
      topRight: top.point,
      bottomRight: bottom.point,
      bottomLeft: quad.bottomLeft,
    );
    final right = PageQuad(
      topLeft: top.point,
      topRight: quad.topRight,
      bottomRight: quad.bottomRight,
      bottomLeft: bottom.point,
    );
    final centerX = width / 2;
    final centerY = height / 2;
    final PageQuad chosen;
    if (_contains(left, centerX, centerY)) {
      chosen = left;
    } else if (_contains(right, centerX, centerY)) {
      chosen = right;
    } else {
      chosen = _area(left) >= _area(right) ? left : right;
    }
    if (_area(chosen) < width * height * _minAreaRatio) return null;
    if (!_hasEdgeSupport(chosen, magnitude, width, height, threshold)) return null;
    return chosen;
  }

  ({PagePoint point, double position})? _intersectSegment(
    _Line line,
    PagePoint from,
    PagePoint to,
  ) {
    final cosine = _cosTable[line.theta];
    final sine = _sinTable[line.theta];
    final deltaX = to.x - from.x;
    final deltaY = to.y - from.y;
    final denominator = deltaX * cosine + deltaY * sine;
    if (denominator.abs() < 1e-6) return null;
    final position = (line.rho - from.x * cosine - from.y * sine) / denominator;
    if (position < 0 || position > 1) return null;
    return (
      point: PagePoint(x: from.x + deltaX * position, y: from.y + deltaY * position),
      position: position,
    );
  }

  bool _contains(PageQuad quad, double x, double y) {
    final corners = [quad.topLeft, quad.topRight, quad.bottomRight, quad.bottomLeft];
    var sign = 0;
    for (var index = 0; index < corners.length; index++) {
      final current = corners[index];
      final next = corners[(index + 1) % corners.length];
      final cross = (next.x - current.x) * (y - current.y) - (next.y - current.y) * (x - current.x);
      if (cross == 0) continue;
      final currentSign = cross > 0 ? 1 : -1;
      if (sign == 0) {
        sign = currentSign;
      } else if (sign != currentSign) {
        return false;
      }
    }
    return true;
  }

  PageQuad? _quadFrom(
    _Line firstVertical,
    _Line secondVertical,
    _Line firstHorizontal,
    _Line secondHorizontal,
    int width,
    int height,
  ) {
    final minimumSeparation = _minLineSeparationRatio * math.min(width, height);
    if ((firstVertical.rho - secondVertical.rho).abs() < minimumSeparation) return null;
    if ((firstHorizontal.rho - secondHorizontal.rho).abs() < minimumSeparation) return null;
    final corners = <PagePoint>[];
    for (final vertical in [firstVertical, secondVertical]) {
      for (final horizontal in [firstHorizontal, secondHorizontal]) {
        final point = _intersect(vertical, horizontal);
        if (point == null) return null;
        corners.add(point);
      }
    }
    final slackX = width * _cornerSlack;
    final slackY = height * _cornerSlack;
    for (final corner in corners) {
      if (corner.x < -slackX || corner.x > width + slackX) return null;
      if (corner.y < -slackY || corner.y > height + slackY) return null;
    }
    final quad = _order(corners);
    if (!_isConvex(quad)) return null;
    if (_area(quad) < width * height * _minAreaRatio) return null;
    final topWidth = _distance(quad.topLeft, quad.topRight);
    final leftHeight = _distance(quad.topLeft, quad.bottomLeft);
    if (leftHeight <= 0) return null;
    final aspect = topWidth / leftHeight;
    if (aspect < _minAspect || aspect > _maxAspect) return null;
    if (!_hasSquareCorners(quad)) return null;
    return quad;
  }

  bool _hasSquareCorners(PageQuad quad) {
    final corners = [quad.topLeft, quad.topRight, quad.bottomRight, quad.bottomLeft];
    for (var index = 0; index < corners.length; index++) {
      final previous = corners[(index + corners.length - 1) % corners.length];
      final current = corners[index];
      final next = corners[(index + 1) % corners.length];
      final angle = _cornerAngle(previous, current, next);
      if (angle == null) return false;
      if ((angle - _straightAngle).abs() > _quadratureTolerance) return false;
    }
    return true;
  }

  double? _cornerAngle(PagePoint previous, PagePoint current, PagePoint next) {
    final firstX = previous.x - current.x;
    final firstY = previous.y - current.y;
    final secondX = next.x - current.x;
    final secondY = next.y - current.y;
    final firstLength = math.sqrt(firstX * firstX + firstY * firstY);
    final secondLength = math.sqrt(secondX * secondX + secondY * secondY);
    if (firstLength <= 0 || secondLength <= 0) return null;
    final cosine = (firstX * secondX + firstY * secondY) / (firstLength * secondLength);
    return math.acos(cosine.clamp(-1.0, 1.0)) * 180 / math.pi;
  }

  PagePoint? _intersect(_Line first, _Line second) {
    final firstCos = _cosTable[first.theta];
    final firstSin = _sinTable[first.theta];
    final secondCos = _cosTable[second.theta];
    final secondSin = _sinTable[second.theta];
    final determinant = firstCos * secondSin - firstSin * secondCos;
    if (determinant.abs() < 1e-6) return null;
    return PagePoint(
      x: (first.rho * secondSin - firstSin * second.rho) / determinant,
      y: (firstCos * second.rho - first.rho * secondCos) / determinant,
    );
  }

  PageQuad _order(List<PagePoint> corners) {
    var topLeft = corners.first;
    var topRight = corners.first;
    var bottomRight = corners.first;
    var bottomLeft = corners.first;
    for (final corner in corners) {
      if (corner.x + corner.y < topLeft.x + topLeft.y) topLeft = corner;
      if (corner.x + corner.y > bottomRight.x + bottomRight.y) bottomRight = corner;
      if (corner.x - corner.y > topRight.x - topRight.y) topRight = corner;
      if (corner.x - corner.y < bottomLeft.x - bottomLeft.y) bottomLeft = corner;
    }
    return PageQuad(
      topLeft: topLeft,
      topRight: topRight,
      bottomRight: bottomRight,
      bottomLeft: bottomLeft,
    );
  }

  bool _isConvex(PageQuad quad) {
    final corners = [quad.topLeft, quad.topRight, quad.bottomRight, quad.bottomLeft];
    var sign = 0;
    for (var index = 0; index < corners.length; index++) {
      final current = corners[index];
      final next = corners[(index + 1) % corners.length];
      final after = corners[(index + 2) % corners.length];
      final cross =
          (next.x - current.x) * (after.y - next.y) - (next.y - current.y) * (after.x - next.x);
      if (cross == 0) continue;
      final currentSign = cross > 0 ? 1 : -1;
      if (sign == 0) {
        sign = currentSign;
      } else if (sign != currentSign) {
        return false;
      }
    }
    return sign != 0;
  }

  bool _coversFrame(PageQuad quad, int width, int height) {
    final marginX = width * _borderMargin;
    final marginY = height * _borderMargin;
    final corners = [quad.topLeft, quad.topRight, quad.bottomRight, quad.bottomLeft];
    for (final corner in corners) {
      final nearHorizontalBorder = corner.x < marginX || corner.x > width - marginX;
      final nearVerticalBorder = corner.y < marginY || corner.y > height - marginY;
      if (!nearHorizontalBorder || !nearVerticalBorder) return false;
    }
    return true;
  }

  bool _hasEdgeSupport(
    PageQuad quad,
    Int32List magnitude,
    int width,
    int height,
    int threshold,
  ) {
    final corners = [quad.topLeft, quad.topRight, quad.bottomRight, quad.bottomLeft];
    for (var index = 0; index < corners.length; index++) {
      final from = corners[index];
      final to = corners[(index + 1) % corners.length];
      if (_edgeSupport(from, to, magnitude, width, height, threshold) < _minEdgeSupport) {
        return false;
      }
    }
    return true;
  }

  double _edgeSupport(
    PagePoint from,
    PagePoint to,
    Int32List magnitude,
    int width,
    int height,
    int threshold,
  ) {
    final length = _distance(from, to);
    if (length < 1) return 0;
    final normalX = -(to.y - from.y) / length;
    final normalY = (to.x - from.x) / length;
    var supported = 0;
    for (var index = 0; index < _supportSamples; index++) {
      final position =
          _supportStart + (_supportEnd - _supportStart) * index / (_supportSamples - 1);
      final anchorX = from.x + (to.x - from.x) * position;
      final anchorY = from.y + (to.y - from.y) * position;
      for (var offset = -_supportRadius; offset <= _supportRadius; offset++) {
        final sampleX = (anchorX + normalX * offset).round();
        final sampleY = (anchorY + normalY * offset).round();
        if (sampleX < 0 || sampleY < 0 || sampleX >= width || sampleY >= height) continue;
        if (magnitude[sampleY * width + sampleX] >= threshold) {
          supported++;
          break;
        }
      }
    }
    return supported / _supportSamples;
  }

  double _area(PageQuad quad) {
    final corners = [quad.topLeft, quad.topRight, quad.bottomRight, quad.bottomLeft];
    var sum = 0.0;
    for (var index = 0; index < corners.length; index++) {
      final current = corners[index];
      final next = corners[(index + 1) % corners.length];
      sum += current.x * next.y - next.x * current.y;
    }
    return sum.abs() / 2;
  }

  double _distance(PagePoint from, PagePoint to) {
    final deltaX = to.x - from.x;
    final deltaY = to.y - from.y;
    return math.sqrt(deltaX * deltaX + deltaY * deltaY);
  }

  PagePoint _normalized(PagePoint pixel, int width, int height) {
    return PagePoint(
      x: (pixel.x / width).clamp(0.0, 1.0),
      y: (pixel.y / height).clamp(0.0, 1.0),
    );
  }
}

class const _Line({
  required final int theta,
  required final double rho,
  required final int votes,
});
