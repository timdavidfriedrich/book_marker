import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _glyphSize = 20.0;
const _shape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusXl)),
);

class const ProviderButton({
  required final IconData _glyph,
  required final String _label,
  required final VoidCallback? _onPressed,
  final bool _isOutlined = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // * the button is full width but its label is not; min plus Flexible lets
      // * a long translation shrink instead of overflowing
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(_glyph, size: _glyphSize),
        const SizedBox(width: Spacing.s),
        Flexible(child: Text(_label, overflow: TextOverflow.ellipsis)),
      ],
    );
    if (_isOutlined) {
      return OutlinedButton(
        onPressed: _onPressed,
        style: OutlinedButton.styleFrom(shape: _shape),
        child: child,
      );
    }
    // * ink rather than the app's amber primary: these screens are about
    // * securing data, and inverseSurface flips correctly in dark mode
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
