import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _badgeTextSize = 15.0;

class const CountBadge({
  required final int _count,
  required final AccentColor _accent,
  final double _size = 44,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.resolve(_accent);
    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: swatch.solid, shape: BoxShape.circle),
      child: Text(
        "$_count",
        style: context.typography.monoLabelStrong.copyWith(
          color: swatch.onSolid,
          fontSize: _badgeTextSize,
        ),
      ),
    );
  }
}
