import 'dart:io';

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/hatch_painter.dart';

const _remoteScheme = "http";
const _hatchOpacity = 0.35;
const _monogramSizeRatio = 0.44;

class const BookCover({
  required final String _title,
  final String? _image,
  final double _width = 48,
  final double _height = 64,
  final double _radius = Spacing.radiusM,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_radius),
      child: SizedBox(
        width: _width,
        height: _height,
        child: switch (_image) {
          null => _placeholder(context),
          final image when image.startsWith(_remoteScheme) => Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _placeholder(context),
          ),
          final image => Image.file(
            File(image),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _placeholder(context),
          ),
        },
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    final trimmed = _title.trim();
    return DecoratedBox(
      decoration: BoxDecoration(color: context.c.surfaceContainerHighest),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: HatchPainter(color: context.c.outline.withValues(alpha: _hatchOpacity)),
            size: Size(_width, _height),
          ),
          Center(
            child: Text(
              trimmed.isEmpty ? "" : trimmed.substring(0, 1).toUpperCase(),
              style: context.t.headlineSmall?.copyWith(
                color: context.c.onSurfaceVariant,
                fontSize: _width * _monogramSizeRatio,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
