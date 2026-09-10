import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _glyphSize = 20.0;
const _spinnerSize = 19.0;
const _spinnerStroke = 2.0;
const _shape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusXl)),
);

// * the ink button the Sicherung designs specify, rather than the app's amber
// * primary. inverseSurface is exactly the design's ink and inverts correctly
// * in dark mode, and the disabled pair matches the specified sand-on-muted.
class const InkActionButton({
  required final String _label,
  required final VoidCallback? _onPressed,
  final IconData? _glyph,
  final bool _isBusy = false,
  final bool _isOutlined = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final glyph = _glyph;
    final label = Text(_label, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center);
    final leading = _isBusy
        ? SizedBox.square(
            dimension: _spinnerSize,
            child: CircularProgressIndicator(
              strokeWidth: _spinnerStroke,
              color: _isOutlined ? context.c.onSurface : context.c.onInverseSurface,
            ),
          )
        : (glyph == null ? null : Icon(glyph, size: _glyphSize));
    // * Flexible only belongs inside the Row; a button wraps a lone child in an
    // * Align, where it would assert
    final child = leading == null
        ? label
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              leading,
              const SizedBox(width: Spacing.s),
              Flexible(child: label),
            ],
          );
    if (_isOutlined) {
      return OutlinedButton(
        onPressed: _onPressed,
        style: OutlinedButton.styleFrom(shape: _shape),
        child: child,
      );
    }
    return FilledButton(
      onPressed: _onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: context.c.inverseSurface,
        foregroundColor: context.c.onInverseSurface,
        disabledBackgroundColor: context.c.surfaceContainerHigh,
        disabledForegroundColor: context.c.onSurfaceVariant,
        shape: _shape,
      ),
      child: child,
    );
  }
}
