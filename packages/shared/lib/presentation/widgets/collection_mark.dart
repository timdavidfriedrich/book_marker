import 'package:core/theme/collection_symbol.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/collection_symbol_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

enum CollectionKind { shelf, theme }

const _defaultSize = 44.0;
const _squircleRadiusRatio = 0.3;
const _iconSizeRatio = 0.46;

extension CollectionKindExtensions on CollectionKind {
  ShapeBorder toShape(double size) {
    return switch (this) {
      CollectionKind.theme => const CircleBorder(),
      CollectionKind.shelf => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size * _squircleRadiusRatio),
      ),
    };
  }
}

class const CollectionMark({
  required final CollectionKind _kind,
  required final AccentColor _accent,
  required final CollectionSymbol _symbol,
  final double _size = _defaultSize,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.resolve(_accent);
    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: ShapeDecoration(color: swatch.solid, shape: _kind.toShape(_size)),
      child: Icon(_symbol.toIcon(), color: swatch.onSolid, size: _size * _iconSizeRatio),
    );
  }
}
