import 'dart:io';

import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_capture/presentation/crop/crop_bloc.dart';
import 'package:feature_capture/presentation/crop/crop_event.dart';
import 'package:feature_capture/presentation/crop/crop_state.dart';
import 'package:feature_capture/presentation/extensions/page_quad_extensions.dart';
import 'package:feature_capture/presentation/widgets/media_frame.dart';
import 'package:feature_capture/presentation/widgets/page_corner_dot.dart';
import 'package:feature_capture/presentation/widgets/page_quad_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/page_quad.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';

const _touchTarget = 48.0;
const _decodeWidth = 1600;
const _scrimOpacity = 0.55;
const _sideColumnWidth = 300.0;

class const CropScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CropBloc, CropState>(
          builder: (context, state) => switch (state) {
            CropLoading() => LoadingScreen(message: context.s.cropLoadingMessage),
            CropFailure(:final error) => _FailureView(error: error),
            CropReady() => _Editor(state: state),
          },
        ),
      ),
    );
  }
}

class const _FailureView({
  required final AppError _error,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Text(_error.toMessage(context), textAlign: TextAlign.center),
      ),
    );
  }
}

class const _Editor({
  required final CropReady _state,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // * a gallery shot decodes for seconds, and the editor is unusable until it is on screen
    final image = useMemoized(
      () => ResizeImage(FileImage(File(_state.imagePath)), width: _decodeWidth),
      [_state.imagePath],
    );
    final decoded = useFuture(useMemoized(() => precacheImage(image, context), [image]));
    if (decoded.connectionState != ConnectionState.done) {
      return LoadingScreen(message: context.s.cropLoadingMessage);
    }
    final photo = MediaFrame(
      aspectRatio: _state.aspectRatio,
      child: _Photo(state: _state, image: image),
    );
    final hint = Text(
      context.s.cropHint,
      textAlign: TextAlign.center,
      style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
    );
    final continueButton = FilledButton(
      onPressed: () => context.closeScreenWithResult(_state.quad),
      child: Text(context.s.cropContinueButton),
    );
    if (context.layout.isLandscape) {
      return Padding(
        padding: const EdgeInsets.all(Spacing.m),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: photo),
            const SizedBox(width: Spacing.m),
            SizedBox(
              width: _sideColumnWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _Header(),
                  const Spacer(),
                  hint,
                  const SizedBox(height: Spacing.m),
                  continueButton,
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Spacing.s),
          const _Header(),
          const SizedBox(height: Spacing.m),
          Expanded(child: photo),
          const SizedBox(height: Spacing.m),
          hint,
          const SizedBox(height: Spacing.m),
          continueButton,
          const SizedBox(height: Spacing.s),
        ],
      ),
    );
  }
}

class const _Header() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleIconButton(
          icon: Icons.arrow_back,
          tooltip: context.s.back,
          onPressed: context.closeScreen,
        ),
        const SizedBox(width: Spacing.s),
        Expanded(child: Text(context.s.cropTitle, style: context.t.titleLarge)),
      ],
    );
  }
}

class const _Photo({
  required final CropReady _state,
  required final ImageProvider<Object> _image,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
                    Image(image: _image, fit: BoxFit.fill),
                    PageQuadOverlay(
                      quad: _state.quad,
                      lineColor: context.c.primary,
                      scrimColor: context.c.scrim.withValues(alpha: _scrimOpacity),
                    ),
                  ],
                ),
              ),
            ),
            for (final corner in PageCorner.values)
              _DraggableDot(corner: corner, point: _state.quad.pointAt(corner), size: size),
          ],
        );
      },
    );
  }
}

class const _DraggableDot({
  required final PageCorner _corner,
  required final PagePoint _point,
  required final Size _size,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _point.x * _size.width - _touchTarget / 2,
      top: _point.y * _size.height - _touchTarget / 2,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (details) => context.read<CropBloc>().add(
          CropCornerMoved(
            _corner,
            PagePoint(
              x: _point.x + details.delta.dx / _size.width,
              y: _point.y + details.delta.dy / _size.height,
            ),
          ),
        ),
        child: SizedBox(
          width: _touchTarget,
          height: _touchTarget,
          child: Center(child: PageCornerDot(corner: _corner)),
        ),
      ),
    );
  }
}
