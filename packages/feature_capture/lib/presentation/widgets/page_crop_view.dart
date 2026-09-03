import 'dart:io';

import 'package:core/theme/spacing.dart';
import 'package:feature_capture/domain/crop_page.dart';
import 'package:feature_capture/presentation/extensions/page_quad_extensions.dart';
import 'package:feature_capture/presentation/widgets/page_corner_dot.dart';
import 'package:feature_capture/presentation/widgets/page_quad_overlay.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/page_quad.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/loading_indicator.dart';

typedef _CornerMoveCallback = void Function(PageCorner corner, PagePoint position);

const _decodeWidth = 1600;
const _scrimOpacity = 0.55;
const _touchTarget = 48.0;
const _magnifierSize = 144.0;
const _magnifierHalfSize = _magnifierSize / 2;
const _magnifierInset = Spacing.m;
const _magnifierCorner = _magnifierInset;
const _magnifierEdge = _magnifierInset + _magnifierHalfSize;
const _magnifierScale = 1.5;

class const PageCropView({
  required final CropPage _page,
  required final _CornerMoveCallback _onCornerMoved,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final image = useMemoized(
      () => ResizeImage(FileImage(File(_page.imagePath)), width: _decodeWidth),
      [_page.imagePath],
    );
    final decoded = useFuture(useMemoized(() => precacheImage(image, context), [image]));
    final draggedCorner = useState<PageCorner?>(null);
    final draggedPoint = useState<PagePoint?>(null);

    void startDrag(PageCorner corner) {
      draggedCorner.value = corner;
      draggedPoint.value = _page.quad.pointAt(corner);
    }

    // * every move builds on the point the finger left behind, never on the last painted frame
    void moveDrag(PageCorner corner, Offset delta, Size size) {
      final current = draggedPoint.value ?? _page.quad.pointAt(corner);
      final moved = PagePoint(
        x: (current.x + delta.dx / size.width).clamp(0.0, 1.0),
        y: (current.y + delta.dy / size.height).clamp(0.0, 1.0),
      );
      draggedPoint.value = moved;
      _onCornerMoved(corner, moved);
    }

    void endDrag() {
      draggedCorner.value = null;
      draggedPoint.value = null;
    }

    if (decoded.connectionState != ConnectionState.done) {
      return AspectRatio(
        aspectRatio: _page.portraitAspectRatio,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.c.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(Spacing.radiusXl),
          ),
          child: const LoadingIndicator(),
        ),
      );
    }
    final quad = switch ((draggedCorner.value, draggedPoint.value)) {
      (final PageCorner corner, final PagePoint point) => _page.quad.withPointAt(corner, point),
      _ => _page.quad,
    };
    return AspectRatio(
      aspectRatio: _page.portraitAspectRatio,
      child: Center(
        child: AspectRatio(
          aspectRatio: _page.displayAspectRatio,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.biggest;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Spacing.radiusXl),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          RotatedBox(
                            quarterTurns: _page.quarterTurns,
                            child: Image(image: image, fit: BoxFit.fill),
                          ),
                          PageQuadOverlay(
                            quad: quad,
                            lineColor: _page.isUnsure
                                ? context.status.uncertain.solid
                                : context.c.primary,
                            scrimColor: context.c.scrim.withValues(alpha: _scrimOpacity),
                            dashed: _page.isUnsure,
                          ),
                        ],
                      ),
                    ),
                  ),
                  for (final corner in PageCorner.values)
                    _DraggableDot(
                      key: ValueKey(corner),
                      point: quad.pointAt(corner),
                      size: size,
                      onStart: () => startDrag(corner),
                      onUpdate: (delta) => moveDrag(corner, delta, size),
                      onEnd: endDrag,
                    ),
                  if (draggedCorner.value case final PageCorner corner)
                    _CornerMagnifier(point: quad.pointAt(corner), size: size),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class const _DraggableDot({
  required final PagePoint _point,
  required final Size _size,
  required final VoidCallback _onStart,
  required final ValueChanged<Offset> _onUpdate,
  required final VoidCallback _onEnd,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _point.x * _size.width - _touchTarget / 2,
      top: _point.y * _size.height - _touchTarget / 2,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        // * counting from the touch down keeps the corner under the finger from the first pixel
        dragStartBehavior: DragStartBehavior.down,
        onPanStart: (details) => _onStart(),
        onPanUpdate: (details) => _onUpdate(details.delta),
        onPanEnd: (details) => _onEnd(),
        onPanCancel: _onEnd,
        child: const SizedBox(
          width: _touchTarget,
          height: _touchTarget,
          child: Center(child: PageCornerDot()),
        ),
      ),
    );
  }
}

class const _CornerMagnifier({
  required final PagePoint _point,
  required final Size _size,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final focus = Offset(_point.x * _size.width, _point.y * _size.height);
    final center = _lensCenter(focus, _size);
    return Positioned(
      left: center.dx - _magnifierHalfSize,
      top: center.dy - _magnifierHalfSize,
      child: RawMagnifier(
        size: const Size.square(_magnifierSize),
        magnificationScale: _magnifierScale,
        focalPointOffset: focus - center,
        decoration: MagnifierDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_magnifierCorner),
            side: BorderSide(color: context.c.surfaceDim, width: Spacing.borderWidthMedium),
          ),
        ),
      ),
    );
  }
}

// * the lens parks in whichever top corner is further away, so the finger never covers it
Offset _lensCenter(Offset focus, Size size) {
  if (size.width < _magnifierSize + _magnifierInset * 2) {
    return Offset(size.width / 2, _magnifierEdge);
  }
  const left = Offset(_magnifierEdge, _magnifierEdge);
  final right = Offset(size.width - _magnifierEdge, _magnifierEdge);
  return (focus - left).distance >= (focus - right).distance ? left : right;
}
