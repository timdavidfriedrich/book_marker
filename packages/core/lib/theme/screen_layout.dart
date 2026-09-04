import 'dart:ui';

import 'package:core/theme/spacing.dart';

enum ScreenLayout {
  phonePortrait,
  phoneLandscape,
  tabletPortrait,
  tabletLandscape;

  static ScreenLayout of(Size size) {
    final isTablet = size.shortestSide >= Spacing.tabletBreakpoint;
    final isLandscape = size.width > size.height;
    return switch ((isTablet, isLandscape)) {
      (false, false) => phonePortrait,
      (false, true) => phoneLandscape,
      (true, false) => tabletPortrait,
      (true, true) => tabletLandscape,
    };
  }

  bool get isTablet => this == tabletPortrait || this == tabletLandscape;

  bool get isLandscape => this == phoneLandscape || this == tabletLandscape;

  bool get isWide => this != phonePortrait;
}
