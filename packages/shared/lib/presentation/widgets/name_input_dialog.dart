import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/adaptive_actions.dart';

const _actionsGap = Spacing.l * 2;

Future<String?> showNameInputDialog(
  BuildContext context, {
  required String title,
  required String hint,
  required String confirmLabel,
  String initialValue = "",
}) {
  return showDialog<String>(
    context: context,
    builder: (_) => Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Spacing.dialogMaxWidth),
        child: _NameInputDialog(
          title: title,
          hint: hint,
          confirmLabel: confirmLabel,
          initialValue: initialValue,
        ),
      ),
    ),
  );
}

class const _NameInputDialog({
  required final String _title,
  required final String _hint,
  required final String _confirmLabel,
  required final String _initialValue,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _initialValue);
    final cancel = OutlinedButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(context.s.cancel),
    );
    final save = FilledButton(
      onPressed: () => Navigator.of(context).pop(controller.text),
      child: Text(_confirmLabel),
    );
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(_title, style: context.t.headlineSmall),
            const SizedBox(height: Spacing.m),
            TextField(
              controller: controller,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(hintText: _hint),
              onSubmitted: (value) => Navigator.of(context).pop(value),
            ),
            const SizedBox(height: _actionsGap),
            AdaptiveActions(children: [cancel, save]),
          ],
        ),
      ),
    );
  }
}
