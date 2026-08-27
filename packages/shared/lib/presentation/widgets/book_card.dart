import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/count_badge.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

class const BookCard({
  required final AccentColor _accent,
  required final String _title,
  required final String _meta,
  required final int _count,
  final String? _thumbnailUrl,
  final String? _featuredQuote,
  final int? _featuredPage,
  final VoidCallback? _onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.resolve(_accent);
    return InkTapBox(
      onTap: _onTap,
      color: swatch.fill,
      radius: Spacing.radiusXl,
      padding: const EdgeInsets.all(Spacing.m),
      child: Column(
          children: [
            Row(
              children: [
                BookCover(accent: _accent, url: _thumbnailUrl, width: 56, height: 72),
                const SizedBox(width: Spacing.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _title,
                        style: context.t.headlineSmall?.copyWith(color: swatch.onFill),
                      ),
                      const SizedBox(height: Spacing.xxs),
                      Text(
                        _meta,
                        style: context.typography.monoLabel.copyWith(color: swatch.onFillVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: Spacing.s),
                CountBadge(count: _count, accent: _accent),
              ],
            ),
            if (_featuredQuote case final String quote) ...[
              const SizedBox(height: Spacing.m),
              Container(
                padding: const EdgeInsets.all(Spacing.s),
                decoration: BoxDecoration(
                  color: context.c.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(Spacing.radiusL),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookCover(
                      accent: _accent,
                      url: _thumbnailUrl,
                      width: 36,
                      height: 48,
                      radius: Spacing.radiusS,
                    ),
                    const SizedBox(width: Spacing.s),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: quote, style: context.typography.readingQuote),
                            if (_featuredPage case final int page)
                              TextSpan(
                                text: "  ${context.s.pageShortLabel(page)}",
                                style: context.typography.monoLabel
                                    .copyWith(color: context.c.onSurfaceVariant),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
    );
  }
}
