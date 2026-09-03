import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const PageCornerDot({
  super.key,
}) extends StatelessWidget {
  static const double size = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: context.c.primary,
        shape: BoxShape.circle,
        border: Border.all(color: context.c.surface, width: Spacing.borderWidthMedium),
      ),
    );
  }
}
