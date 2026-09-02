import 'dart:io';

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/highlight_region.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _highlightFillOpacity = 0.3;
const _cacheWidth = 2000;

class const HighlightImage({
  required final String _imagePath,
  required final double _aspectRatio,
  required final List<HighlightRegion> _highlights,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _aspectRatio,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;
          return Stack(
            children: [
              Positioned.fill(
                child: Image.file(File(_imagePath), cacheWidth: _cacheWidth, fit: BoxFit.fill),
              ),
              for (final highlight in _highlights)
                Positioned(
                  left: highlight.left * size.width,
                  top: highlight.top * size.height,
                  width: highlight.width * size.width,
                  height: highlight.height * size.height,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.c.primary.withValues(alpha: _highlightFillOpacity),
                      border: Border.all(
                        color: context.c.primary,
                        width: Spacing.borderWidthThin,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
