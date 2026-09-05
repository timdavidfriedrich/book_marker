import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _handleWidth = 44.0;
const _handleHeight = 5.0;

class const SheetDragHandle({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: _handleWidth,
        height: _handleHeight,
        decoration: BoxDecoration(
          color: context.c.outline,
          borderRadius: BorderRadius.circular(Spacing.radiusFull),
        ),
      ),
    );
  }
}
