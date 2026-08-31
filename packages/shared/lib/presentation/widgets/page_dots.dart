import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _dotSize = 6.0;
const _activeDotWidth = 18.0;
const _inactiveOpacity = 0.3;
const _dotDuration = Duration(milliseconds: 180);

class const PageDots({
  required final int _count,
  required final int _index,
  final Color? _color,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (_count < 2) return const SizedBox.shrink();
    final color = _color ?? context.c.onSurfaceVariant;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < _count; index++) ...[
          if (index > 0) const SizedBox(width: Spacing.xxs),
          AnimatedContainer(
            duration: _dotDuration,
            curve: Curves.easeOut,
            width: index == _index ? _activeDotWidth : _dotSize,
            height: _dotSize,
            decoration: BoxDecoration(
              color: index == _index ? color : color.withValues(alpha: _inactiveOpacity),
              borderRadius: BorderRadius.circular(Spacing.radiusFull),
            ),
          ),
        ],
      ],
    );
  }
}
