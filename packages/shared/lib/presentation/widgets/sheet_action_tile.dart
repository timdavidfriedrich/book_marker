import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

class const SheetActionTile({
  super.key,
  required final IconData _icon,
  required final String _label,
  required final VoidCallback _onTap,
  final bool _destructive = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = _destructive ? context.c.error : context.c.onSurface;
    return InkTapBox(
      radius: Spacing.radiusM,
      padding: const EdgeInsets.all(Spacing.m),
      onTap: _onTap,
      child: Row(
        children: [
          Icon(_icon, color: color, size: Spacing.iconM),
          const SizedBox(width: Spacing.s),
          Text(_label, style: context.t.titleMedium?.copyWith(color: color)),
        ],
      ),
    );
  }
}
