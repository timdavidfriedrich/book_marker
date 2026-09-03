import 'dart:math' as math;

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/page_quad.dart';

const _dashLength = 10.0;
const _dashGap = 7.0;

class const PageQuadOverlay({
  required final PageQuad _quad,
  required final Color _lineColor,
  final Color? _scrimColor,
  final bool _dashed = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _PageQuadPainter(
        quad: _quad,
        lineColor: _lineColor,
        scrimColor: _scrimColor,
        dashed: _dashed,
      ),
    );
  }
}

class const _PageQuadPainter({
  required final PageQuad _quad,
  required final Color _lineColor,
  required final Color? _scrimColor,
  required final bool _dashed,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(_quad.topLeft.x * size.width, _quad.topLeft.y * size.height)
      ..lineTo(_quad.topRight.x * size.width, _quad.topRight.y * size.height)
      ..lineTo(_quad.bottomRight.x * size.width, _quad.bottomRight.y * size.height)
      ..lineTo(_quad.bottomLeft.x * size.width, _quad.bottomLeft.y * size.height)
      ..close();
    if (_scrimColor case final Color scrim) {
      canvas.drawPath(
        Path.combine(PathOperation.difference, Path()..addRect(Offset.zero & size), path),
        Paint()..color = scrim,
      );
    }
    canvas.drawPath(
      _dashed ? _dashedPath(path) : path,
      Paint()
        ..color = _lineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = Spacing.borderWidthMedium
        ..strokeJoin = StrokeJoin.round,
    );
  }

  Path _dashedPath(Path source) {
    final dashed = Path();
    for (final metric in source.computeMetrics()) {
      var start = 0.0;
      while (start < metric.length) {
        final end = math.min(start + _dashLength, metric.length);
        dashed.addPath(metric.extractPath(start, end), Offset.zero);
        start = end + _dashGap;
      }
    }
    return dashed;
  }

  @override
  bool shouldRepaint(covariant _PageQuadPainter oldDelegate) {
    return oldDelegate._quad != _quad ||
        oldDelegate._lineColor != _lineColor ||
        oldDelegate._scrimColor != _scrimColor ||
        oldDelegate._dashed != _dashed;
  }
}
