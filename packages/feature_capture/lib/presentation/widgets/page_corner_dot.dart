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
    final color = switch (_corner) {
      PageCorner.topLeft || PageCorner.topRight => context.c.primary,
      PageCorner.bottomLeft || PageCorner.bottomRight => context.c.tertiary,
    };
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
