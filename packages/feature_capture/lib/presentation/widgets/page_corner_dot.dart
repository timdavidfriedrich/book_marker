import 'package:flutter/material.dart';
import 'package:shared/domain/entities/page_quad.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const PageCornerDot({
  required final PageCorner _corner,
  super.key,
}) extends StatelessWidget {
  static const double size = 14;

  @override
  Widget build(BuildContext context) {
    final swatch = switch (_corner) {
      PageCorner.topLeft || PageCorner.topRight => context.palette.amber,
      PageCorner.bottomLeft || PageCorner.bottomRight => context.palette.coral,
    };
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: swatch.solid, shape: BoxShape.circle),
    );
  }
}
