import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const StatusChip({
  required final String _label,
  required final IconData _icon,
  final Color? _backgroundColor,
  final Color? _foregroundColor,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foreground = _foregroundColor ?? context.c.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xs, vertical: Spacing.xxxs),
      decoration: BoxDecoration(
        color: _backgroundColor ?? context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: Spacing.iconS, color: foreground),
          const SizedBox(width: Spacing.xxs),
          Text(_label, style: context.typography.label.copyWith(color: foreground)),
        ],
      ),
    );
  }
}
