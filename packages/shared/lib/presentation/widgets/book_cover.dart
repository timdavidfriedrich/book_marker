import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/hatch_painter.dart';

const _hatchOpacity = 0.22;

class const BookCover({
  required final AccentColor _accent,
  final String? _url,
  final double _width = 48,
  final double _height = 64,
  final double _radius = Spacing.radiusM,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.resolve(_accent);
    final url = _url;
    return ClipRRect(
      borderRadius: BorderRadius.circular(_radius),
      child: SizedBox(
        width: _width,
        height: _height,
        child: url == null
            ? _placeholder(swatch)
            : Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _placeholder(swatch),
              ),
      ),
    );
  }

  Widget _placeholder(AccentSwatch swatch) {
    return DecoratedBox(
      decoration: BoxDecoration(color: swatch.fill),
      child: CustomPaint(
        painter: HatchPainter(color: swatch.onFillVariant.withValues(alpha: _hatchOpacity)),
        size: Size(_width, _height),
      ),
    );
  }
}
