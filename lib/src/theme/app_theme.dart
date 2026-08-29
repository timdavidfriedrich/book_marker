import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

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

const _amberSolid = Color(0xFFFFB627);
const _tealSolid = Color(0xFF157A6E);
const _coralSolid = Color(0xFFEE5B3F);

const _errorColor = Color(0xFFB23A22);

const _darkSurface = Color(0xFF17120E);
const _darkSurfaceLow = Color(0xFF211A14);
const _darkSurfaceHigh = Color(0xFF2C241C);
const _darkOnSurface = Color(0xFFEDE3D2);
const _darkOnSurfaceVariant = Color(0xFF9A8E7B);
const _darkOutline = Color(0xFF3C332A);

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

const _palette = AppPalette(
  amber: _amber,
  teal: _teal,
  coral: _coral,
  sand: _sand,
  sky: _sky,
  paperFill: _paperCard,
  paperText: _paperText,
  paperTextFaint: _paperTextFaint,
);

const _typography = AppTypography(
  readingBody: TextStyle(fontFamily: _serif, fontSize: 17, height: 1.55, color: _paperText),
  readingQuote: TextStyle(fontFamily: _serif, fontSize: 17, height: 1.4, color: _paperText),
  readingQuoteItalic: TextStyle(
    fontFamily: _serif,
    fontSize: 17,
    height: 1.4,
    fontStyle: FontStyle.italic,
    color: _paperText,
  ),
  monoLabel: TextStyle(fontFamily: _mono, fontSize: 13, height: 1.35),
  monoLabelStrong: TextStyle(fontFamily: _mono, fontSize: 13, height: 1.35, fontWeight: FontWeight.w500),
  monoCaption: TextStyle(fontFamily: _mono, fontSize: 11.5, height: 1.3),
  monoBadge: TextStyle(fontFamily: _mono, fontSize: 12.5, fontWeight: FontWeight.w500),
);

const _statusLight = StatusColors(success: _tealSolid, warning: _amberSolid);

abstract final class AppTheme {
  const AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final colorScheme = isLight ? _lightScheme : _darkScheme;
    final textTheme = _textTheme(colorScheme.onSurface);
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      textTheme: textTheme,
      splashFactory: NoSplash.splashFactory,
      extensions: const [_palette, _typography, _statusLight],
      badgeTheme: BadgeThemeData(
        backgroundColor: _sky.solid,
        textColor: _sky.onSolid,
        textStyle: _typography.monoBadge.copyWith(fontSize: 10, height: 1),
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
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _creamRaised,
        modalBackgroundColor: _creamRaised,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: _outline,
        elevation: 0,
        modalElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(Spacing.radiusXxl)),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: _creamRaised,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusXl)),
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
        fillColor: isLight ? _sandField : _darkSurfaceLow,
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
        backgroundColor: _ink,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: _cream),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusM)),
        ),
      ),
      dividerTheme: const DividerThemeData(color: _outlineVariant, thickness: Spacing.borderWidthThin),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: _amberSolid.withValues(alpha: 0.4),
        cursorColor: colorScheme.primary,
        selectionHandleColor: colorScheme.primary,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: colorScheme.primary),
    );
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

  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: _amberSolid,
    onPrimary: _inkSoft,
    primaryContainer: Color(0xFF5A420F),
    onPrimaryContainer: Color(0xFFFFE7B8),
    secondary: _tealSolid,
    onSecondary: Color(0xFFF4FBF8),
    secondaryContainer: Color(0xFF124B44),
    onSecondaryContainer: Color(0xFFE4EFEC),
    tertiary: _coralSolid,
    onTertiary: Color(0xFFFFF4EE),
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
    outlineVariant: Color(0xFF2C241C),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: _cream,
    onInverseSurface: _ink,
    inversePrimary: _amberSolid,
    surfaceTint: _darkSurface,
  );

  static TextTheme _textTheme(Color onSurface) {
    const base = TextTheme(
      displayLarge: TextStyle(fontFamily: _display, fontWeight: FontWeight.w800, fontSize: 57, height: 1.05),
      displayMedium: TextStyle(fontFamily: _display, fontWeight: FontWeight.w800, fontSize: 45, height: 1.05),
      displaySmall: TextStyle(fontFamily: _display, fontWeight: FontWeight.w800, fontSize: 34, height: 1.05),
      headlineLarge: TextStyle(fontFamily: _display, fontWeight: FontWeight.w700, fontSize: 30, height: 1.1),
      headlineMedium: TextStyle(fontFamily: _display, fontWeight: FontWeight.w700, fontSize: 26, height: 1.1),
      headlineSmall: TextStyle(fontFamily: _display, fontWeight: FontWeight.w700, fontSize: 22, height: 1.15),
      titleLarge: TextStyle(fontFamily: _display, fontWeight: FontWeight.w700, fontSize: 20, height: 1.2),
      titleMedium: TextStyle(fontFamily: _display, fontWeight: FontWeight.w600, fontSize: 16, height: 1.25),
      titleSmall: TextStyle(fontFamily: _display, fontWeight: FontWeight.w600, fontSize: 14, height: 1.25),
      bodyLarge: TextStyle(fontFamily: _sans, fontWeight: FontWeight.w400, fontSize: 16, height: 1.4),
      bodyMedium: TextStyle(fontFamily: _sans, fontWeight: FontWeight.w400, fontSize: 14, height: 1.4),
      bodySmall: TextStyle(fontFamily: _sans, fontWeight: FontWeight.w400, fontSize: 12.5, height: 1.4),
      labelLarge: TextStyle(fontFamily: _display, fontWeight: FontWeight.w700, fontSize: 15, height: 1.1),
      labelMedium: TextStyle(fontFamily: _sans, fontWeight: FontWeight.w500, fontSize: 13, height: 1.1),
      labelSmall: TextStyle(fontFamily: _sans, fontWeight: FontWeight.w500, fontSize: 11, height: 1.1),
    );
    return base.apply(bodyColor: onSurface, displayColor: onSurface);
  }
}
