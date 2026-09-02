import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_capture/domain/capture_mode.dart';
import 'package:feature_capture/domain/capture_span.dart';
import 'package:feature_capture/presentation/capture/capture_bloc.dart';
import 'package:feature_capture/presentation/capture/capture_event.dart';
import 'package:feature_capture/presentation/capture/capture_state.dart';
import 'package:feature_capture/presentation/capture/page_detection_cubit.dart';
import 'package:feature_capture/presentation/capture/page_detection_state.dart';
import 'package:feature_capture/presentation/extensions/camera_image_extensions.dart';
import 'package:feature_capture/presentation/extensions/page_quad_extensions.dart';
import 'package:feature_capture/presentation/widgets/book_chooser_bar.dart';
import 'package:feature_capture/presentation/widgets/media_frame.dart';
import 'package:feature_capture/presentation/widgets/page_corner_dot.dart';
import 'package:feature_capture/presentation/widgets/page_quad_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/captured_shot.dart';
import 'package:shared/domain/entities/page_quad.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/crop_arguments.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/loading_indicator.dart';
import 'package:shared/presentation/widgets/segmented_toggle.dart';

const _resolutionPresets = [ResolutionPreset.max, ResolutionPreset.veryHigh];
const _portraitAspectRatio = 3 / 4;
const _shutterOuter = 88.0;
const _shutterInner = 60.0;
const _controlIcon = 56.0;
const _dotDuration = Duration(milliseconds: 120);
const _shotWidth = 44.0;
const _shotHeight = 60.0;
const _removeBadge = 18.0;
const _removeIcon = 12.0;
const _shotCacheWidth = 132;
const _sideColumnWidth = 300.0;

typedef _ContinueCallback = Future<void> Function(String bookId, List<CapturedShot> shots);

class const CaptureScreen({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useState<CameraController?>(null);
    final hasError = useState(false);
    final torchOn = useState(false);
    final detectionCubit = context.read<PageDetectionCubit>();
    final captureBloc = context.read<CaptureBloc>();

    Future<void> initialize() async {
      if (controller.value != null) return;
      try {
        final cameras = await availableCameras();
        if (cameras.isEmpty) {
          hasError.value = true;
          return;
        }
        final description = cameras.first;
        final created = await _openCamera(description);
        if (created == null) {
          hasError.value = true;
          return;
        }
        try {
          await created.startImageStream(
            (image) => detectionCubit.frameReceived(
              image.toCameraFrame(description.sensorOrientation),
            ),
          );
        } on Object {
          // * without an image stream the preview still works, only live detection is off
        }
        controller.value = created;
      } on Object {
        hasError.value = true;
      }
    }

    Future<void> shutdown() async {
      final camera = controller.value;
      controller.value = null;
      torchOn.value = false;
      if (camera == null) return;
      try {
        if (camera.value.isStreamingImages) await camera.stopImageStream();
        await camera.setFlashMode(FlashMode.off);
      } on Object {
        // camera may already be closing
      }
      await camera.dispose();
    }

    Future<void> toggleTorch() async {
      final camera = controller.value;
      if (camera == null) return;
      final next = !torchOn.value;
      try {
        await camera.setFlashMode(next ? FlashMode.torch : FlashMode.off);
        torchOn.value = next;
      } on Object {
        if (context.mounted) context.showToast(context.s.errorUnexpected);
      }
    }

    CaptureSpan currentSpan() => switch (captureBloc.state) {
      CaptureReady(:final span) || CaptureEmpty(:final span) => span,
      _ => CaptureSpan.onePage,
    };

    Future<void> collect(
      String bookId,
      String imagePath,
      CaptureMode mode,
      CaptureSpan span,
    ) async {
      PageQuad? quad;
      if (mode == CaptureMode.manual) {
        quad = await context.pushCrop(CropArguments(imagePath: imagePath));
        if (quad == null || !context.mounted) return;
      }
      final shot = CapturedShot(imagePath: imagePath, pageQuad: quad);
      if (span == CaptureSpan.spread) {
        captureBloc.add(CaptureShotTaken(shot));
        return;
      }
      await context.pushMarking(MarkingArguments(shots: [shot], bookId: bookId));
    }

    Future<void> capture(String bookId) async {
      final camera = controller.value;
      if (camera == null) return;
      try {
        if (camera.value.isStreamingImages) await camera.stopImageStream();
        final file = await camera.takePicture();
        final mode = detectionCubit.state.mode;
        await shutdown();
        if (!context.mounted) return;
        await collect(bookId, file.path, mode, currentSpan());
        if (context.mounted) await initialize();
      } on Object {
        if (context.mounted) context.showToast(context.s.errorUnexpected);
      }
    }

    Future<void> pickFromGallery(String bookId) async {
      try {
        final files = await ImagePicker().pickMultiImage();
        if (files.isEmpty) return;
        // * several picked images are the pages of one quote, so they become a spread
        final span = files.length > 1 ? CaptureSpan.spread : currentSpan();
        if (span != currentSpan()) captureBloc.add(CaptureSpanSelected(span));
        await shutdown();
        for (final file in files) {
          if (!context.mounted) return;
          // * a gallery photo was never framed by live detection, so its page is marked by hand
          await collect(bookId, file.path, CaptureMode.manual, span);
        }
        if (context.mounted) await initialize();
      } on Object {
        if (context.mounted) context.showToast(context.s.errorUnexpected);
      }
    }

    Future<void> continueWithSpread(String bookId, List<CapturedShot> shots) async {
      await shutdown();
      if (!context.mounted) return;
      await context.pushMarking(MarkingArguments(shots: shots, bookId: bookId));
      if (context.mounted) await initialize();
    }

    useEffect(() {
      unawaited(initialize());
      return () {
        final camera = controller.value;
        controller.value = null;
        unawaited(camera?.setFlashMode(FlashMode.off).catchError((Object _) {}));
        unawaited(camera?.dispose() ?? Future<void>.value());
      };
    }, const []);

    final preview = _Preview(
      camera: hasError.value ? null : controller.value,
      unavailable: hasError.value,
    );
    final controls = _Controls(
      camera: controller.value,
      torchOn: torchOn.value,
      onToggleTorch: toggleTorch,
      onCapture: capture,
      onGallery: pickFromGallery,
    );
    // * landscape puts the viewfinder next to its controls instead of squeezing both vertically
    if (context.layout.isLandscape) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.m),
            child: Row(
              children: [
                Expanded(child: preview),
                const SizedBox(width: Spacing.m),
                SizedBox(
                  width: _sideColumnWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const _SpanToggle(),
                      const _BookBar(),
                      _CaptureTray(onContinue: continueWithSpread),
                      controls,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
          child: Column(
            children: [
              const SizedBox(height: Spacing.s),
              const _SpanToggle(),
              const SizedBox(height: Spacing.m),
              Expanded(child: preview),
              const SizedBox(height: Spacing.m),
              const _BookBar(),
              const SizedBox(height: Spacing.s),
              _CaptureTray(onContinue: continueWithSpread),
              const SizedBox(height: Spacing.m),
              controls,
              const SizedBox(height: Spacing.s),
            ],
          ),
        ),
      ),
    );
  }
}

class const _SpanToggle() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaptureBloc, CaptureState>(
      builder: (context, state) {
        final span = switch (state) {
          CaptureReady(:final span) || CaptureEmpty(:final span) => span,
          _ => CaptureSpan.onePage,
        };
        return Center(
          child: SegmentedToggle(
            isExpanded: false,
            labels: [
              for (final value in CaptureSpan.values)
                switch (value) {
                  CaptureSpan.onePage => context.s.captureModeOnePage,
                  CaptureSpan.spread => context.s.captureModeSpread,
                },
            ],
            selectedIndex: CaptureSpan.values.indexOf(span),
            onChanged: (index) => context.read<CaptureBloc>().add(
              CaptureSpanSelected(CaptureSpan.values[index]),
            ),
          ),
        );
      },
    );
  }
}

class const _CaptureTray({
  required final _ContinueCallback _onContinue,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaptureBloc, CaptureState>(
      builder: (context, state) => switch (state) {
        CaptureReady(:final span, :final shots, :final selectedBookId)
            when span == CaptureSpan.spread && shots.isNotEmpty =>
          _ShotActions(
            count: shots.length,
            onContinue: () => _onContinue(selectedBookId, shots),
          ),
        CaptureReady(span: CaptureSpan.spread) ||
        CaptureEmpty(span: CaptureSpan.spread) => _Hint(text: context.s.captureSpreadHint),
        _ => _Hint(text: context.s.captureSteadyHint),
      },
    );
  }
}

class const _Hint({
  required final String _text,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      textAlign: TextAlign.center,
      style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
    );
  }
}

class const _ShotActions({
  required final int _count,
  required final VoidCallback _onContinue,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.s.captureSpreadShotsHint,
          textAlign: TextAlign.center,
          style: context.typography.caption.copyWith(color: context.c.onSurfaceVariant),
        ),
        const SizedBox(height: Spacing.xs),
        FilledButton(
          onPressed: _onContinue,
          child: Text(context.s.captureSpreadContinueButton(_count)),
        ),
      ],
    );
  }
}

class const _ShotThumbnail({
  required final CapturedShot _shot,
  required final int _index,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.s.captureSpreadRemoveLabel,
      child: InkTapBox(
        onTap: () => context.read<CaptureBloc>().add(CaptureShotDiscarded(_index)),
        radius: Spacing.radiusM,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Spacing.radiusM),
              child: Image.file(
                File(_shot.imagePath),
                width: _shotWidth,
                height: _shotHeight,
                cacheWidth: _shotCacheWidth,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: Spacing.xxxs,
              right: Spacing.xxxs,
              child: Container(
                width: _removeBadge,
                height: _removeBadge,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.c.tertiary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: _removeIcon,
                  color: context.c.onTertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class const _Preview({
  required final CameraController? _camera,
  required final bool _unavailable,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final camera = _camera;
    return MediaFrame(
      aspectRatio: camera == null
          ? _fallbackAspectRatio(context)
          : _previewAspectRatio(context, camera),
      background: context.c.surfaceContainerHigh,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Spacing.radiusXl),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (_unavailable)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(Spacing.l),
                  child: Text(
                    context.s.captureCameraUnavailable,
                    textAlign: TextAlign.center,
                    style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
                  ),
                ),
              )
            else if (camera != null)
              CameraPreview(camera)
            else
              const LoadingIndicator(),
            const _DetectionOverlay(),
            const _PreviewOverlay(),
          ],
        ),
      ),
    );
  }
}

class const _DetectionOverlay() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageDetectionCubit, PageDetectionState>(
      builder: (context, state) => LayoutBuilder(
        builder: (context, constraints) {
          if (state.mode != CaptureMode.auto) return const SizedBox.shrink();
          final size = constraints.biggest;
          // * the cubit reports the upright portrait ratio of the frame
          final aspectRatio = switch (state.frameAspectRatio) {
            final double ratio when context.layout.isLandscape => 1 / ratio,
            final double ratio => ratio,
            _ => null,
          };
          final frame = _frameRect(size, aspectRatio);
          final quad = state.quad;
          return Stack(
            children: [
              if (quad != null && frame != null)
                Positioned.fromRect(
                  rect: frame,
                  child: PageQuadOverlay(quad: quad, lineColor: context.c.primary),
                ),
              for (final corner in PageCorner.values)
                _OverlayDot(
                  key: ValueKey(corner),
                  corner: corner,
                  center: _cornerOffset(corner, size, frame, quad),
                ),
            ],
          );
        },
      ),
    );
  }
}

class const _OverlayDot({
  required final PageCorner _corner,
  required final Offset _center,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: _dotDuration,
      curve: Curves.easeOut,
      left: _center.dx - PageCornerDot.size / 2,
      top: _center.dy - PageCornerDot.size / 2,
      child: PageCornerDot(corner: _corner),
    );
  }
}

class const _PreviewOverlay() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.all(Spacing.m),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_CaptureModeToggle(), _ShotStrip()],
        ),
      ),
    );
  }
}

class const _CaptureModeToggle() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageDetectionCubit, PageDetectionState>(
      buildWhen: (previous, current) => previous.mode != current.mode,
      builder: (context, state) => SegmentedToggle(
        labels: [context.s.captureModeAuto, context.s.captureModeManual],
        selectedIndex: switch (state.mode) {
          CaptureMode.auto => 0,
          CaptureMode.manual => 1,
        },
        onChanged: (index) => context.read<PageDetectionCubit>().selectMode(
          index == 0 ? CaptureMode.auto : CaptureMode.manual,
        ),
        trackColor: context.c.surfaceContainerHigh,
        activeColor: context.c.inverseSurface,
        activeTextColor: context.c.onInverseSurface,
      ),
    );
  }
}

class const _ShotStrip() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaptureBloc, CaptureState>(
      builder: (context, state) {
        if (state case CaptureReady(:final span, :final shots)
            when span == CaptureSpan.spread && shots.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: Spacing.s),
            child: SizedBox(
              height: _shotHeight,
              child: ReorderableListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: shots.length,
                onReorderItem: (oldIndex, newIndex) => context.read<CaptureBloc>().add(
                  CaptureShotMoved(oldIndex, newIndex),
                ),
                // * the default proxy paints an opaque card, which would hide the camera
                proxyDecorator: (child, index, animation) =>
                    Material(color: Colors.transparent, child: child),
                itemBuilder: (context, index) => Padding(
                  key: ValueKey(shots[index].imagePath),
                  padding: EdgeInsets.only(
                    right: index == shots.length - 1 ? 0 : Spacing.xs,
                  ),
                  child: _ShotThumbnail(shot: shots[index], index: index),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// * the sensor's own resolution keeps the page in its native ratio and gives the recogniser
// * the pixels it crops from, but not every device offers it, so a smaller preset takes over
Future<CameraController?> _openCamera(CameraDescription description) async {
  for (final preset in _resolutionPresets) {
    final camera = CameraController(
      description,
      preset,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    try {
      await camera.initialize();
      return camera;
    } on Object {
      try {
        await camera.dispose();
      } on Object {
        // camera never opened
      }
    }
  }
  return null;
}

// * the camera reports no size before it opens, so the frame waits in the usual page ratio
double _fallbackAspectRatio(BuildContext context) {
  return context.layout.isLandscape ? 1 / _portraitAspectRatio : _portraitAspectRatio;
}

// * previewSize is reported in sensor orientation, so the sides are ordered by the device instead
double _previewAspectRatio(BuildContext context, CameraController camera) {
  final size = camera.value.previewSize;
  if (size == null) return 1;
  return context.layout.isLandscape
      ? size.longestSide / size.shortestSide
      : size.shortestSide / size.longestSide;
}

// * the preview is contained in its box, so the detection frame is letterboxed the same way
Rect? _frameRect(Size size, double? aspectRatio) {
  if (aspectRatio == null) return null;
  if (aspectRatio > size.width / size.height) {
    final height = size.width / aspectRatio;
    return Rect.fromLTWH(0, (size.height - height) / 2, size.width, height);
  }
  final width = size.height * aspectRatio;
  return Rect.fromLTWH((size.width - width) / 2, 0, width, size.height);
}

Offset _cornerOffset(PageCorner corner, Size size, Rect? frame, PageQuad? quad) {
  if (quad == null || frame == null) return _defaultCornerOffset(corner, size);
  final point = quad.pointAt(corner);
  return Offset(frame.left + point.x * frame.width, frame.top + point.y * frame.height);
}

Offset _defaultCornerOffset(PageCorner corner, Size size) {
  const inset = Spacing.m + PageCornerDot.size / 2;
  return switch (corner) {
    PageCorner.topLeft => const Offset(inset, inset),
    PageCorner.topRight => Offset(size.width - inset, inset),
    PageCorner.bottomRight => Offset(size.width - inset, size.height - inset),
    PageCorner.bottomLeft => Offset(inset, size.height - inset),
  };
}

class const _BookBar() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaptureBloc, CaptureState>(
      builder: (context, state) => switch (state) {
        CaptureReady(:final books, :final selectedBookId) => _SelectedBook(
          book: books.firstWhere((book) => book.id == selectedBookId),
        ),
        CaptureFailure() || CaptureEmpty() => const _NoBook(),
        CaptureLoading() => const SizedBox(height: 56),
      },
    );
  }
}

class const _SelectedBook({
  required final Book _book,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BookChooserBar(
      title: _book.title,
      coverImage: _book.coverImage,
      label: context.s.captureMarkingInto,
      onSwitch: () => _addBook(context),
    );
  }
}

class const _NoBook() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.s),
      decoration: BoxDecoration(
        color: context.c.inverseSurface,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.s.captureNoBooksMessage,
              style: context.t.bodyMedium?.copyWith(color: context.c.onInverseSurface),
            ),
          ),
          const SizedBox(width: Spacing.s),
          InkTapBox(
            onTap: () => _addBook(context),
            color: context.c.primary,
            radius: Spacing.radiusFull,
            padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
            child: Text(
              context.s.captureAddBookButton,
              style: context.t.labelMedium?.copyWith(
                color: context.c.onPrimary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class const _Controls({
  required final CameraController? _camera,
  required final bool _torchOn,
  required final Future<void> Function() _onToggleTorch,
  required final Future<void> Function(String) _onCapture,
  required final Future<void> Function(String) _onGallery,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaptureBloc, CaptureState>(
      builder: (context, state) {
        final selectedBookId = state is CaptureReady ? state.selectedBookId : null;
        final canCapture = _camera != null && selectedBookId != null;
        final children = [
          _GalleryButton(
            onTap: selectedBookId == null ? null : () => _onGallery(selectedBookId),
          ),
          _ShutterButton(
            enabled: canCapture,
            onTap: canCapture ? () => _onCapture(selectedBookId) : null,
          ),
          _TorchButton(enabled: _camera != null, on: _torchOn, onToggle: _onToggleTorch),
        ];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        );
      },
    );
  }
}

class const _GalleryButton({
  required final VoidCallback? _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _controlIcon + 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _onTap,
            tooltip: context.s.captureGalleryLabel,
            icon: const Icon(Icons.photo_library_outlined),
            iconSize: Spacing.iconM,
            style: _squareStyle(
              background: context.c.inverseSurface,
              foreground: context.c.onInverseSurface,
            ),
          ),
          const SizedBox(height: Spacing.xxs),
          Text(
            context.s.captureGalleryLabel,
            textAlign: TextAlign.center,
            style: context.typography.caption.copyWith(color: context.c.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

ButtonStyle _squareStyle({required Color background, required Color foreground}) {
  return IconButton.styleFrom(
    backgroundColor: background,
    foregroundColor: foreground,
    fixedSize: const Size.square(_controlIcon),
    minimumSize: const Size.square(_controlIcon),
    padding: EdgeInsets.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.radiusM)),
  );
}

class const _ShutterButton({
  required final bool _enabled,
  required final VoidCallback? _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _enabled ? 1 : 0.5,
      child: InkTapBox(
        onTap: _onTap,
        circle: true,
        color: context.c.primary,
        child: SizedBox(
          width: _shutterOuter,
          height: _shutterOuter,
          child: Center(
            child: Container(
              width: _shutterInner,
              height: _shutterInner,
              decoration: BoxDecoration(color: context.c.tertiary, shape: BoxShape.circle),
            ),
          ),
        ),
      ),
    );
  }
}

class const _TorchButton({
  required final bool _enabled,
  required final bool _on,
  required final Future<void> Function() _onToggle,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _controlIcon + 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _enabled ? _onToggle : null,
            tooltip: _on ? context.s.captureLightOn : context.s.captureLightOff,
            icon: Icon(_on ? Icons.flash_on : Icons.flash_off),
            iconSize: Spacing.iconM,
            style: _squareStyle(
              background: _on ? context.c.primary : context.c.surfaceContainerHigh,
              foreground: _on ? context.c.onPrimary : context.c.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: Spacing.xxs),
          Text(
            _on ? context.s.captureLightOn : context.s.captureLightOff,
            textAlign: TextAlign.center,
            style: context.typography.caption.copyWith(
              color: _on ? context.c.primary : context.c.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _addBook(BuildContext context) async {
  final captureBloc = context.read<CaptureBloc>();
  final bookId = await context.pushAddBook();
  if (bookId != null) captureBloc.add(CaptureBookSelected(bookId));
}
