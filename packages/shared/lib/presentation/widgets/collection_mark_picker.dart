import 'package:core/theme/collection_symbol.dart';
import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/collection_symbol_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/collection_mark.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/section_label.dart';

const _previewSize = 72.0;
const _tileSize = 48.0;

class const CollectionMarkPicker({
  required final CollectionKind _kind,
  required final AccentColor _accent,
  required final CollectionSymbol _symbol,
  required final ValueChanged<CollectionSymbol> _onSymbolSelected,
  required final ValueChanged<AccentColor> _onAccentSelected,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CollectionMark(
              kind: _kind,
              accent: _accent,
              symbol: _symbol,
              size: _previewSize,
            ),
          ),
          const SizedBox(height: Spacing.l),
          SectionLabel(text: context.s.markPickerSymbolLabel, dotColor: context.c.outline),
          const SizedBox(height: Spacing.s),
          Wrap(
            spacing: Spacing.s,
            runSpacing: Spacing.s,
            children: [
              for (final symbol in CollectionSymbol.values)
                _SymbolTile(
                  kind: _kind,
                  accent: _accent,
                  symbol: symbol,
                  selected: symbol == _symbol,
                  onTap: () => _onSymbolSelected(symbol),
                ),
            ],
          ),
          const SizedBox(height: Spacing.l),
          SectionLabel(text: context.s.markPickerColorLabel, dotColor: context.c.outline),
          const SizedBox(height: Spacing.s),
          Wrap(
            spacing: Spacing.s,
            runSpacing: Spacing.s,
            children: [
              for (final accent in AccentColor.values)
                _AccentTile(
                  kind: _kind,
                  accent: accent,
                  selected: accent == _accent,
                  onTap: () => _onAccentSelected(accent),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class const _SymbolTile({
  required final CollectionKind _kind,
  required final AccentColor _accent,
  required final CollectionSymbol _symbol,
  required final bool _selected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.resolve(_accent);
    return InkTapBox(
      onTap: _onTap,
      shape: _kind.toShape(_tileSize),
      color: _selected ? swatch.solid : context.c.surfaceContainerHigh,
      child: SizedBox(
        width: _tileSize,
        height: _tileSize,
        child: Icon(
          _symbol.toIcon(),
          size: Spacing.iconM,
          color: _selected ? swatch.onSolid : context.c.onSurfaceVariant,
        ),
      ),
    );
  }
}

class const _AccentTile({
  required final CollectionKind _kind,
  required final AccentColor _accent,
  required final bool _selected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.resolve(_accent);
    return InkTapBox(
      onTap: _onTap,
      shape: _kind.toShape(_tileSize),
      color: swatch.solid,
      child: SizedBox(
        width: _tileSize,
        height: _tileSize,
        child: _selected
            ? Icon(Icons.check, size: Spacing.iconM, color: swatch.onSolid)
            : const SizedBox.shrink(),
      ),
    );
  }
}
