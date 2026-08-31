import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';

class const SheetContent({
  required final List<Widget> _children,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.xs, Spacing.l, Spacing.s),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _children,
        ),
      ),
    );
  }
}
