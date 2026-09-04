import 'package:core/theme/accent_color.dart';
import 'package:core/theme/contrast_level.dart';
import 'package:flutter/material.dart';

export 'package:core/theme/accent_color.dart';
export 'package:core/theme/contrast_level.dart';
export 'package:core/theme/screen_layout.dart';

const _lerpMidpoint = 0.5;

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
  required final Map<AccentColor, AccentSwatch> accents,
  required final Color paperFill,
  required final Color paperText,
  required final Color paperTextFaint,
}) extends ThemeExtension<AppPalette> {
  AccentSwatch resolve(AccentColor accent) => accents[accent] ?? accents.values.first;

  @override
  AppPalette copyWith({
    Map<AccentColor, AccentSwatch>? accents,
    Color? paperFill,
    Color? paperText,
    Color? paperTextFaint,
  }) {
    return AppPalette(
      accents: accents ?? this.accents,
      paperFill: paperFill ?? this.paperFill,
      paperText: paperText ?? this.paperText,
      paperTextFaint: paperTextFaint ?? this.paperTextFaint,
    );
  }

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      accents: {
        for (final entry in accents.entries)
          entry.key: entry.value.lerp(other.resolve(entry.key), t),
      },
      paperFill: Color.lerp(paperFill, other.paperFill, t)!,
      paperText: Color.lerp(paperText, other.paperText, t)!,
      paperTextFaint: Color.lerp(paperTextFaint, other.paperTextFaint, t)!,
    );
  }
}

class const AppTypography({
  required final TextStyle readingBody,
  required final TextStyle readingInput,
  required final TextStyle readingQuote,
  required final TextStyle readingQuoteItalic,
  required final TextStyle label,
  required final TextStyle labelStrong,
  required final TextStyle caption,
  required final TextStyle badge,
}) extends ThemeExtension<AppTypography> {
  @override
  AppTypography copyWith({
    TextStyle? readingBody,
    TextStyle? readingInput,
    TextStyle? readingQuote,
    TextStyle? readingQuoteItalic,
    TextStyle? label,
    TextStyle? labelStrong,
    TextStyle? caption,
    TextStyle? badge,
  }) {
    return AppTypography(
      readingBody: readingBody ?? this.readingBody,
      readingInput: readingInput ?? this.readingInput,
      readingQuote: readingQuote ?? this.readingQuote,
      readingQuoteItalic: readingQuoteItalic ?? this.readingQuoteItalic,
      label: label ?? this.label,
      labelStrong: labelStrong ?? this.labelStrong,
      caption: caption ?? this.caption,
      badge: badge ?? this.badge,
    );
  }

  @override
  AppTypography lerp(AppTypography? other, double t) {
    if (other == null) return this;
    return AppTypography(
      readingBody: TextStyle.lerp(readingBody, other.readingBody, t)!,
      readingInput: TextStyle.lerp(readingInput, other.readingInput, t)!,
      readingQuote: TextStyle.lerp(readingQuote, other.readingQuote, t)!,
      readingQuoteItalic: TextStyle.lerp(readingQuoteItalic, other.readingQuoteItalic, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      labelStrong: TextStyle.lerp(labelStrong, other.labelStrong, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      badge: TextStyle.lerp(badge, other.badge, t)!,
    );
  }
}

class const StatusColors({
  required final AccentSwatch uncertain,
}) extends ThemeExtension<StatusColors> {
  @override
  StatusColors copyWith({AccentSwatch? uncertain}) {
    return StatusColors(uncertain: uncertain ?? this.uncertain);
  }

  @override
  StatusColors lerp(StatusColors? other, double t) {
    if (other == null) return this;
    return StatusColors(uncertain: uncertain.lerp(other.uncertain, t));
  }
}

class const AppContrast({
  required final ContrastLevel level,
}) extends ThemeExtension<AppContrast> {
  @override
  AppContrast copyWith({ContrastLevel? level}) => AppContrast(level: level ?? this.level);

  @override
  AppContrast lerp(AppContrast? other, double t) => t < _lerpMidpoint ? this : (other ?? this);
}
