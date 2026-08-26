import 'dart:io';

import 'package:core/theme/spacing.dart';
import 'package:feature_capture/domain/recognized_page.dart';
import 'package:feature_capture/presentation/marking/marking_bloc.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

const _selectedFillOpacity = 0.3;
const _lineBorderOpacity = 0.2;
const _previewMaxLines = 3;

class const MarkingScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.s.markingTitle)),
      body: BlocConsumer<MarkingBloc, MarkingState>(
        listener: (context, state) {
          if (state is MarkingSaved) {
            context.showToast(context.s.markingSavedMessage);
            context.closeScreen();
          }
          if (state is MarkingReady && state.saveError != null) {
            context.showToast(state.saveError!.toMessage(context));
          }
        },
        builder: (context, state) => switch (state) {
          MarkingProcessing() || MarkingSaved() => const _ProcessingView(),
          MarkingFailure(:final error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.l),
              child: Text(error.toMessage(context), textAlign: TextAlign.center),
            ),
          ),
          MarkingReady() => _Editor(state: state),
        },
      ),
    );
  }
}

class const _ProcessingView() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: Spacing.m),
        Text(context.s.markingProcessingMessage),
      ],
    );
  }
}

class const _Editor({
  required final MarkingReady _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (_state.page.lines.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.l),
          child: Text(context.s.markingNoTextMessage, textAlign: TextAlign.center),
        ),
      );
    }
    return Column(
      children: [
        Expanded(child: _MarkableImage(state: _state)),
        _MarkingPanel(state: _state),
      ],
    );
  }
}

class const _MarkableImage({
  required final MarkingReady _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final page = _state.page;
    return Center(
      child: AspectRatio(
        aspectRatio: page.aspectRatio,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.biggest;
            return Stack(
              children: [
                Positioned.fill(child: Image.file(File(_state.imagePath), fit: BoxFit.fill)),
                for (var index = 0; index < page.lines.length; index++)
                  _LineBox(
                    line: page.lines[index],
                    size: size,
                    isSelected: _state.selectedIndexes.contains(index),
                    onTap: () => context.read<MarkingBloc>().add(MarkingLineToggled(index)),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class const _LineBox({
  required final RecognizedLine _line,
  required final Size _size,
  required final bool _isSelected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _line.left * _size.width,
      top: _line.top * _size.height,
      width: _line.width * _size.width,
      height: _line.height * _size.height,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _isSelected
                ? context.c.primary.withValues(alpha: _selectedFillOpacity)
                : null,
            border: Border.all(
              color: _isSelected
                  ? context.c.primary
                  : context.c.onSurface.withValues(alpha: _lineBorderOpacity),
              width: Spacing.borderWidthThin,
            ),
          ),
        ),
      ),
    );
  }
}

class const _MarkingPanel({
  required final MarkingReady _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderedIndexes = _state.selectedIndexes.toList()..sort();
    final selectedText = orderedIndexes.map((index) => _state.page.lines[index].text).join(" ");
    final canSave = _state.selectedIndexes.isNotEmpty && !_state.isSaving;
    return Material(
      color: context.c.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.s.markingSelectedLabel, style: context.t.labelLarge),
            const SizedBox(height: Spacing.xxs),
            Text(
              selectedText.isEmpty ? context.s.markingNothingSelectedMessage : selectedText,
              maxLines: _previewMaxLines,
              overflow: TextOverflow.ellipsis,
              style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
            ),
            const SizedBox(height: Spacing.m),
            _PageNumberField(
              initialPageNumber: _state.pageNumber,
              wasDetected: _state.page.detectedPageNumber != null,
            ),
            const SizedBox(height: Spacing.m),
            FilledButton(
              onPressed: canSave
                  ? () => context.read<MarkingBloc>().add(const MarkingSaveRequested())
                  : null,
              child: _state.isSaving
                  ? const SizedBox(
                      height: Spacing.iconM,
                      width: Spacing.iconM,
                      child: CircularProgressIndicator(strokeWidth: Spacing.borderWidthMedium),
                    )
                  : Text(context.s.markingSaveButton),
            ),
          ],
        ),
      ),
    );
  }
}

class const _PageNumberField({
  required final int? _initialPageNumber,
  required final bool _wasDetected,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _initialPageNumber?.toString() ?? "");
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) =>
          context.read<MarkingBloc>().add(MarkingPageNumberChanged(int.tryParse(value))),
      decoration: InputDecoration(
        labelText: context.s.markingPageNumberLabel,
        hintText: context.s.markingPageNumberHint,
        helperText: _wasDetected ? null : context.s.markingPageNumberMissing,
        prefixIcon: const Icon(Icons.numbers),
      ),
    );
  }
}
