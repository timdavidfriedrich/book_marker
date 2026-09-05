import 'dart:math';

import 'package:core/theme/spacing.dart';
import 'package:flutter/painting.dart';

abstract final class CornerRadii {
  const CornerRadii._();

  static double nested(double outer, double inset) => max(outer - inset, Spacing.radiusXs);

  static BorderRadiusGeometry grouped({
    required double outer,
    required bool isFirst,
    required bool isLast,
    Axis axis = Axis.vertical,
  }) {
    const joined = Radius.circular(Spacing.radiusXs);
    final open = Radius.circular(outer);
    final start = isFirst ? open : joined;
    final end = isLast ? open : joined;
    return switch (axis) {
      Axis.vertical => BorderRadius.vertical(top: start, bottom: end),
      Axis.horizontal => BorderRadiusDirectional.horizontal(start: start, end: end),
    };
  }
}
