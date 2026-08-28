import 'dart:async';

import 'package:camera/camera.dart';
import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:feature_capture/presentation/capture/capture_bloc.dart';
import 'package:feature_capture/presentation/capture/capture_event.dart';
import 'package:feature_capture/presentation/capture/capture_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/presentation/extensions/accent_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _shutterOuter = 88.0;
const _shutterInner = 60.0;
const _cornerDot = 14.0;
const _controlIcon = 56.0;

class const CaptureScreen({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useState<CameraController?>(null);
    final hasError = useState(false);
    final torchOn = useState(false);

    Future<void> initialize() async {
      if (controller.value != null) return;
      try {
        final cameras = await availableCameras();
        if (cameras.isEmpty) {
          hasError.value = true;
          return;
        }
        final created = CameraController(cameras.first, ResolutionPreset.veryHigh, enableAudio: false);
        await created.initialize();
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

    Future<void> capture(String bookId) async {
      final camera = controller.value;
      if (camera == null) return;
      try {
        final file = await camera.takePicture();
        await shutdown();
        if (!context.mounted) return;
        await context.pushMarking(MarkingArguments(imagePath: file.path, bookId: bookId));
        if (context.mounted) await initialize();
      } on Object {
        if (context.mounted) context.showToast(context.s.errorUnexpected);
      }
    }

    Future<void> pickFromGallery(String bookId) async {
      try {
        final file = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (file == null) return;
        await shutdown();
        if (!context.mounted) return;
        await context.pushMarking(MarkingArguments(imagePath: file.path, bookId: bookId));
        if (context.mounted) await initialize();
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

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
          child: Column(
            children: [
              const SizedBox(height: Spacing.s),
              const _ModeToggle(),
              const SizedBox(height: Spacing.m),
              Expanded(
                child: _Preview(
                  camera: hasError.value ? null : controller.value,
                  unavailable: hasError.value,
                ),
              ),
              const SizedBox(height: Spacing.m),
              const _BookBar(),
              const SizedBox(height: Spacing.s),
              Text(
                context.s.captureSteadyHint,
                style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
              ),
              const SizedBox(height: Spacing.m),
              _Controls(
                camera: controller.value,
                torchOn: torchOn.value,
                onToggleTorch: toggleTorch,
                onCapture: capture,
                onGallery: pickFromGallery,
              ),
              const SizedBox(height: Spacing.s),
            ],
          ),
        ),
      ),
    );
  }
}

class const _ModeToggle() extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final selected = useState(0);
    return Center(
      child: Container(
        padding: const EdgeInsets.all(Spacing.xxxs),
        decoration: BoxDecoration(
          color: context.c.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(Spacing.radiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final entry in [context.s.captureModeOnePage, context.s.captureModeSpread].indexed)
              InkTapBox(
                onTap: () => selected.value = entry.$1,
                radius: Spacing.radiusFull,
                color: entry.$1 == selected.value ? context.palette.paperFill : Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.xs),
                child: Text(
                  entry.$2,
                  style: context.t.labelMedium?.copyWith(
                    fontSize: 14,
                    color: entry.$1 == selected.value
                        ? context.palette.paperText
                        : context.c.onSurfaceVariant,
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusXl),
      child: Container(
        color: context.c.surfaceContainerHigh,
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
                    style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
                  ),
                ),
              )
            else if (_camera case final CameraController camera)
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: camera.value.previewSize?.height ?? 1,
                  height: camera.value.previewSize?.width ?? 1,
                  child: CameraPreview(camera),
                ),
              )
            else
              const Center(child: CircularProgressIndicator()),
            _CornerDot(alignment: Alignment.topLeft, color: context.palette.amber.solid),
            _CornerDot(alignment: Alignment.topRight, color: context.palette.amber.solid),
            _CornerDot(alignment: Alignment.bottomLeft, color: context.palette.coral.solid),
            _CornerDot(alignment: Alignment.bottomRight, color: context.palette.coral.solid),
          ],
        ),
      ),
    );
  }
}

class const _CornerDot({
  required final Alignment _alignment,
  required final Color _color,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _alignment,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.m),
        child: Container(
          width: _cornerDot,
          height: _cornerDot,
          decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
        ),
      ),
    );
  }
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
    return Container(
      padding: const EdgeInsets.all(Spacing.s),
      decoration: BoxDecoration(
        color: context.palette.paperFill,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
      ),
      child: Row(
        children: [
          BookCover(accent: _book.id.accent, url: _book.thumbnailUrl, width: 36, height: 44, radius: Spacing.radiusS),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.s.captureMarkingInto,
                  style: context.typography.monoCaption.copyWith(color: context.palette.paperTextFaint),
                ),
                Text(
                  _book.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.t.titleMedium?.copyWith(color: context.palette.paperText),
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.s),
          const _SwitchButton(),
        ],
      ),
    );
  }
}

class const _SwitchButton() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: () => _addBook(context),
      color: context.palette.amber.solid,
      radius: Spacing.radiusFull,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.s.captureSwitchButton,
            style: context.t.labelMedium?.copyWith(color: context.palette.amber.onSolid, fontSize: 14),
          ),
          Icon(Icons.arrow_drop_down, size: Spacing.iconS, color: context.palette.amber.onSolid),
        ],
      ),
    );
  }
}

class const _NoBook() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.s),
      decoration: BoxDecoration(
        color: context.palette.paperFill,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.s.captureNoBooksMessage,
              style: context.t.bodyMedium?.copyWith(color: context.palette.paperText),
            ),
          ),
          const SizedBox(width: Spacing.s),
          InkTapBox(
            onTap: () => _addBook(context),
            color: context.palette.amber.solid,
            radius: Spacing.radiusFull,
            padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
            child: Text(
              context.s.captureAddBookButton,
              style: context.t.labelMedium?.copyWith(color: context.palette.amber.onSolid, fontSize: 14),
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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _GalleryButton(
              onTap: selectedBookId == null ? null : () => _onGallery(selectedBookId),
            ),
            _ShutterButton(
              enabled: canCapture,
              onTap: canCapture ? () => _onCapture(selectedBookId) : null,
            ),
            _TorchButton(enabled: _camera != null, on: _torchOn, onToggle: _onToggleTorch),
          ],
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
    final swatch = context.palette.resolve(AccentColor.sand);
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
            style: _squareStyle(background: swatch.solid, foreground: swatch.onSolid),
          ),
          const SizedBox(height: Spacing.xxs),
          Text(
            context.s.captureGalleryLabel,
            textAlign: TextAlign.center,
            style: context.typography.monoCaption.copyWith(color: context.c.onSurfaceVariant),
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
        color: context.palette.amber.solid,
        child: SizedBox(
          width: _shutterOuter,
          height: _shutterOuter,
          child: Center(
            child: Container(
              width: _shutterInner,
              height: _shutterInner,
              decoration: BoxDecoration(color: context.palette.coral.solid, shape: BoxShape.circle),
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
              background: _on ? context.palette.amber.solid : context.c.surfaceContainerHigh,
              foreground: _on ? context.palette.amber.onSolid : context.c.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: Spacing.xxs),
          Text(
            _on ? context.s.captureLightOn : context.s.captureLightOff,
            textAlign: TextAlign.center,
            style: context.typography.monoCaption.copyWith(
              color: _on ? context.palette.amber.solid : context.c.onSurfaceVariant,
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
