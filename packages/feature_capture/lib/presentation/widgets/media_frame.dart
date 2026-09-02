import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';

// * the frame takes the shape of what it shows, so no surface is left framing empty space
class const MediaFrame({
  required final double _aspectRatio,
  required final Widget _child,
  final Color? _background,
  final double _radius = Spacing.radiusXl,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final frame = AspectRatio(aspectRatio: _aspectRatio, child: _child);
    if (_background case final Color background) {
      return Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(_radius),
          ),
          child: frame,
        ),
      );
    }
    return Center(child: frame);
  }
}
