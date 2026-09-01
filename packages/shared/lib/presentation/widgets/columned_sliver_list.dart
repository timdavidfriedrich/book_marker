import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';

class const ColumnedSliverList({
  required final int _itemCount,
  required final int _columns,
  required final IndexedWidgetBuilder _itemBuilder,
  final double _spacing = Spacing.m,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (_columns <= 1) {
      return SliverList.separated(
        itemCount: _itemCount,
        separatorBuilder: (context, index) => SizedBox(height: _spacing),
        itemBuilder: _itemBuilder,
      );
    }
    final rowCount = (_itemCount + _columns - 1) ~/ _columns;
    return SliverList.separated(
      itemCount: rowCount,
      separatorBuilder: (context, index) => SizedBox(height: _spacing),
      itemBuilder: (context, row) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var column = 0; column < _columns; column++) ...[
            if (column > 0) SizedBox(width: _spacing),
            Expanded(
              child: switch (row * _columns + column) {
                final index when index < _itemCount => _itemBuilder(context, index),
                _ => const SizedBox.shrink(),
              },
            ),
          ],
        ],
      ),
    );
  }
}
