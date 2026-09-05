import 'package:core/theme/corner_radii.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/page_number_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/count_badge.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _featuredQuoteMaxLines = 3;
const _cardRadius = Spacing.radiusXl;
const _cardPadding = Spacing.m;

class const BookCard({
  required final String _title,
  required final String _meta,
  required final int _count,
  final String? _coverImage,
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
      radius: _cardRadius,
      padding: const EdgeInsets.all(_cardPadding),
      child: Column(
        children: [
          Row(
            children: [
              BookCover(title: _title, image: _coverImage, width: 56, height: 72),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_title, style: context.t.headlineSmall),
                    const SizedBox(height: Spacing.xxs),
                    Text(
                      _meta,
                      style: context.typography.label.copyWith(
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
                borderRadius: BorderRadius.circular(
                  CornerRadii.nested(_cardRadius, _cardPadding),
                ),
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: quote, style: context.typography.readingQuote),
                    if (_featuredPages.isNotEmpty)
                      TextSpan(
                        text: "  ${context.s.pageShortLabel(_featuredPages.toPageLabel())}",
                        style: context.typography.label.copyWith(
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
