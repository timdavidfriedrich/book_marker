import 'package:core/theme/screen_layout.dart';
import 'package:core/theme/spacing.dart';

const _landscapeSheetFraction = 0.94;

extension ScreenLayoutExtensions on ScreenLayout {
  double get pageMargin => switch (this) {
    ScreenLayout.phonePortrait => Spacing.l,
    ScreenLayout.phoneLandscape => Spacing.xl,
    ScreenLayout.tabletPortrait => Spacing.xxl,
    ScreenLayout.tabletLandscape => Spacing.xxxl,
  };

  // * cards grow in height with their content, so they are laid out in columns of equal width
  int get cardColumns => switch (this) {
    ScreenLayout.phonePortrait => 1,
    ScreenLayout.phoneLandscape => 2,
    ScreenLayout.tabletPortrait => 2,
    ScreenLayout.tabletLandscape => 3,
  };

  int get tileColumns => switch (this) {
    ScreenLayout.phonePortrait => 2,
    ScreenLayout.phoneLandscape => 4,
    ScreenLayout.tabletPortrait => 3,
    ScreenLayout.tabletLandscape => 5,
  };

  double get tileAspectRatio => isLandscape ? 1.1 : 0.92;

  // * a half sheet leaves nothing readable in a landscape viewport
  double sheetSize(double portraitFraction) =>
      isLandscape ? _landscapeSheetFraction : portraitFraction;
}
