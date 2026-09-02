import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:core/theme/spacing.dart';
import 'package:feature_capture/presentation/widgets/uncertain_word_chip.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/recognized_word.dart';
import 'package:shared/domain/entities/recognized_word_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _highlightOpacity = 0.4;
const _highlightInflate = 1.5;
const _handleRadius = 6.0;
const _handleTouchRadius = 24.0;
const _autoScrollEdge = 24.0;
const _autoScrollVelocity = 30.0;

enum _Handle { start, end }

typedef _TextLayout = ({
  List<InlineSpan> spans,
  List<WordGroup> groups,
  List<int> starts,
  List<int> ends,
});

class const WordSelectionText({
  required final List<RecognizedWord> _words,
  required final Set<int> _selectedWordIndexes,
  required final ValueChanged<Set<int>> _onSelectionChanged,
  required final ValueChanged<int> _onUncertainWordTap,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final paragraphKey = useMemoized(GlobalKey.new);
    final anchorGroup = useRef<int?>(null);
    final dragPosition = useRef<Offset?>(null);
    final extendCallback = useRef<ValueChanged<Offset>?>(null);
    final scrollable = Scrollable.maybeOf(context);
    final autoScroller = useMemoized(() {
      if (scrollable == null) return null;
      return EdgeDraggingAutoScroller(
        scrollable,
        velocityScalar: _autoScrollVelocity,
        onScrollViewScrolled: () {
          if (dragPosition.value case final Offset position) extendCallback.value?.call(position);
        },
      );
    }, [scrollable]);
    useEffect(() {
      return () => autoScroller?.stopAutoScroll();
    }, [autoScroller]);
    final layout = useMemoized(() => _buildLayout(_words, _onUncertainWordTap), [_words]);
    final selectedGroups = [
      for (var index = 0; index < layout.groups.length; index++)
        if (layout.groups[index].indexes.any(_selectedWordIndexes.contains)) index,
    ];
    final runs = _selectionRuns(layout, selectedGroups);

    int? groupAt(Offset globalPosition) {
      final render = _paragraphOf(paragraphKey);
      if (render == null || layout.groups.isEmpty) return null;
      final local = render.globalToLocal(globalPosition);
      final offset = render.getPositionForOffset(local).offset;
      for (var index = 0; index < layout.ends.length; index++) {
        if (offset <= layout.ends[index]) return index;
      }
      return layout.ends.length - 1;
    }

    void selectRange(int from, int to) {
      final start = math.min(from, to);
      final end = math.max(from, to);
      if (selectedGroups.length == end - start + 1 &&
          selectedGroups.first == start &&
          selectedGroups.last == end) {
        return;
      }
      _onSelectionChanged({
        for (var index = start; index <= end; index++) ...layout.groups[index].indexes,
      });
    }

    void extendTo(Offset globalPosition) {
      if (anchorGroup.value case final int anchor) {
        if (groupAt(globalPosition) case final int group) selectRange(anchor, group);
      }
    }

    extendCallback.value = extendTo;

    // * the drag target reaches past the pointer so the scroll already starts near the viewport edge
    void dragTo(Offset globalPosition) {
      dragPosition.value = globalPosition;
      extendTo(globalPosition);
      autoScroller?.startAutoScrollIfNecessary(
        Rect.fromCenter(center: globalPosition, width: 1, height: _autoScrollEdge * 2),
      );
    }

    void dragEnded() {
      dragPosition.value = null;
      autoScroller?.stopAutoScroll();
    }

    // * a pointer on a handle belongs to the handle drag, never to a tap or a fresh long press
    _Handle? handleAt(Offset globalPosition) {
      final render = _paragraphOf(paragraphKey);
      if (render == null || selectedGroups.isEmpty) return null;
      if (_handlePoints(render, runs) case final points?) {
        final local = render.globalToLocal(globalPosition);
        final toStart = (local - points.start).distance;
        final toEnd = (local - points.end).distance;
        if (math.min(toStart, toEnd) > _handleTouchRadius) return null;
        return toStart <= toEnd ? _Handle.start : _Handle.end;
      }
      return null;
    }

    void tapped(Offset globalPosition) {
      if (handleAt(globalPosition) != null) return;
      if (selectedGroups.isNotEmpty) {
        _onSelectionChanged(const {});
        return;
      }
      if (groupAt(globalPosition) case final int group) {
        anchorGroup.value = group;
        selectRange(group, group);
      }
    }

    void longPressed(Offset globalPosition) {
      if (handleAt(globalPosition) != null) return;
      if (groupAt(globalPosition) case final int group) {
        HapticFeedback.selectionClick();
        anchorGroup.value = group;
        selectRange(group, group);
      }
    }

    // * only pointers landing on a handle may drag, so every other drag stays with the scroll view
    bool grabsHandle(Offset globalPosition) {
      if (handleAt(globalPosition) case final handle?) {
        anchorGroup.value = handle == _Handle.start ? selectedGroups.last : selectedGroups.first;
        return true;
      }
      return false;
    }

    return RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      gestures: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          TapGestureRecognizer.new,
          (instance) => instance.onTapUp = (details) => tapped(details.globalPosition),
        ),
        LongPressGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
              LongPressGestureRecognizer.new,
              (instance) {
                instance.onLongPressStart = (details) => longPressed(details.globalPosition);
                instance.onLongPressMoveUpdate = (details) => dragTo(details.globalPosition);
                instance.onLongPressEnd = (details) => dragEnded();
                instance.onLongPressCancel = dragEnded;
              },
            ),
        _HandleDragRecognizer: GestureRecognizerFactoryWithHandlers<_HandleDragRecognizer>(
          _HandleDragRecognizer.new,
          (instance) {
            instance.canStart = grabsHandle;
            instance.onUpdate = (details) => dragTo(details.globalPosition);
            instance.onEnd = (details) => dragEnded();
            instance.onCancel = dragEnded;
          },
        ),
      },
      child: CustomPaint(
        painter: _HighlightPainter(
          paragraphKey: paragraphKey,
          runs: runs,
          color: context.c.primary.withValues(alpha: _highlightOpacity),
        ),
        foregroundPainter: _HandlePainter(
          paragraphKey: paragraphKey,
          runs: runs,
          color: context.c.primary,
          borderColor: context.palette.paperText,
        ),
        child: RichText(
          key: paragraphKey,
          textScaler: MediaQuery.textScalerOf(context),
          text: TextSpan(
            children: layout.spans,
            style: context.typography.readingBody.copyWith(color: context.palette.paperText),
          ),
        ),
      ),
    );
  }
}

_TextLayout _buildLayout(List<RecognizedWord> words, ValueChanged<int> onUncertainWordTap) {
  final groups = words.wordGroups();
  final spans = <InlineSpan>[];
  final starts = <int>[];
  final ends = <int>[];
  var offset = 0;
  for (var groupIndex = 0; groupIndex < groups.length; groupIndex++) {
    final group = groups[groupIndex];
    final int length;
    if (group.number case final int number) {
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: UncertainWordChip(
            text: group.text,
            number: number,
            onTap: () => onUncertainWordTap(group.indexes.first),
          ),
        ),
      );
      length = 1;
    } else {
      spans.add(TextSpan(text: group.text));
      length = group.text.length;
    }
    starts.add(offset);
    ends.add(offset + length);
    offset += length;
    if (groupIndex < groups.length - 1) {
      spans.add(const TextSpan(text: " "));
      offset += 1;
    }
  }
  return (spans: spans, groups: groups, starts: starts, ends: ends);
}

List<TextSelection> _selectionRuns(_TextLayout layout, List<int> selectedGroups) {
  final runs = <TextSelection>[];
  var index = 0;
  while (index < selectedGroups.length) {
    var last = index;
    while (last + 1 < selectedGroups.length &&
        selectedGroups[last + 1] == selectedGroups[last] + 1) {
      last++;
    }
    runs.add(
      TextSelection(
        baseOffset: layout.starts[selectedGroups[index]],
        extentOffset: layout.ends[selectedGroups[last]],
      ),
    );
    index = last + 1;
  }
  return runs;
}

RenderParagraph? _paragraphOf(GlobalKey key) {
  final renderObject = key.currentContext?.findRenderObject();
  return renderObject is RenderParagraph ? renderObject : null;
}

List<Rect> _runRects(RenderParagraph paragraph, TextSelection run) {
  return [
    for (final box in paragraph.getBoxesForSelection(run, boxHeightStyle: ui.BoxHeightStyle.max))
      box.toRect(),
  ];
}

({Offset start, Offset end})? _handlePoints(RenderParagraph paragraph, List<TextSelection> runs) {
  if (runs.isEmpty) return null;
  final first = _runRects(paragraph, runs.first);
  final last = _runRects(paragraph, runs.last);
  if (first.isEmpty || last.isEmpty) return null;
  return (
    start: Offset(first.first.left - _handleRadius, first.first.center.dy),
    end: Offset(last.last.right + _handleRadius, last.last.center.dy),
  );
}

class const _HighlightPainter({
  required final GlobalKey _paragraphKey,
  required final List<TextSelection> _runs,
  required final Color _color,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paragraph = _paragraphOf(_paragraphKey);
    if (paragraph == null) return;
    final paint = Paint()..color = _color;
    for (final run in _runs) {
      for (final rect in _runRects(paragraph, run)) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            rect.inflate(_highlightInflate),
            const Radius.circular(Spacing.radiusS),
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class const _HandlePainter({
  required final GlobalKey _paragraphKey,
  required final List<TextSelection> _runs,
  required final Color _color,
  required final Color _borderColor,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paragraph = _paragraphOf(_paragraphKey);
    if (paragraph == null) return;
    if (_handlePoints(paragraph, _runs) case final points?) {
      final fill = Paint()..color = _color;
      final border = Paint()
        ..color = _borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = Spacing.borderWidthMedium;
      for (final point in [points.start, points.end]) {
        canvas
          ..drawCircle(point, _handleRadius, fill)
          ..drawCircle(point, _handleRadius, border);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _HandleDragRecognizer() extends PanGestureRecognizer {
  bool Function(Offset globalPosition)? canStart;

  @override
  bool isPointerAllowed(PointerEvent event) {
    if (canStart?.call(event.position) != true) return false;
    return super.isPointerAllowed(event);
  }
}
