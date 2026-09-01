import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/page_number_extensions.dart';

const _fieldWidth = 88.0;
const _fieldFontSize = 18.0;
final _allowedCharacters = RegExp(r"[0-9,;\-– ]");

class const PageNumberField({
  required final List<int> _pages,
  required final ValueChanged<List<int>> _onChanged,
  final bool _wasDetected = false,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _pages.toPageLabel());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusM),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.s.pageFieldLabel,
            style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
          ),
          const SizedBox(width: Spacing.s),
          SizedBox(
            width: _fieldWidth,
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              inputFormatters: [FilteringTextInputFormatter.allow(_allowedCharacters)],
              style: context.typography.labelStrong.copyWith(
                fontSize: _fieldFontSize,
                color: context.c.onSurface,
              ),
              decoration: InputDecoration(
                isDense: true,
                filled: false,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: context.s.pageFieldHint,
              ),
              onChanged: (value) => _onChanged(value.toPageNumbers()),
            ),
          ),
          if (_wasDetected)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.xs, vertical: Spacing.xxxs),
              decoration: BoxDecoration(
                color: context.c.secondary,
                borderRadius: BorderRadius.circular(Spacing.radiusFull),
              ),
              child: Text(
                context.s.pageAutoLabel,
                style: context.typography.badge.copyWith(color: context.c.onSecondary),
              ),
            ),
        ],
      ),
    );
  }
}
