import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/adaptive_actions.dart';

const _actionsGap = Spacing.l * 2;

Future<bool> showDeleteAccountDialog(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (_) => Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Spacing.dialogMaxWidth),
        child: const _DeleteAccountDialog(),
      ),
    ),
  );
  return confirmed ?? false;
}

// * the same typed word as signing out with removal, and for the same reason:
// * a rare irreversible action is worth a moment of friction, and this one is
// * the only thing in the app that destroys data the user cannot get back
class const _DeleteAccountDialog() extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    useListenable(controller);
    final word = context.s.signOutConfirmWord;
    final canDelete = controller.text.trim() == word;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.s.deleteAccountDialogTitle, style: context.t.titleLarge),
            const SizedBox(height: Spacing.s),
            Text(
              context.s.deleteAccountDialogBody,
              style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
            ),
            const SizedBox(height: Spacing.m),
            Text(
              context.s.signOutConfirmHint(word),
              style: context.t.bodySmall?.copyWith(color: context.c.onSurfaceVariant),
            ),
            const SizedBox(height: Spacing.xs),
            TextField(
              controller: controller,
              autocorrect: false,
              enableSuggestions: false,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                hintText: word,
                suffixIcon: canDelete
                    ? Icon(Icons.check, color: context.c.primary, size: Spacing.iconM)
                    : null,
              ),
            ),
            const SizedBox(height: _actionsGap),
            AdaptiveActions(
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(context.s.cancel),
                ),
                FilledButton(
                  onPressed: canDelete ? () => Navigator.of(context).pop(true) : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: context.c.error,
                    foregroundColor: context.c.onError,
                  ),
                  child: Text(context.s.deleteAccountConfirmAction),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
