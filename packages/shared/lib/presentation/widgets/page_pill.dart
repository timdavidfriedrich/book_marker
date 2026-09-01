import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/page_number_extensions.dart';

class const PagePill({
  required final List<int> _pages,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xs, vertical: Spacing.xxxs),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusS),
      ),
      child: Text(
        context.s.pageShortLabel(_pages.toPageLabel()),
        style: context.typography.monoBadge.copyWith(color: context.c.onSurfaceVariant),
      ),
    );
  }
}
