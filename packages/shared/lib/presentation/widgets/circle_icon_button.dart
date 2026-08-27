import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const CircleIconButton({
  required final IconData _icon,
  required final VoidCallback? _onPressed,
  final Color? _backgroundColor,
  final Color? _foregroundColor,
  final double _size = 44,
  final String? _tooltip,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onPressed,
      tooltip: _tooltip,
      icon: Icon(_icon),
      iconSize: Spacing.iconM,
      style: IconButton.styleFrom(
        backgroundColor: _backgroundColor ?? context.c.surfaceContainerHigh,
        foregroundColor: _foregroundColor ?? context.c.onSurface,
        fixedSize: Size.square(_size),
        minimumSize: Size.square(_size),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const CircleBorder(),
      ),
    );
  }
}
