import 'dart:math' as math;

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/quote_page.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/highlight_image.dart';
import 'package:shared/presentation/widgets/page_dots.dart';

const _minScale = 1.0;
const _maxScale = 5.0;
const _doubleTapScale = 2.5;
const _indicatorColor = Colors.white;

Future<void> showFullscreenImageViewer(
  BuildContext context, {
  required List<QuotePage> pages,
  int initialIndex = 0,
}) {
  return showDialog<void>(
    context: context,
    useSafeArea: false,
    barrierColor: context.c.scrim,
    builder: (dialogContext) => _FullscreenImageViewer(pages: pages, initialIndex: initialIndex),
  );
}

class const _FullscreenImageViewer({
  required final List<QuotePage> _pages,
  required final int _initialIndex,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = usePageController(initialPage: _initialIndex);
    final visiblePage = useState(_initialIndex);
    return Dialog.fullscreen(
      backgroundColor: context.c.scrim,
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: controller,
              itemCount: _pages.length,
              onPageChanged: (index) => visiblePage.value = index,
              itemBuilder: (context, index) => _ZoomablePage(page: _pages[index]),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.m),
              child: CircleIconButton(
                icon: Icons.close,
                tooltip: context.s.close,
                onPressed: Navigator.of(context).pop,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.l),
                child: Center(
                  child: PageDots(
                    count: _pages.length,
                    index: visiblePage.value,
                    color: _indicatorColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class const _ZoomablePage({
  required final QuotePage _page,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(TransformationController.new);
    useEffect(() => controller.dispose, [controller]);

    void toggleZoom(TapDownDetails details, double scale) {
      if (controller.value.getMaxScaleOnAxis() > _minScale) {
        controller.value = Matrix4.identity();
        return;
      }
      final position = details.localPosition;
      final offsetFactor = scale - 1;
      controller.value = Matrix4.identity()
        ..translateByDouble(-position.dx * offsetFactor, -position.dy * offsetFactor, 0, 1)
        ..scaleByDouble(scale, scale, scale, 1);
    }

    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        onDoubleTapDown: (details) =>
            toggleZoom(details, _zoomScale(constraints.biggest, _page.imageAspectRatio)),
        child: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, matrix, child) => InteractiveViewer(
            transformationController: controller,
            panEnabled: matrix.getMaxScaleOnAxis() > _minScale,
            minScale: _minScale,
            maxScale: _maxScale,
            child: child!,
          ),
          child: Center(
            child: HighlightImage(
              imagePath: _page.photoPath,
              aspectRatio: _page.imageAspectRatio,
              highlights: _page.highlights,
            ),
          ),
        ),
      ),
    );
  }
}

// * a page held back by the viewport sides opens up to the full width, so its print stays
// * readable, and anything already that wide zooms by a fixed step
double _zoomScale(Size viewport, double aspectRatio) {
  final width = math.min(viewport.width, viewport.height * aspectRatio);
  if (width <= 0 || width >= viewport.width) return _doubleTapScale;
  return (viewport.width / width).clamp(_minScale, _maxScale);
}
