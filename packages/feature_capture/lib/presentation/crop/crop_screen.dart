import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_capture/presentation/crop/crop_bloc.dart';
import 'package:feature_capture/presentation/crop/crop_event.dart';
import 'package:feature_capture/presentation/crop/crop_state.dart';
import 'package:feature_capture/presentation/widgets/page_crop_view.dart';
import 'package:feature_capture/presentation/widgets/page_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/captured_shot.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/capture_arguments.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/confirm_dialog.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/loading_indicator.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';

const _sideColumnWidth = 300.0;
const _photoFlex = 4;
const _overlayOpacity = 0.6;

class const CropScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) unawaited(_cancel(context));
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<CropBloc, CropState>(
            listenWhen: (previous, current) => current is CropReady && current.addError != null,
            listener: (context, state) {
              if (state case CropReady(addError: final AppError error)) {
                context.showToast(error.toMessage(context));
              }
            },
            builder: (context, state) => switch (state) {
              CropLoading() => LoadingScreen(message: context.s.cropLoadingMessage),
              CropFailure(:final error) => _FailureView(error: error),
              CropReady() => _Editor(state: state),
            },
          ),
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
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CropBloc>();
    final photo = Stack(
      children: [
        PageCropView(
          key: ValueKey(_state.selectedPage.imagePath),
          page: _state.selectedPage,
          onCornerMoved: (corner, position) => bloc.add(CropCornerMoved(corner, position)),
        ),
        if (_state.isAdding) const Positioned.fill(child: _AddingOverlay()),
      ],
    );
    final strip = PageStrip(
      pages: _state.pages,
      selectedIndex: _state.selectedIndex,
      onSelect: (index) => bloc.add(CropPageSelected(index)),
      onMove: (fromIndex, toIndex) => bloc.add(CropPageMoved(fromIndex, toIndex)),
      onAdd: _state.isAdding ? null : () => _addPages(context),
      onRotate: _state.isAdding ? null : () => bloc.add(const CropPageRotated()),
    );
    final continueButton = Center(
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: _state.isAdding ? null : () => _continue(context, _state),
          child: Text(context.s.cropContinueButton(_state.pages.length)),
        ),
      ),
    );
    if (context.layout.isLandscape) {
      return Padding(
        padding: const EdgeInsets.all(Spacing.m),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Center(child: photo)),
            const SizedBox(width: Spacing.m),
            SizedBox(
              width: _sideColumnWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Header(state: _state),
                  const Spacer(),
                  strip,
                  Expanded(child: continueButton),
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
          _Header(state: _state),
          const SizedBox(height: Spacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: _photoFlex,
                  child: Align(alignment: Alignment.topCenter, heightFactor: 1, child: photo),
                ),
                const SizedBox(height: Spacing.m),
                strip,
                Expanded(child: continueButton),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class const _AddingOverlay() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.c.scrim.withValues(alpha: _overlayOpacity),
      child: LoadingIndicator(message: context.s.cropLoadingMessage),
    );
  }
}

class const _Header({
  required final CropReady _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleIconButton(
          icon: Icons.close,
          tooltip: context.s.close,
          onPressed: () => _cancel(context),
        ),
        const SizedBox(width: Spacing.s),
        Expanded(child: _Title(state: _state)),
        if (_state.pages.length > 1) ...[
          const SizedBox(width: Spacing.s),
          _RemoveAction(index: _state.selectedIndex),
        ],
      ],
    );
  }
}

class const _Title({
  required final CropReady _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!_state.hasAdjusted) {
      return Text(
        context.s.cropAdjustHint,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.t.titleMedium,
      );
    }
    if (!_state.selectedPage.isUnsure) return const SizedBox.shrink();
    return Row(
      children: [
        Icon(
          Icons.warning_amber_rounded,
          size: Spacing.iconM,
          color: context.status.uncertain.solid,
        ),
        const SizedBox(width: Spacing.xs),
        Flexible(
          child: Text(
            context.s.cropUnsureTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.t.titleMedium,
          ),
        ),
      ],
    );
  }
}

class const _RemoveAction({
  required final int _index,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: () => _removePage(context, _index),
      color: context.c.errorContainer,
      radius: Spacing.radiusM,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.delete_outline, size: Spacing.iconS, color: context.c.error),
          const SizedBox(width: Spacing.xxs),
          Text(
            context.s.cropRemovePageButton,
            style: context.t.labelLarge?.copyWith(color: context.c.error),
          ),
        ],
      ),
    );
  }
}

Future<void> _cancel(BuildContext context) async {
  final confirmed = await showConfirmDialog(
    context,
    title: context.s.cropCancelTitle,
    message: context.s.cropCancelMessage,
    confirmLabel: context.s.cropCancelConfirmButton,
    destructive: true,
  );
  if (confirmed && context.mounted) context.goLibrary();
}

Future<void> _removePage(BuildContext context, int index) async {
  final bloc = context.read<CropBloc>();
  final confirmed = await showConfirmDialog(
    context,
    title: context.s.cropRemovePageTitle,
    message: context.s.cropRemovePageMessage,
    confirmLabel: context.s.cropRemovePageButton,
    destructive: true,
  );
  if (confirmed) bloc.add(CropPageRemoved(index));
}

Future<void> _addPages(BuildContext context) async {
  final bloc = context.read<CropBloc>();
  final imagePaths = await context.pushCapture(const CaptureArguments(addsPage: true));
  if (imagePaths == null || imagePaths.isEmpty) return;
  bloc.add(CropPagesAdded(imagePaths));
}

Future<void> _continue(BuildContext context, CropReady state) async {
  await context.pushMarking(
    MarkingArguments(
      shots: [
        for (final page in state.pages)
          CapturedShot(imagePath: page.imagePath, pageQuad: page.sourceQuad),
      ],
    ),
  );
}
