import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const PaperCard({
  required final Widget _child,
  final EdgeInsetsGeometry _padding = const EdgeInsets.all(Spacing.l),
  final double _radius = Spacing.radiusL,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        color: context.palette.paperFill,
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: _child,
    );
  }
}
