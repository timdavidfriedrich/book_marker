import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const uncertainBadgeSize = 14.0;
const _badgeGap = 2.0;
const uncertainBadgeInlineOffset = Offset(
  uncertainBadgeSize + _badgeGap,
  -uncertainBadgeSize / 2,
);

class const UncertainWordChip({
  required final String _text,
  required final int _number,
  required final VoidCallback _onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.sky;
    return Padding(
      padding: const EdgeInsets.only(right: uncertainBadgeSize + _badgeGap),
      child: Badge(
        label: Text("$_number"),
        alignment: AlignmentDirectional.topEnd,
        offset: uncertainBadgeInlineOffset,
        child: InkTapBox(
          onTap: _onTap,
          color: swatch.fill,
          radius: Spacing.radiusS,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xxs),
          child: Text(
            _text,
            style: context.typography.readingBody.copyWith(color: swatch.onFill, height: 1),
          ),
        ),
      ),
    );
  }
}
