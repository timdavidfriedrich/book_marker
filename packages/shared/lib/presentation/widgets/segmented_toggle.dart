import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _trackPadding = 4.0;

class const SegmentedToggle({
  required final List<String> _labels,
  required final int _selectedIndex,
  required final ValueChanged<int> _onChanged,
  final Color? _trackColor,
  final Color? _activeColor,
  final Color? _activeTextColor,
  final Color? _inactiveTextColor,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trackColor = _trackColor ?? context.c.surfaceContainerHigh;
    final activeColor = _activeColor ?? context.c.inverseSurface;
    final activeTextColor = _activeTextColor ?? context.c.onInverseSurface;
    final inactiveTextColor = _inactiveTextColor ?? context.c.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.all(_trackPadding),
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
      ),
      child: Row(
        children: [
          for (var index = 0; index < _labels.length; index++)
            Expanded(
              child: InkTapBox(
                onTap: () => _onChanged(index),
                color: index == _selectedIndex ? activeColor : Colors.transparent,
                radius: Spacing.radiusFull,
                padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
                child: Text(
                  _labels[index],
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.t.labelMedium?.copyWith(
                    color: index == _selectedIndex ? activeTextColor : inactiveTextColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
