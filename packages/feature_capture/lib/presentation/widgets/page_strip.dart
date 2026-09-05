import 'dart:io';

import 'package:core/theme/corner_radii.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/crop_page.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _thumbnailWidth = 48.0;
const _thumbnailHeight = 64.0;
const _thumbnailCacheWidth = 144;
const _unselectedOpacity = 0.5;
const _indexBadgeSize = 18.0;
const _warningIconSize = 12.0;
const _badgeInset = 2.0;
const _dragScale = 1.15;
const _dragShadowBlur = 16.0;
const _dragShadowOffset = 6.0;
const _dragShadowOpacity = 0.45;

BorderRadiusGeometry _pageRadius(int index) => CornerRadii.grouped(
  outer: Spacing.radiusM,
  isFirst: index == 0,
  isLast: false,
  axis: Axis.horizontal,
);

class const PageStrip({
  required final List<CropPage> _pages,
  required final int _selectedIndex,
  required final ValueChanged<int> _onSelect,
  required final void Function(int fromIndex, int toIndex) _onMove,
  required final VoidCallback? _onAdd,
  required final VoidCallback? _onRotate,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _thumbnailHeight,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: ReorderableListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    buildDefaultDragHandles: false,
                    itemCount: _pages.length,
                    onReorderItem: _onMove,
                    proxyDecorator: (child, index, animation) => AnimatedBuilder(
                      animation: animation,
                      builder: (context, _) => _FloatingPage(
                        lift: animation.value,
                        borderRadius: _pageRadius(index),
                        child: child,
                      ),
                    ),
                    itemBuilder: (context, index) => Padding(
                      key: ValueKey(_pages[index].imagePath),
                      padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxs),
                      // * picking a page up on a long press leaves plain drags to the scroll view
                      child: ReorderableDelayedDragStartListener(
                        index: index,
                        child: _PageThumbnail(
                          page: _pages[index],
                          index: index,
                          selected: index == _selectedIndex,
                          borderRadius: _pageRadius(index),
                          onSelect: () => _onSelect(index),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Spacing.xxxs),
                _AddButton(onTap: _onAdd, isOnly: _pages.isEmpty),
              ],
            ),
          ),
          const SizedBox(width: Spacing.s),
          CircleIconButton(
            icon: Icons.rotate_90_degrees_cw,
            tooltip: context.s.cropRotateLabel,
            onPressed: _onRotate,
          ),
        ],
      ),
    );
  }
}

class const _FloatingPage({
  required final double _lift,
  required final BorderRadiusGeometry _borderRadius,
  required final Widget _child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lift = Curves.easeOut.transform(_lift);
    return Transform.scale(
      scale: 1 + (_dragScale - 1) * lift,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          boxShadow: [
            BoxShadow(
              color: context.c.scrim.withValues(alpha: _dragShadowOpacity * lift),
              blurRadius: _dragShadowBlur * lift,
              offset: Offset(0, _dragShadowOffset * lift),
            ),
          ],
        ),
        child: _child,
      ),
    );
  }
}

class const _PageThumbnail({
  required final CropPage _page,
  required final int _index,
  required final bool _selected,
  required final BorderRadiusGeometry _borderRadius,
  required final VoidCallback _onSelect,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.status.uncertain;
    return Badge(
      isLabelVisible: _page.isUnsure,
      backgroundColor: swatch.solid,
      label: Icon(Icons.priority_high, size: _warningIconSize, color: swatch.onSolid),
      alignment: AlignmentDirectional.topEnd,
      // * the strip clips at the thumbnail bounds, so the badge stays inside the corner
      offset: const Offset(-_badgeInset, _badgeInset),
      child: Opacity(
        opacity: _selected ? 1 : _unselectedOpacity,
        child: Semantics(
          label: context.s.cropPageLabel(_index + 1),
          selected: _selected,
          child: InkTapBox(
            onTap: _onSelect,
            shape: RoundedRectangleBorder(borderRadius: _borderRadius),
            child: Stack(
              children: [
                SizedBox(
                  width: _thumbnailWidth,
                  height: _thumbnailHeight,
                  child: RotatedBox(
                    quarterTurns: _page.quarterTurns,
                    child: Image(
                      image: ResizeImage(
                        FileImage(File(_page.imagePath)),
                        width: _thumbnailCacheWidth,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (_selected)
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: _borderRadius,
                        border: Border.all(
                          color: context.c.primary,
                          width: Spacing.borderWidthMedium,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: Spacing.xxxs,
                  bottom: Spacing.xxxs,
                  child: Container(
                    width: _indexBadgeSize,
                    height: _indexBadgeSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.c.surfaceContainerHigh,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${_index + 1}",
                      style: context.typography.badge.copyWith(color: context.c.onSurface),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class const _AddButton({
  required final VoidCallback? _onTap,
  required final bool _isOnly,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: context.s.cropAddPageLabel,
      child: InkTapBox(
        onTap: _onTap,
        color: context.c.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          borderRadius: CornerRadii.grouped(
            outer: Spacing.radiusM,
            isFirst: _isOnly,
            isLast: true,
            axis: Axis.horizontal,
          ),
        ),
        child: SizedBox(
          width: _thumbnailWidth,
          height: _thumbnailHeight,
          child: Icon(Icons.add, size: Spacing.iconM, color: context.c.onSurface),
        ),
      ),
    );
  }
}
