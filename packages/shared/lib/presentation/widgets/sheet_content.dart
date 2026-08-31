import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';

class const SheetContent({
  required final List<Widget> _children,
  final CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.stretch,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Spacing.s, Spacing.xs, Spacing.s, Spacing.s),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: _crossAxisAlignment,
          children: _children,
        ),
      ),
    );
  }
}
