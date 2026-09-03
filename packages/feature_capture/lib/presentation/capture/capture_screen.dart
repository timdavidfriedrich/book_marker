import 'dart:async';

import 'package:camera/camera.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_capture/presentation/capture/page_detection_cubit.dart';
import 'package:feature_capture/presentation/capture/page_detection_state.dart';
import 'package:feature_capture/presentation/extensions/camera_image_extensions.dart';
import 'package:feature_capture/presentation/widgets/media_frame.dart';
import 'package:feature_capture/presentation/widgets/page_quad_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/loading_indicator.dart';

const _resolutionPresets = [ResolutionPreset.max, ResolutionPreset.veryHigh];
const _portraitAspectRatio = 3 / 4;
const _shutterOuter = 88.0;
const _shutterInner = 60.0;
const _controlIcon = 56.0;
const _sideColumnWidth = 300.0;
const _disabledOpacity = 0.5;

class const CaptureScreen({
  required final bool _addsPage,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useState<CameraController?>(null);
    final hasError = useState(false);
    final torchOn = useState(false);
    final detectionCubit = context.read<PageDetectionCubit>();

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
        await created
            .startImageStream(
              (image) => detectionCubit.frameReceived(
                image.toCameraFrame(description.sensorOrientation),
              ),
            )
            .catchError((Object _) {});
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
      if (camera.value.isStreamingImages) {
        await camera.stopImageStream().catchError((Object _) {});
      }
      await camera.setFlashMode(FlashMode.off).catchError((Object _) {});
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

    Future<void> capture() async {
      final camera = controller.value;
      if (camera == null) return;
      try {
        if (camera.value.isStreamingImages) await camera.stopImageStream();
        final file = await camera.takePicture();
        await shutdown();
        if (!context.mounted) return;
        context.closeScreenWithResult([file.path]);
      } on Object {
        if (context.mounted) context.showToast(context.s.errorUnexpected);
      }
    }

    Future<void> pickFromGallery() async {
      try {
        final files = await ImagePicker().pickMultiImage();
        if (files.isEmpty) return;
        await shutdown();
        if (!context.mounted) return;
        context.closeScreenWithResult([for (final file in files) file.path]);
      } on Object {
        if (context.mounted) context.showToast(context.s.errorUnexpected);
      }
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
      isReady: controller.value != null,
      torchOn: torchOn.value,
      onToggleTorch: toggleTorch,
      onCapture: capture,
      onGallery: pickFromGallery,
    );
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Header(addsPage: _addsPage),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: Spacing.s),
                    _Header(addsPage: _addsPage),
                    const SizedBox(height: Spacing.m),
                    Flexible(child: preview),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Spacing.xl),
                child: controls,
              ),
              const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class const _Header({
  required final bool _addsPage,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CircleIconButton(
        icon: _addsPage ? Icons.arrow_back : Icons.close,
        tooltip: _addsPage ? context.s.back : context.s.close,
        onPressed: context.closeScreen,
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
          final aspectRatio = switch (state.frameAspectRatio) {
            final double ratio when context.layout.isLandscape => 1 / ratio,
            final double ratio => ratio,
            _ => null,
          };
          final frame = _frameRect(constraints.biggest, aspectRatio);
          if (state.quad case final quad? when frame != null) {
            return Stack(
              children: [
                Positioned.fromRect(
                  rect: frame,
                  child: PageQuadOverlay(quad: quad, lineColor: context.c.primary),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class const _Controls({
  required final bool _isReady,
  required final bool _torchOn,
  required final Future<void> Function() _onToggleTorch,
  required final Future<void> Function() _onCapture,
  required final Future<void> Function() _onGallery,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _SquareButton(
          icon: Icons.photo_library_outlined,
          tooltip: context.s.captureGalleryLabel,
          foreground: context.c.onSurface,
          onTap: _onGallery,
        ),
        _ShutterButton(enabled: _isReady, onTap: _isReady ? _onCapture : null),
        _SquareButton(
          icon: _torchOn ? Icons.flash_on : Icons.flash_off,
          tooltip: _torchOn ? context.s.captureLightOn : context.s.captureLightOff,
          background: _torchOn ? context.c.primary : null,
          foreground: _torchOn ? context.c.onPrimary : context.c.primary,
          onTap: _isReady ? _onToggleTorch : null,
        ),
      ],
    );
  }
}

class const _SquareButton({
  required final IconData _icon,
  required final String _tooltip,
  required final Color _foreground,
  required final VoidCallback? _onTap,
  final Color? _background,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onTap,
      tooltip: _tooltip,
      icon: Icon(_icon),
      iconSize: Spacing.iconM,
      style: IconButton.styleFrom(
        backgroundColor: _background ?? context.c.surfaceContainerHigh,
        foregroundColor: _foreground,
        fixedSize: const Size.square(_controlIcon),
        minimumSize: const Size.square(_controlIcon),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.radiusM)),
      ),
    );
  }
}

class const _ShutterButton({
  required final bool _enabled,
  required final VoidCallback? _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _enabled ? 1 : _disabledOpacity,
      child: Semantics(
        label: context.s.captureShutterLabel,
        button: true,
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
      ),
    );
  }
}

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
        continue;
      }
    }
  }
  return null;
}

double _fallbackAspectRatio(BuildContext context) {
  return context.layout.isLandscape ? 1 / _portraitAspectRatio : _portraitAspectRatio;
}

double _previewAspectRatio(BuildContext context, CameraController camera) {
  final size = camera.value.previewSize;
  if (size == null) return 1;
  return context.layout.isLandscape
      ? size.longestSide / size.shortestSide
      : size.shortestSide / size.longestSide;
}

Rect? _frameRect(Size size, double? aspectRatio) {
  if (aspectRatio == null) return null;
  if (aspectRatio > size.width / size.height) {
    final height = size.width / aspectRatio;
    return Rect.fromLTWH(0, (size.height - height) / 2, size.width, height);
  }
  final width = size.height * aspectRatio;
  return Rect.fromLTWH((size.width - width) / 2, 0, width, size.height);
}
