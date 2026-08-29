import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/page_quad.dart';

class const PageQuadOverlay({
  required final PageQuad _quad,
  required final Color _lineColor,
  final Color? _scrimColor,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _PageQuadPainter(quad: _quad, lineColor: _lineColor, scrimColor: _scrimColor),
    );
  }
}

class const _PageQuadPainter({
  required final PageQuad _quad,
  required final Color _lineColor,
  required final Color? _scrimColor,
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
      path,
      Paint()
        ..color = _lineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = Spacing.borderWidthMedium
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant _PageQuadPainter oldDelegate) {
    return oldDelegate._quad != _quad ||
        oldDelegate._lineColor != _lineColor ||
        oldDelegate._scrimColor != _scrimColor;
  }
}
