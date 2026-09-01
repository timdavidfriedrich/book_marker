import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _badgeTextSize = 15.0;

class const CountBadge({
  required final int _count,
  final double _size = 44,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: context.c.inverseSurface, shape: BoxShape.circle),
      child: Text(
        "$_count",
        style: context.typography.labelStrong.copyWith(
          color: context.c.onInverseSurface,
          fontSize: _badgeTextSize,
        ),
      ),
    );
  }
}
