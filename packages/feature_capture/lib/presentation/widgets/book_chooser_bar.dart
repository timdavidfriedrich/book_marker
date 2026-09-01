import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _coverWidth = 36.0;
const _coverHeight = 44.0;

class const BookChooserBar({
  required final String _title,
  required final String? _thumbnailUrl,
  required final String _label,
  final VoidCallback? _onSwitch,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = _title.isEmpty ? context.s.libraryUnknownBook : _title;
    return Container(
      padding: const EdgeInsets.all(Spacing.s),
      decoration: BoxDecoration(
        color: context.palette.paperFill,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
      ),
      child: Row(
        children: [
          BookCover(
            title: title,
            url: _thumbnailUrl,
            width: _coverWidth,
            height: _coverHeight,
            radius: Spacing.radiusS,
          ),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _label,
                  style: context.typography.monoCaption.copyWith(
                    color: context.palette.paperTextFaint,
                  ),
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.t.titleMedium?.copyWith(color: context.palette.paperText),
                ),
              ],
            ),
          ),
          if (_onSwitch case final VoidCallback onSwitch) ...[
            const SizedBox(width: Spacing.s),
            _SwitchButton(onTap: onSwitch),
          ],
        ],
      ),
    );
  }
}

class const _SwitchButton({
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: _onTap,
      color: context.c.primary,
      radius: Spacing.radiusFull,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.s.captureSwitchButton,
            style: context.t.labelMedium?.copyWith(
              color: context.c.onPrimary,
              fontSize: 14,
            ),
          ),
          Icon(Icons.arrow_drop_down, size: Spacing.iconS, color: context.c.onPrimary),
        ],
      ),
    );
  }
}
