import 'package:flutter/material.dart';

const _defaultGap = 9.0;
const _defaultStroke = 5.0;

class HatchPainter extends CustomPainter {
  const HatchPainter({
    required this.color,
    this.gap = _defaultGap,
    this.strokeWidth = _defaultStroke,
  });

  final Color color;
  final double gap;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final step = gap + strokeWidth;
    for (var x = -size.height; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(HatchPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.gap != gap ||
      oldDelegate.strokeWidth != strokeWidth;
}
