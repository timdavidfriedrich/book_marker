import 'package:core/theme/accent_color.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _swatchSize = 56.0;

class const AccentPicker({
  super.key,
  required final AccentColor? _selected,
  required final ValueChanged<AccentColor?> _onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Spacing.m,
      runSpacing: Spacing.m,
      children: [
        for (final accent in AccentColor.values)
          _Swatch(accent: accent, selected: _selected == accent, onTap: () => _onSelected(accent)),
        _AutoSwatch(selected: _selected == null, onTap: () => _onSelected(null)),
      ],
    );
  }
}

class const _Swatch({
  required final AccentColor _accent,
  required final bool _selected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.resolve(_accent);
    return SizedBox(
      width: _swatchSize,
      height: _swatchSize,
      child: InkTapBox(
        circle: true,
        color: swatch.solid,
        onTap: _onTap,
        child: _selected
            ? Icon(Icons.check, color: swatch.onSolid, size: Spacing.iconM)
            : const SizedBox.shrink(),
      ),
    );
  }
}

class const _AutoSwatch({
  required final bool _selected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _swatchSize,
      height: _swatchSize,
      child: InkTapBox(
        circle: true,
        color: context.c.surfaceContainerHigh,
        onTap: _onTap,
        child: Icon(
          _selected ? Icons.check : Icons.auto_awesome,
          color: context.c.onSurfaceVariant,
          size: Spacing.iconM,
        ),
      ),
    );
  }
}
