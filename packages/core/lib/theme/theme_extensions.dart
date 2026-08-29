import 'package:core/theme/accent_color.dart';
import 'package:flutter/material.dart';

export 'package:core/theme/accent_color.dart';

class const AccentSwatch({
  required final Color fill,
  required final Color solid,
  required final Color onSolid,
  required final Color onFill,
  required final Color onFillVariant,
}) {
  AccentSwatch lerp(AccentSwatch other, double t) {
    return AccentSwatch(
      fill: Color.lerp(fill, other.fill, t)!,
      solid: Color.lerp(solid, other.solid, t)!,
      onSolid: Color.lerp(onSolid, other.onSolid, t)!,
      onFill: Color.lerp(onFill, other.onFill, t)!,
      onFillVariant: Color.lerp(onFillVariant, other.onFillVariant, t)!,
    );
  }
}

class const AppPalette({
  required final AccentSwatch amber,
  required final AccentSwatch teal,
  required final AccentSwatch coral,
  required final AccentSwatch sand,
  required final AccentSwatch sky,
  required final Color paperFill,
  required final Color paperText,
  required final Color paperTextFaint,
}) extends ThemeExtension<AppPalette> {
  AccentSwatch resolve(AccentColor accent) => switch (accent) {
    AccentColor.amber => amber,
    AccentColor.teal => teal,
    AccentColor.coral => coral,
    AccentColor.sand => sand,
  };

  @override
  AppPalette copyWith({
    AccentSwatch? amber,
    AccentSwatch? teal,
    AccentSwatch? coral,
    AccentSwatch? sand,
    AccentSwatch? sky,
    Color? paperFill,
    Color? paperText,
    Color? paperTextFaint,
  }) {
    return AppPalette(
      amber: amber ?? this.amber,
      teal: teal ?? this.teal,
      coral: coral ?? this.coral,
      sand: sand ?? this.sand,
      sky: sky ?? this.sky,
      paperFill: paperFill ?? this.paperFill,
      paperText: paperText ?? this.paperText,
      paperTextFaint: paperTextFaint ?? this.paperTextFaint,
    );
  }

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      amber: amber.lerp(other.amber, t),
      teal: teal.lerp(other.teal, t),
      coral: coral.lerp(other.coral, t),
      sand: sand.lerp(other.sand, t),
      sky: sky.lerp(other.sky, t),
      paperFill: Color.lerp(paperFill, other.paperFill, t)!,
      paperText: Color.lerp(paperText, other.paperText, t)!,
      paperTextFaint: Color.lerp(paperTextFaint, other.paperTextFaint, t)!,
    );
  }
}

class const AppTypography({
  required final TextStyle readingBody,
  required final TextStyle readingQuote,
  required final TextStyle readingQuoteItalic,
  required final TextStyle monoLabel,
  required final TextStyle monoLabelStrong,
  required final TextStyle monoCaption,
  required final TextStyle monoBadge,
}) extends ThemeExtension<AppTypography> {
  @override
  AppTypography copyWith({
    TextStyle? readingBody,
    TextStyle? readingQuote,
    TextStyle? readingQuoteItalic,
    TextStyle? monoLabel,
    TextStyle? monoLabelStrong,
    TextStyle? monoCaption,
    TextStyle? monoBadge,
  }) {
    return AppTypography(
      readingBody: readingBody ?? this.readingBody,
      readingQuote: readingQuote ?? this.readingQuote,
      readingQuoteItalic: readingQuoteItalic ?? this.readingQuoteItalic,
      monoLabel: monoLabel ?? this.monoLabel,
      monoLabelStrong: monoLabelStrong ?? this.monoLabelStrong,
      monoCaption: monoCaption ?? this.monoCaption,
      monoBadge: monoBadge ?? this.monoBadge,
    );
  }

  @override
  AppTypography lerp(AppTypography? other, double t) {
    if (other == null) return this;
    return AppTypography(
      readingBody: TextStyle.lerp(readingBody, other.readingBody, t)!,
      readingQuote: TextStyle.lerp(readingQuote, other.readingQuote, t)!,
      readingQuoteItalic: TextStyle.lerp(readingQuoteItalic, other.readingQuoteItalic, t)!,
      monoLabel: TextStyle.lerp(monoLabel, other.monoLabel, t)!,
      monoLabelStrong: TextStyle.lerp(monoLabelStrong, other.monoLabelStrong, t)!,
      monoCaption: TextStyle.lerp(monoCaption, other.monoCaption, t)!,
      monoBadge: TextStyle.lerp(monoBadge, other.monoBadge, t)!,
    );
  }
}

class const StatusColors({
  required final Color success,
  required final Color warning,
}) extends ThemeExtension<StatusColors> {
  @override
  StatusColors copyWith({Color? success, Color? warning}) {
    return StatusColors(success: success ?? this.success, warning: warning ?? this.warning);
  }

  @override
  StatusColors lerp(StatusColors? other, double t) {
    if (other == null) return this;
    return StatusColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}
