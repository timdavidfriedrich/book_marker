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
    builder: (_) => _NameInputDialog(title: title, hint: hint, initialValue: initialValue),
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
    return Dialog(
      child: Padding(
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
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.s.cancel),
              ),
            ),
            const SizedBox(height: Spacing.xs),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text(context.s.save),
            ),
          ],
        ),
      ),
    );
  }
}
