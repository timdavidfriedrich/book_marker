import 'dart:io';

import 'package:core/theme/corner_radii.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/quote_page.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/fullscreen_image_viewer.dart';

const _thumbnailWidth = 44.0;
const _thumbnailCacheWidth = 132;
const _badgeSize = 20.0;
const _badgeOverhang = 4.0;
const _badgeNotchGap = 2.0;

class const SourceThumbnails({
  required final List<QuotePage> _pages,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final direction = Directionality.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (index, page) in _pages.indexed) ...[
            if (index > 0) const SizedBox(width: Spacing.xxxs),
            _SourceThumbnail(
              page: page,
              number: index + 1,
              borderRadius: CornerRadii.grouped(
                outer: Spacing.radiusL,
                isFirst: index == 0,
                isLast: index == _pages.length - 1,
                axis: Axis.horizontal,
              ).resolve(direction),
              onTap: () => showFullscreenImageViewer(
                context,
                pages: _pages,
                initialIndex: index,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class const _SourceThumbnail({
  required final QuotePage _page,
  required final int _number,
  required final BorderRadius _borderRadius,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shape = _BadgeNotchBorder(borderRadius: _borderRadius);
    return SizedBox(
      width: _thumbnailWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // * every child is positioned so the strip reports no intrinsic height of its own
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              shape: shape,
              clipBehavior: Clip.antiAlias,
              // * the image is ink, not a child, so the ripple paints above it
              child: Ink.image(
                image: ResizeImage(
                  FileImage(File(_page.photoPath)),
                  width: _thumbnailCacheWidth,
                ),
                fit: BoxFit.cover,
                child: InkWell(onTap: _onTap, customBorder: shape),
              ),
            ),
          ),
          Positioned(
            left: -_badgeOverhang,
            bottom: -_badgeOverhang,
            child: _PageBadge(number: _number),
          ),
        ],
      ),
    );
  }
}

class const _PageBadge({
  required final int _number,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _badgeSize,
      height: _badgeSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        shape: BoxShape.circle,
      ),
      child: Text(
        "$_number",
        style: context.typography.badge.copyWith(color: context.c.onSurfaceVariant),
      ),
    );
  }
}

class const _BadgeNotchBorder({
  required final BorderRadius _borderRadius,
}) extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => getOuterPath(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final body = Path()..addRRect(_borderRadius.toRRect(rect));
    final notch = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(
            rect.left + _badgeSize / 2 - _badgeOverhang,
            rect.bottom + _badgeOverhang - _badgeSize / 2,
          ),
          radius: _badgeSize / 2 + _badgeNotchGap,
        ),
      );
    return Path.combine(PathOperation.difference, body, notch);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => _BadgeNotchBorder(borderRadius: _borderRadius * t);

  @override
  bool operator ==(Object other) =>
      other is _BadgeNotchBorder && other._borderRadius == _borderRadius;

  @override
  int get hashCode => _borderRadius.hashCode;
}
