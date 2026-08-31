import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';

const _collapsedHeight = 60.0;
const _crossFadeThreshold = 0.5;

class const CollapsingHeader({
  required final double _expandedHeight,
  required final Color _backgroundColor,
  required final Widget _expanded,
  required final Widget _collapsed,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: _collapsedHeight,
      expandedHeight: _expandedHeight,
      flexibleSpace: DecoratedBox(
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(Spacing.radiusXxl)),
        ),
        child: Builder(
          builder: (context) {
            final expandedFraction = _expandedFraction(context);
            return Stack(
              fit: StackFit.expand,
              children: [
                IgnorePointer(
                  ignoring: expandedFraction < _crossFadeThreshold,
                  child: Opacity(opacity: expandedFraction, child: _expanded),
                ),
                IgnorePointer(
                  ignoring: expandedFraction >= _crossFadeThreshold,
                  child: Opacity(
                    opacity: 1 - expandedFraction,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(height: _collapsedHeight, child: _collapsed),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  double _expandedFraction(BuildContext context) {
    final settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    if (settings == null) return 1;
    final range = settings.maxExtent - settings.minExtent;
    if (range <= 0) return 1;
    return ((settings.currentExtent - settings.minExtent) / range).clamp(0.0, 1.0);
  }
}
