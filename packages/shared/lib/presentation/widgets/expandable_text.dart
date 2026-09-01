import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

class const ExpandableText({
  required final String _text,
  required final int _maxLines,
  final TextStyle? _style,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final expanded = useState(false);
    final style = _style ?? context.t.bodyMedium;
    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(text: _text, style: style),
          maxLines: _maxLines,
          textDirection: Directionality.of(context),
          textScaler: MediaQuery.textScalerOf(context),
        )..layout(maxWidth: constraints.maxWidth);
        final isTruncated = painter.didExceedMaxLines;
        painter.dispose();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _text,
              style: style,
              maxLines: expanded.value ? null : _maxLines,
              overflow: expanded.value ? TextOverflow.clip : TextOverflow.ellipsis,
            ),
            if (isTruncated) ...[
              const SizedBox(height: Spacing.xxs),
              Align(
                alignment: Alignment.centerRight,
                child: InkTapBox(
                  onTap: () => expanded.value = !expanded.value,
                  radius: Spacing.radiusS,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.xxs,
                    vertical: Spacing.xxxs,
                  ),
                  child: Text(
                    expanded.value ? context.s.showLess : context.s.showMore,
                    style: context.typography.label.copyWith(
                      color: context.c.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
