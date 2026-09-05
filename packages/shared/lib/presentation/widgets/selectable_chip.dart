import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/dashed_border_painter.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

class const SelectableChip({
  required final String _label,
  required final bool _selected,
  required final VoidCallback _onTap,
  final Color? _selectedColor,
  final Color? _selectedTextColor,
  final Widget? _trailing,
  final bool _outlined = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedColor = _selectedColor ?? context.c.primary;
    final selectedTextColor = _selectedTextColor ?? context.c.onPrimary;
    final dashed = _outlined && !_selected;
    final background = switch ((_selected, dashed)) {
      (true, _) => selectedColor,
      (false, true) => Colors.transparent,
      (false, false) => context.c.surfaceContainerHigh,
    };
    final foreground = _selected ? selectedTextColor : context.c.onSurfaceVariant;
    return CustomPaint(
      painter: dashed
          ? DashedBorderPainter(color: context.c.outline, radius: Spacing.radiusFull)
          : null,
      child: InkTapBox(
        onTap: _onTap,
        color: background,
        radius: Spacing.radiusFull,
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                _label,
                style: context.t.labelMedium?.copyWith(color: foreground, fontSize: 14),
              ),
            ),
            if (_trailing case final Widget trailing) ...[
              const SizedBox(width: Spacing.xxs),
              trailing,
            ],
          ],
        ),
      ),
    );
  }
}
