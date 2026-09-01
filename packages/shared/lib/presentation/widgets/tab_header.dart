import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/profile_avatar.dart';

const tabHeaderHeight = profileAvatarSize + Spacing.m + Spacing.s;

class const TabHeader({
  required final String _title,
  final Widget? _center,
  final double _contentHeight = profileAvatarSize,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = Text(
      _title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.t.displaySmall,
    );
    return ColoredBox(
      color: context.c.surface,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          context.layout.pageMargin,
          Spacing.m,
          context.layout.pageMargin,
          Spacing.s,
        ),
        child: SizedBox(
          height: _contentHeight,
          child: Row(
            children: [
              if (_center case final Widget center) ...[
                title,
                const SizedBox(width: Spacing.l),
                Expanded(
                  child: Align(alignment: Alignment.centerRight, child: center),
                ),
                const SizedBox(width: Spacing.m),
              ] else
                Expanded(child: title),
              ProfileAvatar(onTap: context.pushSettings),
            ],
          ),
        ),
      ),
    );
  }
}
