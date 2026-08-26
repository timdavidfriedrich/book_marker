import 'dart:async';

import 'package:camera/camera.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_capture/presentation/capture/capture_bloc.dart';
import 'package:feature_capture/presentation/capture/capture_event.dart';
import 'package:feature_capture/presentation/capture/capture_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

const _overlayOpacity = 0.55;
const _shutterSize = 72.0;

class const CaptureScreen({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useState<CameraController?>(null);
    final hasError = useState(false);

    useEffect(() {
      var isDisposed = false;
      CameraController? created;
      Future<void> initialize() async {
        try {
          final cameras = await availableCameras();
          if (cameras.isEmpty) {
            if (!isDisposed) hasError.value = true;
            return;
          }
          created = CameraController(cameras.first, ResolutionPreset.high, enableAudio: false);
          await created!.initialize();
          if (!isDisposed) controller.value = created;
        } on Object {
          if (!isDisposed) hasError.value = true;
        }
      }

      unawaited(initialize());
      return () {
        isDisposed = true;
        unawaited(created?.dispose() ?? Future<void>.value());
      };
    }, const []);

    final camera = controller.value;
    return Scaffold(
      appBar: AppBar(title: Text(context.s.captureTitle)),
      body: switch ((hasError.value, camera)) {
        (true, _) => const _CameraUnavailable(),
        (_, final CameraController activeCamera) => _CameraView(controller: activeCamera),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class const _CameraView({
  required final CameraController _controller,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreview(_controller),
        Positioned(
          bottom: Spacing.xl,
          left: Spacing.m,
          right: Spacing.m,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _BookSelector(),
              const SizedBox(height: Spacing.m),
              _ShutterButton(controller: _controller),
            ],
          ),
        ),
      ],
    );
  }
}

class const _BookSelector() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.c.surface.withValues(alpha: _overlayOpacity),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xxs),
        child: BlocBuilder<CaptureBloc, CaptureState>(
          builder: (context, state) => switch (state) {
            CaptureReady(:final books, :final selectedBookId) => _BookDropdown(
              books: books,
              selectedBookId: selectedBookId,
            ),
            CaptureFailure() || CaptureEmpty() => const _AddBookAction(),
            CaptureLoading() => const SizedBox(height: Spacing.xl),
          },
        ),
      ),
    );
  }
}

class const _BookDropdown({
  required final List<Book> _books,
  required final String _selectedBookId,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedBookId,
              isExpanded: true,
              items: _books
                  .map(
                    (book) => DropdownMenuItem(
                      value: book.id,
                      child: Text(book.title, overflow: TextOverflow.ellipsis),
                    ),
                  )
                  .toList(),
              onChanged: (bookId) {
                if (bookId != null) {
                  context.read<CaptureBloc>().add(CaptureBookSelected(bookId));
                }
              },
            ),
          ),
        ),
        IconButton(
          tooltip: context.s.captureAddBookButton,
          icon: const Icon(Icons.add),
          onPressed: () => _addBook(context),
        ),
      ],
    );
  }
}

class const _AddBookAction() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(context.s.captureNoBooksMessage)),
        const SizedBox(width: Spacing.xs),
        FilledButton.icon(
          onPressed: () => _addBook(context),
          icon: const Icon(Icons.add),
          label: Text(context.s.captureAddBookButton),
        ),
      ],
    );
  }
}

class const _ShutterButton({
  required final CameraController _controller,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaptureBloc, CaptureState>(
      builder: (context, state) {
        final selectedBookId = state is CaptureReady ? state.selectedBookId : null;
        return FloatingActionButton.large(
          heroTag: null,
          onPressed: selectedBookId == null
              ? null
              : () => _capturePage(context, _controller, selectedBookId),
          child: const Icon(Icons.camera_alt, size: _shutterSize / 2),
        );
      },
    );
  }
}

class const _CameraUnavailable() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Text(context.s.captureCameraUnavailable, textAlign: TextAlign.center),
      ),
    );
  }
}

Future<void> _addBook(BuildContext context) async {
  final captureBloc = context.read<CaptureBloc>();
  final bookId = await context.pushAddBook();
  if (bookId != null) captureBloc.add(CaptureBookSelected(bookId));
}

Future<void> _capturePage(
  BuildContext context,
  CameraController controller,
  String bookId,
) async {
  try {
    final file = await controller.takePicture();
    if (context.mounted) {
      context.pushMarking(MarkingArguments(imagePath: file.path, bookId: bookId));
    }
  } on Object {
    if (context.mounted) context.showToast(context.s.errorUnexpected);
  }
}
