import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/hatch_painter.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _hatchOpacity = 0.22;

class const ProfileAvatar({
  final double _size = 52,
  final VoidCallback? _onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.resolve(AccentColor.sand);
    return InkTapBox(
      onTap: _onTap,
      circle: true,
      color: swatch.fill,
      child: SizedBox(
        width: _size,
        height: _size,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: HatchPainter(color: swatch.onFillVariant.withValues(alpha: _hatchOpacity)),
              size: Size(_size, _size),
            ),
            Center(
              child: Text(
                context.s.profileYouLabel,
                style: context.typography.monoCaption.copyWith(color: swatch.onFillVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
