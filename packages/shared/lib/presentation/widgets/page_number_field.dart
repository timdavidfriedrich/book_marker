import 'package:core/theme/spacing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/page_number_extensions.dart';

const _fieldWidth = 88.0;
final _allowedCharacters = RegExp(r"[0-9,;\-– ]");

class const PageNumberField({
  required final List<int> _pages,
  required final ValueChanged<List<int>> _onChanged,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _pages.toPageLabel());
    // * comparing parsed pages keeps a half typed separator while outside changes still land here
    useEffect(() {
      if (!listEquals(controller.text.toPageNumbers(), _pages)) {
        controller.text = _pages.toPageLabel();
      }
      return null;
    }, [_pages]);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.s),
      decoration: BoxDecoration(
        color: context.c.surfaceContainer,
        borderRadius: BorderRadius.circular(Spacing.radiusL),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.s.pageFieldLabel,
            style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
          ),
          SizedBox(
            width: _fieldWidth,
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              inputFormatters: [FilteringTextInputFormatter.allow(_allowedCharacters)],
              style: context.t.titleMedium?.copyWith(color: context.c.onSurface),
              decoration: InputDecoration(
                isDense: true,
                filled: false,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: context.s.pageFieldHint,
                hintStyle: context.t.titleMedium?.copyWith(color: context.c.outline),
              ),
              onChanged: (value) => _onChanged(value.toPageNumbers()),
            ),
          ),
        ],
      ),
    );
  }
}
