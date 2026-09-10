import 'package:core/security/recovery_code.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _columns = 2;
const _chipHeight = 46.0;
const _chipRadius = 14.0;
const _codeLetterSpacing = 0.1;
const _codeFontSize = 18.0;
const _aspectDivisor = 2.6;

class const RecoveryCodeGrid({
  required final List<String> _groups,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.s),
      decoration: BoxDecoration(
        color: context.c.surfaceContainer,
        borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusXxl)),
      ),
      child: GridView.count(
        crossAxisCount: _columns,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: Spacing.xxs,
        crossAxisSpacing: Spacing.xxs,
        childAspectRatio: RecoveryCode.groupCount / _aspectDivisor,
        children: [
          for (final group in _groups) _CodeChip(text: group),
        ],
      ),
    );
  }
}

class const _CodeChip({
  required final String _text,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _chipHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.palette.paperFill,
        borderRadius: const BorderRadius.all(Radius.circular(_chipRadius)),
      ),
      child: Text(
        _text,
        style: TextStyle(
          fontFamily: "monospace",
          fontFamilyFallback: const ["Menlo", "Roboto Mono", "Courier New"],
          fontSize: _codeFontSize,
          fontWeight: FontWeight.w600,
          letterSpacing: _codeFontSize * _codeLetterSpacing,
          color: context.palette.paperText,
        ),
      ),
    );
  }
}
