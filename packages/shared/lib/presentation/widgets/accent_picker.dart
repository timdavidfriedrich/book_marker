import 'package:core/theme/accent_color.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _swatchColumns = 5;

class const AccentPicker({
  super.key,
  required final AccentColor? _selected,
  required final ValueChanged<AccentColor?> _onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: _swatchColumns,
      mainAxisSpacing: Spacing.s,
      crossAxisSpacing: Spacing.s,
      children: [
        _AutoSwatch(selected: _selected == null, onTap: () => _onSelected(null)),
        for (final accent in AccentColor.values)
          _Swatch(accent: accent, selected: _selected == accent, onTap: () => _onSelected(accent)),
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
    return InkTapBox(
      circle: true,
      color: swatch.solid,
      onTap: _onTap,
      child: _selected
          ? Icon(Icons.check, color: swatch.onSolid, size: Spacing.iconM)
          : const SizedBox.shrink(),
    );
  }
}

class const _AutoSwatch({
  required final bool _selected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      circle: true,
      color: context.c.surfaceContainerHigh,
      onTap: _onTap,
      child: Icon(
        _selected ? Icons.check : Icons.auto_awesome,
        color: context.c.onSurfaceVariant,
        size: Spacing.iconM,
      ),
    );
  }
}
