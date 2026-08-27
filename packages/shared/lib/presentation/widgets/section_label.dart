import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _dotSize = 12.0;

class const SectionLabel({
  required final String _text,
  required final Color _dotColor,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: _dotSize,
          height: _dotSize,
          decoration: BoxDecoration(color: _dotColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: Spacing.xs),
        Flexible(
          child: Text(
            _text,
            style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
