import 'package:flutter/material.dart';

// * a resting size that equals the minimum dismisses on the slightest drag, so the sheet keeps
// * a travel distance below its resting size and snaps back when the drag stays inside it
const _dismissTravel = 0.2;
const _smallestDismissSize = 0.2;

class const DragDismissSheet({
  required final double _restingSize,
  required final double _expandedSize,
  required final ScrollableWidgetBuilder _builder,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dismissSize = (_restingSize - _dismissTravel).clamp(_smallestDismissSize, _restingSize);
    final canSnapBack = dismissSize < _restingSize && _restingSize < _expandedSize;
    return DraggableScrollableSheet(
      initialChildSize: _restingSize,
      minChildSize: dismissSize,
      maxChildSize: _expandedSize,
      snap: true,
      snapSizes: canSnapBack ? [_restingSize] : null,
      builder: _builder,
    );
  }
}
