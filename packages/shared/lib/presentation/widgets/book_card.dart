import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/page_number_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/count_badge.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _featuredQuoteMaxLines = 3;

class const BookCard({
  required final String _title,
  required final String _meta,
  required final int _count,
  final String? _thumbnailUrl,
  final String? _featuredQuote,
  final List<int> _featuredPages = const [],
  final VoidCallback? _onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: _onTap,
      color: context.c.surfaceContainerLow,
      radius: Spacing.radiusXl,
      padding: const EdgeInsets.all(Spacing.m),
      child: Column(
        children: [
          Row(
            children: [
              BookCover(title: _title, url: _thumbnailUrl, width: 56, height: 72),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_title, style: context.t.headlineSmall),
                    const SizedBox(height: Spacing.xxs),
                    Text(
                      _meta,
                      style: context.typography.monoLabel.copyWith(
                        color: context.c.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.s),
              CountBadge(count: _count),
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
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: quote, style: context.typography.readingQuote),
                    if (_featuredPages.isNotEmpty)
                      TextSpan(
                        text: "  ${context.s.pageShortLabel(_featuredPages.toPageLabel())}",
                        style: context.typography.monoLabel.copyWith(
                          color: context.c.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
                maxLines: _featuredQuoteMaxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
