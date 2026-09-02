import 'dart:io';
import 'dart:math' as math;

import 'package:core/theme/spacing.dart';
import 'package:feature_capture/domain/recognized_spread.dart';
import 'package:feature_capture/presentation/marking/marking_bloc.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/recognized_word.dart';
import 'package:shared/domain/entities/recognized_word_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';

const _previewHeight = 96.0;
const _neighbourPreviewHeight = 48.0;
const _neighbourPreviewWidth = 132.0;
const _previewZoom = 0.45;
const _minWordHeight = 0.01;
const _maxSuggestions = 4;
const _handleWidth = 44.0;
const _handleHeight = 5.0;

typedef _Bounds = ({double left, double top, double width, double height});

Future<void> showWordCorrectionSheet(BuildContext context, {required int wordIndex}) {
  final bloc = context.read<MarkingBloc>();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    showDragHandle: false,
    builder: (_) => BlocProvider.value(
      value: bloc,
      child: _WordCorrectionSheet(wordIndex: wordIndex),
    ),
  );
}

class const _WordCorrectionSheet({
  required final int _wordIndex,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.read<MarkingBloc>().state;
    if (state is! MarkingReady) return const SizedBox.shrink();
    final words = state.words;
    final group = words.groupAt(_wordIndex);
    if (group == null) return const SizedBox.shrink();
    final first = group.indexes.first;
    final last = group.indexes.last;
    final page = state.pages[words[first].pageIndex];
    final samePageIndexes = [
      for (final index in group.indexes)
        if (words[index].pageIndex == words[first].pageIndex) index,
    ];
    final previous = first > 0 ? words[first - 1] : null;
    final next = last + 1 < words.length ? words[last + 1] : null;
    final suggestions = words[first].suggestions;
    final controller = useTextEditingController(text: group.text);

    void merge(int index) {
      context.read<MarkingBloc>().add(MarkingWordsMerged(index));
      Navigator.of(context).pop();
    }

    void apply() {
      final text = controller.text.trim();
      if (text.isEmpty) return;
      context.read<MarkingBloc>().add(MarkingWordCorrected(first, text));
      Navigator.of(context).pop();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.c.surfaceContainerLowest,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(Spacing.radiusXxl)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(Spacing.s, Spacing.s, Spacing.s, Spacing.s),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: _handleWidth,
                  height: _handleHeight,
                  decoration: BoxDecoration(
                    color: context.c.outline,
                    borderRadius: BorderRadius.circular(Spacing.radiusFull),
                  ),
                ),
              ),
              const SizedBox(height: Spacing.m),
              Row(
                children: [
                  Badge(label: Text("${group.number ?? 1}")),
                  const SizedBox(width: Spacing.s),
                  Expanded(
                    child: Text(context.s.markingCorrectionTitle, style: context.t.titleLarge),
                  ),
                  const SizedBox(width: Spacing.s),
                  CircleIconButton(
                    icon: Icons.close,
                    tooltip: context.s.close,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.xs),
              Text(
                context.s.markingCorrectionHint,
                style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
              ),
              const SizedBox(height: Spacing.m),
              _WordPreview(
                page: page,
                bounds: _boundsOf(words, samePageIndexes),
                height: _previewHeight,
              ),
              if (suggestions.isNotEmpty) ...[
                const SizedBox(height: Spacing.m),
                Wrap(
                  spacing: Spacing.xs,
                  runSpacing: Spacing.xs,
                  children: [
                    for (final suggestion in suggestions.take(_maxSuggestions))
                      SelectableChip(
                        label: suggestion,
                        selected: false,
                        onTap: () => controller.text = suggestion,
                      ),
                  ],
                ),
              ],
              const SizedBox(height: Spacing.m),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
                decoration: BoxDecoration(
                  color: context.status.uncertain.fill,
                  borderRadius: BorderRadius.circular(Spacing.radiusM),
                ),
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => apply(),
                  style: context.typography.readingBody.copyWith(
                    color: context.status.uncertain.onFill,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              if (previous case final RecognizedWord word) ...[
                const SizedBox(height: Spacing.s),
                _JoinRow(
                  page: state.pages[word.pageIndex],
                  word: word,
                  label: context.s.markingJoinPreviousButton(word.text),
                  onTap: () => merge(first - 1),
                ),
              ],
              if (next case final RecognizedWord word) ...[
                const SizedBox(height: Spacing.s),
                _JoinRow(
                  page: state.pages[word.pageIndex],
                  word: word,
                  label: context.s.markingJoinNextButton(word.text),
                  onTap: () => merge(last),
                ),
              ],
              const SizedBox(height: Spacing.m),
              FilledButton(
                onPressed: apply,
                child: Text(context.s.markingCorrectionApplyButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_Bounds _boundsOf(List<RecognizedWord> words, List<int> indexes) {
  var left = words[indexes.first].left;
  var top = words[indexes.first].top;
  var right = left + words[indexes.first].width;
  var bottom = top + words[indexes.first].height;
  for (final index in indexes) {
    final word = words[index];
    left = math.min(left, word.left);
    top = math.min(top, word.top);
    right = math.max(right, word.left + word.width);
    bottom = math.max(bottom, word.top + word.height);
  }
  return (left: left, top: top, width: right - left, height: bottom - top);
}

class const _JoinRow({
  required final SpreadPage _page,
  required final RecognizedWord _word,
  required final String _label,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: _neighbourPreviewWidth,
          child: _WordPreview(
            page: _page,
            bounds: (
              left: _word.left,
              top: _word.top,
              width: _word.width,
              height: _word.height,
            ),
            height: _neighbourPreviewHeight,
          ),
        ),
        const SizedBox(width: Spacing.s),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: SelectableChip(label: _label, selected: false, onTap: _onTap),
          ),
        ),
      ],
    );
  }
}

class const _WordPreview({
  required final SpreadPage _page,
  required final _Bounds _bounds,
  required final double _height,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusM),
      child: Container(
        height: _height,
        color: context.c.surfaceContainerHigh,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final imageHeight = _height * _previewZoom / math.max(_bounds.height, _minWordHeight);
            final imageWidth = imageHeight * _page.aspectRatio;
            return Stack(
              children: [
                Positioned(
                  left: constraints.maxWidth / 2 - (_bounds.left + _bounds.width / 2) * imageWidth,
                  top: _height / 2 - (_bounds.top + _bounds.height / 2) * imageHeight,
                  width: imageWidth,
                  height: imageHeight,
                  child: Image.file(File(_page.imagePath), fit: BoxFit.fill),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
