import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/paper_card.dart';

const _quoteMark = "“";
const _quoteMarkSize = 48.0;
const _quoteMarkRise = 7.0;
const _quoteCardPadding = EdgeInsets.fromLTRB(Spacing.l, Spacing.xl, Spacing.l, Spacing.l);

class const QuotePaperCard({
  required final Widget _child,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // * the mark rises above the card, so the widget reserves that strip instead of overflowing
    return Padding(
      padding: const EdgeInsets.only(top: _quoteMarkRise),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: double.infinity,
            child: PaperCard(padding: _quoteCardPadding, child: _child),
          ),
          Positioned(
            left: Spacing.l,
            top: -_quoteMarkRise,
            child: Text(
              _quoteMark,
              style: context.typography.readingQuote.copyWith(
                color: context.palette.paperTextFaint,
                fontSize: _quoteMarkSize,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
