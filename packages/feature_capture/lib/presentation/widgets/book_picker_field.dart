import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _coverWidth = 36.0;
const _coverHeight = 48.0;
const _switchSize = 30.0;
const _titleMaxLines = 2;

class const BookPickerField({
  required final String _title,
  required final String? _coverImage,
  required final VoidCallback _onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = _title.isEmpty ? context.s.libraryUnknownBook : _title;
    return InkTapBox(
      onTap: _onTap,
      color: context.c.surfaceContainer,
      radius: Spacing.radiusL,
      padding: const EdgeInsets.all(Spacing.s),
      child: Row(
        children: [
          BookCover(
            title: title,
            image: _coverImage,
            width: _coverWidth,
            height: _coverHeight,
            radius: Spacing.radiusS,
          ),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Text(
              title,
              maxLines: _titleMaxLines,
              overflow: TextOverflow.ellipsis,
              style: context.t.titleMedium,
            ),
          ),
          const SizedBox(width: Spacing.s),
          Container(
            width: _switchSize,
            height: _switchSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.c.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: Spacing.iconS,
              color: context.c.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
