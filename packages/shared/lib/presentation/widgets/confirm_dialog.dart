import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/adaptive_actions.dart';

const _actionsGap = Spacing.l * 2;

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (_) => Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Spacing.dialogMaxWidth),
        child: _ConfirmDialog(
          title: title,
          message: message,
          confirmLabel: confirmLabel,
          destructive: destructive,
        ),
      ),
    ),
  );
  return result ?? false;
}

class const _ConfirmDialog({
  required final String _title,
  required final String _message,
  required final String _confirmLabel,
  required final bool _destructive,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(_title, style: context.t.headlineSmall),
            const SizedBox(height: Spacing.s),
            Text(
              _message,
              style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
            ),
            const SizedBox(height: _actionsGap),
            AdaptiveActions(
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(context.s.cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: _destructive
                      ? FilledButton.styleFrom(
                          backgroundColor: context.c.error,
                          foregroundColor: context.c.onError,
                        )
                      : null,
                  child: Text(_confirmLabel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
