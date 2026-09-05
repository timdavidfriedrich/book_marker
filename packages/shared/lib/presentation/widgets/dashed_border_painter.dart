import 'dart:math' as math;

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';

const _dashLength = 4.0;
const _dashGap = 3.0;

class const DashedBorderPainter({
  required final Color _color,
  final double _radius = Spacing.radiusM,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _color
      ..style = PaintingStyle.stroke
      ..strokeWidth = Spacing.borderWidthThin;
    final radius = math.min(_radius, size.shortestSide / 2);
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)));
    for (final metric in path.computeMetrics()) {
      var start = 0.0;
      while (start < metric.length) {
        canvas.drawPath(
          metric.extractPath(start, math.min(start + _dashLength, metric.length)),
          paint,
        );
        start += _dashLength + _dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) =>
      oldDelegate._color != _color || oldDelegate._radius != _radius;
}
