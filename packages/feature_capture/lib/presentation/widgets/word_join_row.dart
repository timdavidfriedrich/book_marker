import 'dart:io';
import 'dart:math' as math;

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/recognized_spread.dart';
import 'package:shared/domain/entities/recognized_word.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/dashed_border_painter.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _rowHeight = 68.0;
const _neighbourMinWidth = 76.0;
const _currentMinWidth = 124.0;
const _joinColumnWidth = 37.0;
const _joinButtonSize = 30.0;
const _joinIconSize = 10.0;
const _joinIconGap = 2.0;
const _previewZoom = 0.3;
const _minWordHeight = 0.01;
const _markOpacity = 0.22;
const _markPadding = 2.0;
const _glowBlur = 12.0;
const _glowOpacity = 0.22;
const _placeholderTextScale = 0.9;

typedef _Bounds = ({double left, double top, double width, double height});

class const WordJoinRow({
  required final List<SpreadPage> _pages,
  required final List<RecognizedWord> _words,
  required final List<int> _indexes,
  required final bool _joinedPrevious,
  required final bool _joinedNext,
  required final VoidCallback _onPreviousTap,
  required final VoidCallback _onNextTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => _ScrollingRow(
        viewportWidth: constraints.maxWidth,
        pages: _pages,
        words: _words,
        indexes: _indexes,
        joinedPrevious: _joinedPrevious,
        joinedNext: _joinedNext,
        onPreviousTap: _onPreviousTap,
        onNextTap: _onNextTap,
      ),
    );
  }
}

class const _ScrollingRow({
  required final double _viewportWidth,
  required final List<SpreadPage> _pages,
  required final List<RecognizedWord> _words,
  required final List<int> _indexes,
  required final bool _joinedPrevious,
  required final bool _joinedNext,
  required final VoidCallback _onPreviousTap,
  required final VoidCallback _onNextTap,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final first = _indexes.first;
    final last = _indexes.last;
    final previous = first > 0 ? _words[first - 1] : null;
    final next = last + 1 < _words.length ? _words[last + 1] : null;
    final currentWidth = _previewWidth(
      _pages[_words[first].pageIndex],
      _boundsOf(_words, _indexes),
      _currentMinWidth,
    );
    final previousWidth = _neighbourWidth(_pages, previous);
    final nextWidth = _neighbourWidth(_pages, next);
    final leading = _viewportWidth / 2 - (previousWidth + _joinColumnWidth + currentWidth / 2);
    final trailing = _viewportWidth / 2 - (currentWidth / 2 + _joinColumnWidth + nextWidth);
    final controller = useScrollController(initialScrollOffset: math.max(0, -leading));
    return SingleChildScrollView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: math.max(0, leading), right: math.max(0, trailing)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: _rowHeight,
            width: previousWidth + currentWidth + nextWidth + _joinColumnWidth * 2,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: previousWidth,
                        child: _NeighbourPreview(
                          pages: _pages,
                          word: previous,
                          joined: _joinedPrevious,
                          placeholder: context.s.markingCorrectionFirstWordLabel,
                        ),
                      ),
                      const SizedBox(width: _joinColumnWidth),
                      SizedBox(
                        width: currentWidth,
                        child: _PreviewFrame(
                          highlighted: true,
                          child: _WordPreview(
                            page: _pages[_words[first].pageIndex],
                            bounds: _boundsOf(_words, _indexes),
                            marks: _marksOf(_words, _indexes),
                          ),
                        ),
                      ),
                      const SizedBox(width: _joinColumnWidth),
                      SizedBox(
                        width: nextWidth,
                        child: _NeighbourPreview(
                          pages: _pages,
                          word: next,
                          joined: _joinedNext,
                          placeholder: context.s.markingCorrectionLastWordLabel,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Row(
                    children: [
                      SizedBox(width: previousWidth),
                      _JoinColumn(
                        joined: _joinedPrevious,
                        enabled: previous != null,
                        tooltip: context.s.markingCorrectionJoinPreviousButton,
                        onTap: _onPreviousTap,
                      ),
                      SizedBox(width: currentWidth),
                      _JoinColumn(
                        joined: _joinedNext,
                        enabled: next != null,
                        tooltip: context.s.markingCorrectionJoinNextButton,
                        onTap: _onNextTap,
                      ),
                      SizedBox(width: nextWidth),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.s),
          Row(
            children: [
              SizedBox(
                width: previousWidth,
                child: _NeighbourLabel(word: previous),
              ),
              const SizedBox(width: _joinColumnWidth),
              SizedBox(width: currentWidth),
              const SizedBox(width: _joinColumnWidth),
              SizedBox(
                width: nextWidth,
                child: _NeighbourLabel(word: next),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

double _neighbourWidth(List<SpreadPage> pages, RecognizedWord? word) {
  if (word == null) return _neighbourMinWidth;
  return _previewWidth(pages[word.pageIndex], _wordBounds(word), _neighbourMinWidth);
}

_Bounds _wordBounds(RecognizedWord word) =>
    (left: word.left, top: word.top, width: word.width, height: word.height);

List<_Bounds> _marksOf(List<RecognizedWord> words, List<int> indexes) {
  final page = words[indexes.first].pageIndex;
  return [
    for (final index in indexes)
      if (words[index].pageIndex == page) _wordBounds(words[index]),
  ];
}

double _previewWidth(SpreadPage page, _Bounds bounds, double minimum) {
  final imageHeight = _rowHeight * _previewZoom / math.max(bounds.height, _minWordHeight);
  final wordWidth = bounds.width * imageHeight * page.aspectRatio;
  return math.max(minimum, wordWidth + Spacing.m * 2);
}

_Bounds _boundsOf(List<RecognizedWord> words, List<int> indexes) {
  final page = words[indexes.first].pageIndex;
  var left = words[indexes.first].left;
  var top = words[indexes.first].top;
  var right = left + words[indexes.first].width;
  var bottom = top + words[indexes.first].height;
  for (final index in indexes) {
    final word = words[index];
    if (word.pageIndex != page) continue;
    left = math.min(left, word.left);
    top = math.min(top, word.top);
    right = math.max(right, word.left + word.width);
    bottom = math.max(bottom, word.top + word.height);
  }
  return (left: left, top: top, width: right - left, height: bottom - top);
}

class const _NeighbourPreview({
  required final List<SpreadPage> _pages,
  required final RecognizedWord? _word,
  required final bool _joined,
  required final String _placeholder,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (_word case final RecognizedWord word) {
      return _PreviewFrame(
        highlighted: _joined,
        child: _WordPreview(
          page: _pages[word.pageIndex],
          bounds: _wordBounds(word),
          marks: [_wordBounds(word)],
        ),
      );
    }
    return CustomPaint(
      painter: DashedBorderPainter(color: context.c.outline),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
          child: Text(
            _placeholder,
            textAlign: TextAlign.center,
            style: context.typography.caption.copyWith(
              color: context.c.onSurfaceVariant,
              fontSize: context.typography.caption.fontSize! * _placeholderTextScale,
            ),
          ),
        ),
      ),
    );
  }
}

class const _PreviewFrame({
  required final Widget _child,
  required final bool _highlighted,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.radiusM),
        boxShadow: _highlighted
            ? [
                BoxShadow(
                  color: context.c.primary.withValues(alpha: _glowOpacity),
                  blurRadius: _glowBlur,
                ),
              ]
            : null,
      ),
      foregroundDecoration: _highlighted
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(Spacing.radiusM),
              border: Border.all(color: context.c.primary, width: Spacing.borderWidthMedium),
            )
          : null,
      child: _child,
    );
  }
}

class const _WordPreview({
  required final SpreadPage _page,
  required final _Bounds _bounds,
  required final List<_Bounds> _marks,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.c.surfaceContainerHigh,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final imageHeight = height * _previewZoom / math.max(_bounds.height, _minWordHeight);
          final imageWidth = imageHeight * _page.aspectRatio;
          final imageLeft =
              constraints.maxWidth / 2 - (_bounds.left + _bounds.width / 2) * imageWidth;
          final imageTop = height / 2 - (_bounds.top + _bounds.height / 2) * imageHeight;
          final swatch = context.status.uncertain;
          return Stack(
            children: [
              Positioned(
                left: imageLeft,
                top: imageTop,
                width: imageWidth,
                height: imageHeight,
                child: Image.file(File(_page.imagePath), fit: BoxFit.fill),
              ),
              for (final mark in _marks)
                Positioned(
                  left: imageLeft + mark.left * imageWidth - _markPadding,
                  top: imageTop + mark.top * imageHeight - _markPadding,
                  width: mark.width * imageWidth + _markPadding * 2,
                  height: mark.height * imageHeight + _markPadding * 2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: swatch.solid.withValues(alpha: _markOpacity),
                      borderRadius: BorderRadius.circular(Spacing.radiusS),
                      border: Border.all(color: swatch.solid, width: Spacing.borderWidthThin),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class const _NeighbourLabel({
  required final RecognizedWord? _word,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      _word?.text ?? context.s.markingCorrectionNoNeighbourLabel,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
    );
  }
}

class const _JoinColumn({
  required final bool _joined,
  required final bool _enabled,
  required final String _tooltip,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _joinColumnWidth,
      child: OverflowBox(
        minWidth: 0,
        maxWidth: double.infinity,
        child: _joined
            ? _UndoJoinButton(onTap: _onTap)
            : _JoinButton(enabled: _enabled, tooltip: _tooltip, onTap: _onTap),
      ),
    );
  }
}

class const _JoinButton({
  required final bool _enabled,
  required final String _tooltip,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _tooltip,
      child: InkTapBox(
        circle: true,
        color: _enabled ? context.c.inverseSurface : context.c.surfaceContainerHigh,
        onTap: _enabled ? _onTap : null,
        child: SizedBox.square(
          dimension: _joinButtonSize,
          child: Center(
            child: _JoinArrows(
              outward: false,
              color: _enabled ? context.c.onInverseSurface : context.c.outline,
            ),
          ),
        ),
      ),
    );
  }
}

class const _UndoJoinButton({
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      shape: const StadiumBorder(),
      color: context.c.inverseSurface,
      onTap: _onTap,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _JoinArrows(outward: true, color: context.c.onInverseSurface),
          const SizedBox(width: Spacing.xs),
          Text(
            context.s.markingCorrectionUndoJoinButton,
            style: context.t.labelMedium?.copyWith(color: context.c.onInverseSurface),
          ),
        ],
      ),
    );
  }
}

class const _JoinArrows({
  required final bool _outward,
  required final Color _color,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          _outward ? Icons.arrow_back : Icons.arrow_forward,
          size: _joinIconSize,
          color: _color,
        ),
        const SizedBox(width: _joinIconGap),
        Icon(
          _outward ? Icons.arrow_forward : Icons.arrow_back,
          size: _joinIconSize,
          color: _color,
        ),
      ],
    );
  }
}
