import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';

class const InkTapBox({
  required final Widget _child,
  final VoidCallback? _onTap,
  final Color? _color,
  final double _radius = Spacing.radiusM,
  final bool _circle = false,
  final ShapeBorder? _shape,
  final EdgeInsetsGeometry _padding = EdgeInsets.zero,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shape =
        _shape ??
        (_circle
            ? const CircleBorder()
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)));
    return Material(
      color: _color ?? Colors.transparent,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _onTap,
        customBorder: shape,
        child: Padding(padding: _padding, child: _child),
      ),
    );
  }
}
