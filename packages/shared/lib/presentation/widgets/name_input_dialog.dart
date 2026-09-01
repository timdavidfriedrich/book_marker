import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

Future<String?> showNameInputDialog(
  BuildContext context, {
  required String title,
  required String hint,
  String initialValue = "",
}) {
  return showDialog<String>(
    context: context,
    // * a dialog stretched across a landscape viewport reads badly, so it keeps a phone measure
    builder: (_) => Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Spacing.dialogMaxWidth),
        child: _NameInputDialog(title: title, hint: hint, initialValue: initialValue),
      ),
    ),
  );
}

class const _NameInputDialog({
  required final String _title,
  required final String _hint,
  required final String _initialValue,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _initialValue);
    final cancel = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(context.s.cancel),
    );
    final save = FilledButton(
      onPressed: () => Navigator.of(context).pop(controller.text),
      child: Text(context.s.save),
    );
    return Dialog(
      // * the keyboard leaves little height in landscape, so the dialog scrolls and pairs its
      // * actions instead of stacking them
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
            const SizedBox(height: Spacing.s),
            if (context.layout.isLandscape)
              Row(
                children: [
                  cancel,
                  const SizedBox(width: Spacing.s),
                  Expanded(child: save),
                ],
              )
            else ...[
              Align(alignment: Alignment.centerRight, child: cancel),
              const SizedBox(height: Spacing.xs),
              save,
            ],
          ],
        ),
      ),
    );
  }
}
