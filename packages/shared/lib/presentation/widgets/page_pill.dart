import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/page_number_extensions.dart';

class const PagePill({
  required final List<int> _pages,
  final AccentColor _accent = AccentColor.sand,
  final bool _filled = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.resolve(_accent);
    final background = _filled ? swatch.solid : swatch.fill;
    final foreground = _filled ? swatch.onSolid : swatch.onFillVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xs, vertical: Spacing.xxxs),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(Spacing.radiusS),
      ),
      child: Text(
        context.s.pageShortLabel(_pages.toPageLabel()),
        style: context.typography.monoBadge.copyWith(color: foreground),
      ),
    );
  }
}
