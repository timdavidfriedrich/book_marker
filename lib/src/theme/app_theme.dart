import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _display = "Bricolage Grotesque";
const _sans = "DM Sans";
const _mono = "DM Mono";
const _serif = "Newsreader";

const _cream = Color(0xFFFFF4E2);
const _creamRaised = Color(0xFFFDF6E9);
const _paperCard = Color(0xFFFBF0DC);
const _sandContainer = Color(0xFFF5E9D3);
const _sandField = Color(0xFFF0E4D0);
const _sandFieldHigh = Color(0xFFE9DCC6);
const _ink = Color(0xFF1C1613);
const _inkSoft = Color(0xFF241D12);
const _mutedBrown = Color(0xFF6E6252);
const _outline = Color(0xFFC9BCA5);
const _outlineVariant = Color(0xFFDED2BC);

const _paperText = Color(0xFF241D12);
const _paperTextFaint = Color(0xFF9A8B70);
const _paperCardHigh = Color(0xFFFFFBF0);
const _paperTextHigh = Color(0xFF0F0B06);
const _paperTextFaintHigh = Color(0xFF6B5E48);

const _amberSolid = Color(0xFFFFB627);
const _tealSolid = Color(0xFF157A6E);
const _coralSolid = Color(0xFFEE5B3F);

const _errorColor = Color(0xFFB23A22);

const _darkSurface = Color(0xFF17120E);
const _darkSurfaceLow = Color(0xFF211A14);
const _darkSurfaceHigh = Color(0xFF2C241C);
const _darkOnSurface = Color(0xFFEDE3D2);
const _darkOnSurfaceVariant = Color(0xFFB0A48E);
const _darkOutline = Color(0xFF52483C);

const _lightHighSurface = Color(0xFFFFFDF7);
const _lightHighInk = Color(0xFF0F0B08);
const _lightHighInkVariant = Color(0xFF3B3227);
const _lightHighOutline = Color(0xFF6B5F4C);
const _lightHighTeal = Color(0xFF0E5F55);
const _lightHighCoral = Color(0xFFC23A20);
const _lightHighError = Color(0xFF8E2A14);

const _darkHighSurface = Color(0xFF0A0705);
const _darkHighOnSurface = Color(0xFFFFFBF2);
const _darkHighOnSurfaceVariant = Color(0xFFD8CDB8);
const _darkHighOutline = Color(0xFF8C8070);
const _darkHighAmber = Color(0xFFFFC64D);
const _darkHighTeal = Color(0xFF4FCBB8);
const _darkHighCoral = Color(0xFFFF8F73);
const _darkHighError = Color(0xFFFFA893);

const _amber = AccentSwatch(
  fill: Color(0xFFFFE7B8),
  solid: _amberSolid,
  onSolid: Color(0xFF241D12),
  onFill: Color(0xFF241D12),
  onFillVariant: Color(0xFF8A6A2E),
);
const _teal = AccentSwatch(
  fill: Color(0xFFE4EFEC),
  solid: _tealSolid,
  onSolid: Color(0xFFF4FBF8),
  onFill: Color(0xFF16211E),
  onFillVariant: Color(0xFF4E7A72),
);
const _coral = AccentSwatch(
  fill: Color(0xFFFBDFD6),
  solid: _coralSolid,
  onSolid: Color(0xFFFFF4EE),
  onFill: Color(0xFF24160F),
  onFillVariant: Color(0xFF9B5A48),
);
const _sand = AccentSwatch(
  fill: Color(0xFFECE2CF),
  solid: _ink,
  onSolid: Color(0xFFF3EAD8),
  onFill: Color(0xFF241F17),
  onFillVariant: _mutedBrown,
);

const _sky = AccentSwatch(
  fill: Color(0xFFD9E8F5),
  solid: Color(0xFF3E7CB1),
  onSolid: Color(0xFFF3F8FC),
  onFill: Color(0xFF14283A),
  onFillVariant: Color(0xFF4E7290),
);

const _accentFillBlend = 0.82;
const _accentOnFillVariantBlend = 0.42;
const _accentOnSolidThreshold = 0.5;
const _accentOnSolidLight = Color(0xFFFFF6E9);

const _lightHighFillBlend = 0.88;
const _lightHighOnFillVariantBlend = 0.62;

const _darkFillBlend = 0.8;
const _darkOnFillBlend = 0.86;
const _darkOnFillVariantBlend = 0.55;
const _darkHighFillBlend = 0.87;
const _darkHighOnFillBlend = 0.94;
const _darkHighOnFillVariantBlend = 0.75;

// * a solid this dark disappears on a dark surface, so it is lifted before the swatch is derived
const _darkSolidMinLuminance = 0.03;
const _darkSolidLift = 0.72;

const _derivedAccents = <AccentColor, Color>{
  AccentColor.mint: Color(0xFF4FB49A),
  AccentColor.forest: Color(0xFF2E6B4F),
  AccentColor.olive: Color(0xFF6E7A32),
  AccentColor.ocean: Color(0xFF1F6F8B),
  AccentColor.indigo: Color(0xFF3B4A9E),
  AccentColor.violet: Color(0xFF6C5CE0),
  AccentColor.plum: Color(0xFF8E4585),
  AccentColor.rose: Color(0xFFD6547B),
  AccentColor.brick: Color(0xFF9E3B2E),
  AccentColor.rust: Color(0xFFB4551F),
  AccentColor.mustard: Color(0xFFD8A013),
  AccentColor.clay: Color(0xFFC08552),
  AccentColor.mauve: Color(0xFF9B7B9E),
  AccentColor.slate: Color(0xFF55606E),
  AccentColor.stone: Color(0xFF8A8072),
};

Color _onSolid(Color solid) =>
    solid.computeLuminance() > _accentOnSolidThreshold ? _inkSoft : _accentOnSolidLight;

AccentSwatch _derivedSwatch(Color solid) {
  return AccentSwatch(
    fill: Color.lerp(solid, _cream, _accentFillBlend)!,
    solid: solid,
    onSolid: _onSolid(solid),
    onFill: _inkSoft,
    onFillVariant: Color.lerp(solid, _ink, _accentOnFillVariantBlend)!,
  );
}

AccentSwatch _lightHighContrastSwatch(Color solid) {
  return AccentSwatch(
    fill: Color.lerp(solid, _paperCardHigh, _lightHighFillBlend)!,
    solid: solid,
    onSolid: _onSolid(solid),
    onFill: _lightHighInk,
    onFillVariant: Color.lerp(solid, _lightHighInk, _lightHighOnFillVariantBlend)!,
  );
}

Color _darkSolid(Color solid) => solid.computeLuminance() < _darkSolidMinLuminance
    ? Color.lerp(solid, _cream, _darkSolidLift)!
    : solid;

AccentSwatch _darkSwatch(Color solid) {
  final base = _darkSolid(solid);
  return AccentSwatch(
    fill: Color.lerp(base, _darkSurfaceLow, _darkFillBlend)!,
    solid: base,
    onSolid: _onSolid(base),
    onFill: Color.lerp(base, _cream, _darkOnFillBlend)!,
    onFillVariant: Color.lerp(base, _cream, _darkOnFillVariantBlend)!,
  );
}

AccentSwatch _darkHighContrastSwatch(Color solid) {
  final base = _darkSolid(solid);
  return AccentSwatch(
    fill: Color.lerp(base, _darkHighSurface, _darkHighFillBlend)!,
    solid: base,
    onSolid: _onSolid(base),
    onFill: Color.lerp(base, _darkHighOnSurface, _darkHighOnFillBlend)!,
    onFillVariant: Color.lerp(base, _darkHighOnSurface, _darkHighOnFillVariantBlend)!,
  );
}

final _lightAccents = <AccentColor, AccentSwatch>{
  AccentColor.amber: _amber,
  AccentColor.teal: _teal,
  AccentColor.coral: _coral,
  AccentColor.sand: _sand,
  AccentColor.sky: _sky,
  for (final entry in _derivedAccents.entries) entry.key: _derivedSwatch(entry.value),
};

Map<AccentColor, AccentSwatch> _accentsFrom(AccentSwatch Function(Color solid) build) => {
  for (final entry in _lightAccents.entries) entry.key: build(entry.value.solid),
};

final _lightPalette = AppPalette(
  accents: _lightAccents,
  paperFill: _paperCard,
  paperText: _paperText,
  paperTextFaint: _paperTextFaint,
);

final _lightHighContrastPalette = AppPalette(
  accents: _accentsFrom(_lightHighContrastSwatch),
  paperFill: _paperCardHigh,
  paperText: _paperTextHigh,
  paperTextFaint: _paperTextFaintHigh,
);

final _darkPalette = AppPalette(
  accents: _accentsFrom(_darkSwatch),
  paperFill: _paperCard,
  paperText: _paperText,
  paperTextFaint: _paperTextFaint,
);

final _darkHighContrastPalette = AppPalette(
  accents: _accentsFrom(_darkHighContrastSwatch),
  paperFill: _paperCardHigh,
  paperText: _paperTextHigh,
  paperTextFaint: _paperTextFaintHigh,
);

const _status = StatusColors(uncertain: _sky);

abstract final class AppTheme {
  const AppTheme._();

  static final ThemeData light = _build(Brightness.light, ContrastLevel.standard);
  static final ThemeData lightHighContrast = _build(Brightness.light, ContrastLevel.high);
  static final ThemeData dark = _build(Brightness.dark, ContrastLevel.standard);
  static final ThemeData darkHighContrast = _build(Brightness.dark, ContrastLevel.high);

  static ThemeData lightOf(ContrastLevel contrast) => switch (contrast) {
    ContrastLevel.standard => light,
    ContrastLevel.high => lightHighContrast,
  };

  static ThemeData darkOf(ContrastLevel contrast) => switch (contrast) {
    ContrastLevel.standard => dark,
    ContrastLevel.high => darkHighContrast,
  };

  static ThemeData _build(Brightness brightness, ContrastLevel contrast) {
    final isLight = brightness == Brightness.light;
    final colorScheme = _scheme(brightness, contrast);
    final palette = _palette(brightness, contrast);
    final textTheme = _textTheme(colorScheme.onSurface);
    final typography = _typography(colorScheme.onSurface);
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      textTheme: textTheme,
      splashFactory: NoSplash.splashFactory,
      extensions: [
        palette,
        typography,
        _status,
        AppContrast(level: contrast),
      ],
      badgeTheme: BadgeThemeData(
        backgroundColor: _sky.solid,
        textColor: _sky.onSolid,
        textStyle: typography.monoBadge.copyWith(fontSize: 10, height: 1),
        largeSize: 14,
        padding: const EdgeInsets.symmetric(horizontal: 3),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        foregroundColor: colorScheme.onSurface,
        systemOverlayStyle: isLight ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusXl)),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surfaceContainerLowest,
        modalBackgroundColor: colorScheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: colorScheme.outline,
        elevation: 0,
        modalElevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(Spacing.radiusXxl)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: Spacing.xl, vertical: Spacing.xl),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusXl)),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.bodyLarge,
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(colorScheme.surfaceContainerLowest),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          elevation: const WidgetStatePropertyAll(Spacing.elevationM),
          padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: Spacing.xs)),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusL)),
            ),
          ),
        ),
      ),
      menuButtonTheme: MenuButtonThemeData(
        style: MenuItemButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          textStyle: textTheme.bodyLarge,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.xs),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.primary.withValues(alpha: 0.4),
          textStyle: textTheme.labelLarge,
          minimumSize: const Size.fromHeight(56),
          padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
          shape: const StadiumBorder(),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.secondary,
          textStyle: const TextStyle(fontFamily: _mono, fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: const CircleBorder(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHigh,
        hintStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
        contentPadding: const EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.m),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusFull)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusFull)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusFull)),
          borderSide: BorderSide(color: colorScheme.primary, width: Spacing.borderWidthMedium),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onInverseSurface),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusM)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: Spacing.borderWidthThin,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: colorScheme.primary.withValues(alpha: 0.4),
        cursorColor: colorScheme.primary,
        selectionHandleColor: colorScheme.primary,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: colorScheme.primary),
    );
  }

  static AppPalette _palette(Brightness brightness, ContrastLevel contrast) {
    return switch ((brightness, contrast)) {
      (Brightness.light, ContrastLevel.standard) => _lightPalette,
      (Brightness.light, ContrastLevel.high) => _lightHighContrastPalette,
      (Brightness.dark, ContrastLevel.standard) => _darkPalette,
      (Brightness.dark, ContrastLevel.high) => _darkHighContrastPalette,
    };
  }

  static ColorScheme _scheme(Brightness brightness, ContrastLevel contrast) {
    return switch ((brightness, contrast)) {
      (Brightness.light, ContrastLevel.standard) => _lightScheme,
      (Brightness.light, ContrastLevel.high) => _lightHighContrastScheme,
      (Brightness.dark, ContrastLevel.standard) => _darkScheme,
      (Brightness.dark, ContrastLevel.high) => _darkHighContrastScheme,
    };
  }

  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: _amberSolid,
    onPrimary: _inkSoft,
    primaryContainer: Color(0xFFFFE7B8),
    onPrimaryContainer: _inkSoft,
    secondary: _tealSolid,
    onSecondary: Color(0xFFF4FBF8),
    secondaryContainer: Color(0xFFE4EFEC),
    onSecondaryContainer: Color(0xFF16211E),
    tertiary: _coralSolid,
    onTertiary: Color(0xFFFFF4EE),
    tertiaryContainer: Color(0xFFFBDFD6),
    onTertiaryContainer: Color(0xFF24160F),
    error: _errorColor,
    onError: Color(0xFFFFF4EE),
    errorContainer: Color(0xFFFBDFD6),
    onErrorContainer: Color(0xFF3A0E05),
    surface: _cream,
    onSurface: _ink,
    surfaceDim: Color(0xFFEDE0CB),
    surfaceBright: _creamRaised,
    surfaceContainerLowest: _creamRaised,
    surfaceContainerLow: _paperCard,
    surfaceContainer: _sandContainer,
    surfaceContainerHigh: _sandField,
    surfaceContainerHighest: _sandFieldHigh,
    onSurfaceVariant: _mutedBrown,
    outline: _outline,
    outlineVariant: _outlineVariant,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: _ink,
    onInverseSurface: _cream,
    inversePrimary: _amberSolid,
    surfaceTint: _cream,
  );

  static const ColorScheme _lightHighContrastScheme = ColorScheme(
    brightness: Brightness.light,
    primary: _amberSolid,
    onPrimary: _lightHighInk,
    primaryContainer: Color(0xFFFFDFA0),
    onPrimaryContainer: _lightHighInk,
    secondary: _lightHighTeal,
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFCFE3DE),
    onSecondaryContainer: Color(0xFF06211D),
    tertiary: _lightHighCoral,
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFAD3C6),
    onTertiaryContainer: Color(0xFF2B1006),
    error: _lightHighError,
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFAD3C6),
    onErrorContainer: Color(0xFF2B0704),
    surface: _lightHighSurface,
    onSurface: _lightHighInk,
    surfaceDim: Color(0xFFE0D2B8),
    surfaceBright: Color(0xFFFFFFFF),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFFFF9EC),
    surfaceContainer: Color(0xFFF6EBD6),
    surfaceContainerHigh: Color(0xFFEFE2C9),
    surfaceContainerHighest: Color(0xFFE5D6B9),
    onSurfaceVariant: _lightHighInkVariant,
    outline: _lightHighOutline,
    outlineVariant: Color(0xFFA2937A),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: _lightHighInk,
    onInverseSurface: Color(0xFFFFFDF7),
    inversePrimary: _amberSolid,
    surfaceTint: _lightHighSurface,
  );

  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: _amberSolid,
    onPrimary: _inkSoft,
    primaryContainer: Color(0xFF5A420F),
    onPrimaryContainer: Color(0xFFFFE7B8),
    secondary: Color(0xFF35A897),
    onSecondary: Color(0xFF04211D),
    secondaryContainer: Color(0xFF124B44),
    onSecondaryContainer: Color(0xFFE4EFEC),
    tertiary: Color(0xFFFF8A6B),
    onTertiary: Color(0xFF3A1207),
    tertiaryContainer: Color(0xFF5F2416),
    onTertiaryContainer: Color(0xFFFBDFD6),
    error: Color(0xFFF2907B),
    onError: Color(0xFF3A0E05),
    errorContainer: Color(0xFF5F2416),
    onErrorContainer: Color(0xFFFBDFD6),
    surface: _darkSurface,
    onSurface: _darkOnSurface,
    surfaceDim: _darkSurface,
    surfaceBright: _darkSurfaceHigh,
    surfaceContainerLowest: Color(0xFF120E0A),
    surfaceContainerLow: _darkSurfaceLow,
    surfaceContainer: _darkSurfaceLow,
    surfaceContainerHigh: _darkSurfaceHigh,
    surfaceContainerHighest: Color(0xFF362C22),
    onSurfaceVariant: _darkOnSurfaceVariant,
    outline: _darkOutline,
    outlineVariant: Color(0xFF3C332A),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: _cream,
    onInverseSurface: _ink,
    inversePrimary: _amberSolid,
    surfaceTint: _darkSurface,
  );

  static const ColorScheme _darkHighContrastScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: _darkHighAmber,
    onPrimary: Color(0xFF1A1409),
    primaryContainer: Color(0xFF6E5314),
    onPrimaryContainer: Color(0xFFFFF0CE),
    secondary: _darkHighTeal,
    onSecondary: Color(0xFF06231F),
    secondaryContainer: Color(0xFF175D54),
    onSecondaryContainer: Color(0xFFE9F7F4),
    tertiary: _darkHighCoral,
    onTertiary: Color(0xFF2B0C04),
    tertiaryContainer: Color(0xFF77301D),
    onTertiaryContainer: Color(0xFFFFEAE3),
    error: _darkHighError,
    onError: Color(0xFF2B0704),
    errorContainer: Color(0xFF77301D),
    onErrorContainer: Color(0xFFFFEAE3),
    surface: _darkHighSurface,
    onSurface: _darkHighOnSurface,
    surfaceDim: _darkHighSurface,
    surfaceBright: Color(0xFF362C21),
    surfaceContainerLowest: Color(0xFF000000),
    surfaceContainerLow: Color(0xFF16110C),
    surfaceContainer: Color(0xFF1E1811),
    surfaceContainerHigh: Color(0xFF2A2219),
    surfaceContainerHighest: Color(0xFF362C21),
    onSurfaceVariant: _darkHighOnSurfaceVariant,
    outline: _darkHighOutline,
    outlineVariant: Color(0xFF5C5245),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: _darkHighOnSurface,
    onInverseSurface: Color(0xFF0A0705),
    inversePrimary: _darkHighAmber,
    surfaceTint: _darkHighSurface,
  );

  static AppTypography _typography(Color onSurface) {
    return AppTypography(
      readingBody: TextStyle(fontFamily: _serif, fontSize: 17, height: 1.55, color: onSurface),
      readingQuote: TextStyle(fontFamily: _serif, fontSize: 17, height: 1.4, color: onSurface),
      readingQuoteItalic: TextStyle(
        fontFamily: _serif,
        fontSize: 17,
        height: 1.4,
        fontStyle: FontStyle.italic,
        color: onSurface,
      ),
      monoLabel: const TextStyle(fontFamily: _serif, fontSize: 13, height: 1.35),
      monoLabelStrong: const TextStyle(
        fontFamily: _serif,
        fontSize: 13,
        height: 1.35,
        fontWeight: FontWeight.w500,
      ),
      monoCaption: const TextStyle(fontFamily: _serif, fontSize: 11.5, height: 1.3),
      monoBadge: const TextStyle(fontFamily: _serif, fontSize: 12.5, fontWeight: FontWeight.w500),
    );
  }

  static TextTheme _textTheme(Color onSurface) {
    const base = TextTheme(
      displayLarge: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w800,
        fontSize: 57,
        height: 1.05,
      ),
      displayMedium: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w800,
        fontSize: 45,
        height: 1.05,
      ),
      displaySmall: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w800,
        fontSize: 34,
        height: 1.05,
      ),
      headlineLarge: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w700,
        fontSize: 30,
        height: 1.1,
      ),
      headlineMedium: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w700,
        fontSize: 26,
        height: 1.1,
      ),
      headlineSmall: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w700,
        fontSize: 22,
        height: 1.15,
      ),
      titleLarge: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        height: 1.2,
      ),
      titleMedium: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.25,
      ),
      titleSmall: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        height: 1.25,
      ),
      bodyLarge: TextStyle(
        fontFamily: _sans,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.4,
      ),
      bodyMedium: TextStyle(
        fontFamily: _sans,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.4,
      ),
      bodySmall: TextStyle(
        fontFamily: _sans,
        fontWeight: FontWeight.w400,
        fontSize: 12.5,
        height: 1.4,
      ),
      labelLarge: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w700,
        fontSize: 15,
        height: 1.1,
      ),
      labelMedium: TextStyle(
        fontFamily: _sans,
        fontWeight: FontWeight.w500,
        fontSize: 13,
        height: 1.1,
      ),
      labelSmall: TextStyle(
        fontFamily: _sans,
        fontWeight: FontWeight.w500,
        fontSize: 11,
        height: 1.1,
      ),
    );
    return base.apply(bodyColor: onSurface, displayColor: onSurface);
  }
}
