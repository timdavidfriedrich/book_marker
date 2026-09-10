import 'dart:async';

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/navigation/routes.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _sheetRadius = 34.0;
const _handleWidth = 42.0;
const _handleHeight = 4.0;
const _actionRadius = Spacing.radiusXl;
const _actionPadding = EdgeInsets.symmetric(vertical: Spacing.m);

Future<void> showBackupPrompt(BuildContext context) async {
  final wantsSetUp = await showModalBottomSheet<bool>(
    context: context,
    showDragHandle: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(_sheetRadius)),
    ),
    builder: (_) => const _BackupPromptSheet(),
  );
  if (!(wantsSetUp ?? false) || !context.mounted) return;
  unawaited(context.appRouter.push(const SignIn()));
}

class const _BackupPromptSheet() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: _handleWidth,
                height: _handleHeight,
                decoration: BoxDecoration(
                  color: context.c.outlineVariant,
                  borderRadius: const BorderRadius.all(Radius.circular(_handleHeight)),
                ),
              ),
            ),
            const SizedBox(height: Spacing.l),
            Text(context.s.backupPromptTitle, style: context.t.titleLarge),
            const SizedBox(height: Spacing.l),
            _Action(
              label: context.s.backupPromptSetUp,
              color: context.c.inverseSurface,
              foreground: context.c.onInverseSurface,
              onTap: () => Navigator.of(context).pop(true),
            ),
            const SizedBox(height: Spacing.xxxs),
            _Action(
              label: context.s.backupPromptLater,
              color: context.c.surfaceContainer,
              foreground: context.c.onSurfaceVariant,
              onTap: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      ),
    );
  }
}

class const _Action({
  required final String _label,
  required final Color _color,
  required final Color _foreground,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: _onTap,
      color: _color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(_actionRadius)),
      ),
      padding: _actionPadding,
      child: Center(
        child: Text(_label, style: context.t.titleSmall?.copyWith(color: _foreground)),
      ),
    );
  }
}
