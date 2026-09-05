import 'dart:math' as math;

import 'package:core/theme/spacing.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

const _endAlignedSpacing = Spacing.xs;
const _stretchedSpacing = Spacing.s;
const _stackedSpacing = Spacing.xxs;

class const AdaptiveActions({
  required super.children,
  final bool _isStretched = false,
  super.key,
}) extends MultiChildRenderObjectWidget {
  const AdaptiveActions.stretched({required List<Widget> children, Key? key})
    : this(children: children, isStretched: true, key: key);

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderAdaptiveActions(Directionality.of(context), _isStretched);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    (renderObject as _RenderAdaptiveActions)
      ..textDirection = Directionality.of(context)
      ..isStretched = _isStretched;
  }
}

class _AdaptiveActionsParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderAdaptiveActions extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _AdaptiveActionsParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _AdaptiveActionsParentData> {
  _RenderAdaptiveActions(this._textDirection, this._isStretched);

  TextDirection _textDirection;
  bool _isStretched;

  set textDirection(TextDirection value) {
    if (_textDirection == value) return;
    _textDirection = value;
    markNeedsLayout();
  }

  set isStretched(bool value) {
    if (_isStretched == value) return;
    _isStretched = value;
    markNeedsLayout();
  }

  double get _horizontalSpacing => _isStretched ? _stretchedSpacing : _endAlignedSpacing;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _AdaptiveActionsParentData) {
      child.parentData = _AdaptiveActionsParentData();
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    var width = 0.0;
    for (var child = firstChild; child != null; child = childAfter(child)) {
      width = math.max(width, child.getMinIntrinsicWidth(height));
    }
    return width;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (childCount == 0) return 0;
    var width = 0.0;
    var maxChildWidth = 0.0;
    for (var child = firstChild; child != null; child = childAfter(child)) {
      final childWidth = child.getMaxIntrinsicWidth(double.infinity);
      width += childWidth;
      maxChildWidth = math.max(maxChildWidth, childWidth);
    }
    if (_isStretched) width = maxChildWidth * childCount;
    return width + _horizontalSpacing * (childCount - 1);
  }

  @override
  double computeMinIntrinsicHeight(double width) =>
      _intrinsicHeight(width, (child, childWidth) => child.getMinIntrinsicHeight(childWidth));

  @override
  double computeMaxIntrinsicHeight(double width) =>
      _intrinsicHeight(width, (child, childWidth) => child.getMaxIntrinsicHeight(childWidth));

  double _intrinsicHeight(double width, double Function(RenderBox, double) childHeight) {
    if (childCount == 0) return 0;
    if (computeMaxIntrinsicWidth(double.infinity) <= width) {
      var height = 0.0;
      for (var child = firstChild; child != null; child = childAfter(child)) {
        height = math.max(height, childHeight(child, child.getMaxIntrinsicWidth(double.infinity)));
      }
      return height;
    }
    var height = _stackedSpacing * (childCount - 1);
    for (var child = firstChild; child != null; child = childAfter(child)) {
      height += childHeight(child, width);
    }
    return height;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) =>
      _layout(constraints, ChildLayoutHelper.dryLayoutChild, shouldPosition: false);

  @override
  void performLayout() {
    size = _layout(constraints, ChildLayoutHelper.layoutChild, shouldPosition: true);
  }

  Size _layout(
    BoxConstraints constraints,
    ChildLayouter layoutChild, {
    required bool shouldPosition,
  }) {
    if (childCount == 0) return constraints.smallest;

    // * intrinsics, not a loose layout pass, so a child asking for infinite width still measures
    final naturalWidths = <double>[];
    var naturalRowWidth = _horizontalSpacing * (childCount - 1);
    var maxNaturalWidth = 0.0;
    for (var child = firstChild; child != null; child = childAfter(child)) {
      final naturalWidth = child.getMaxIntrinsicWidth(double.infinity);
      naturalWidths.add(naturalWidth);
      naturalRowWidth += naturalWidth;
      maxNaturalWidth = math.max(maxNaturalWidth, naturalWidth);
    }

    final available = constraints.maxWidth;
    final sharedWidth = (available - _horizontalSpacing * (childCount - 1)) / childCount;
    final isSharing = _isStretched && available.isFinite;
    final fitsInRow =
        !available.isFinite ||
        (isSharing ? maxNaturalWidth <= sharedWidth : naturalRowWidth <= available);

    if (fitsInRow) {
      var rowWidth = _horizontalSpacing * (childCount - 1);
      var rowHeight = 0.0;
      var index = 0;
      for (var child = firstChild; child != null; child = childAfter(child)) {
        final childWidth = isSharing ? sharedWidth : naturalWidths[index];
        final childSize = layoutChild(child, BoxConstraints.tightFor(width: childWidth));
        rowWidth += childSize.width;
        rowHeight = math.max(rowHeight, childSize.height);
        index += 1;
      }
      if (isSharing) {
        final sharedConstraints = BoxConstraints.tightFor(width: sharedWidth, height: rowHeight);
        for (var child = firstChild; child != null; child = childAfter(child)) {
          layoutChild(child, sharedConstraints);
        }
      }
      final width = available.isFinite ? available : rowWidth;
      if (shouldPosition) _positionRow(width: width, rowWidth: rowWidth, height: rowHeight);
      return constraints.constrain(Size(width, rowHeight));
    }

    final stackedConstraints = BoxConstraints.tightFor(width: available);
    var height = 0.0;
    for (var child = lastChild; child != null; child = childBefore(child)) {
      final childSize = layoutChild(child, stackedConstraints);
      if (shouldPosition) {
        (child.parentData! as _AdaptiveActionsParentData).offset = Offset(0, height);
      }
      height += childSize.height + _stackedSpacing;
    }
    return constraints.constrain(Size(available, height - _stackedSpacing));
  }

  void _positionRow({required double width, required double rowWidth, required double height}) {
    final isRightToLeft = _textDirection == TextDirection.rtl;
    var x = isRightToLeft ? rowWidth : width - rowWidth;
    for (var child = firstChild; child != null; child = childAfter(child)) {
      final childWidth = child.size.width;
      if (isRightToLeft) x -= childWidth;
      (child.parentData! as _AdaptiveActionsParentData).offset = Offset(
        x,
        (height - child.size.height) / 2,
      );
      x += isRightToLeft ? -_horizontalSpacing : childWidth + _horizontalSpacing;
    }
  }

  @override
  double? computeDryBaseline(BoxConstraints constraints, TextBaseline baseline) => null;

  @override
  void paint(PaintingContext context, Offset offset) => defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);
}
