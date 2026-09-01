import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/hatch_painter.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _hatchOpacity = 0.35;

class const ProfileAvatar({
  final double _size = 52,
  final VoidCallback? _onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: _onTap,
      circle: true,
      color: context.c.surfaceContainerHigh,
      child: SizedBox(
        width: _size,
        height: _size,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: HatchPainter(color: context.c.outline.withValues(alpha: _hatchOpacity)),
              size: Size(_size, _size),
            ),
            Center(
              child: Text(
                context.s.profileYouLabel,
                style: context.typography.monoCaption.copyWith(color: context.c.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
