import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _trackPadding = 4.0;
const _segmentHeight = 44.0;
const _labelFontSize = 14.0;
const segmentedToggleHeight = _segmentHeight + _trackPadding * 2;

class const SegmentedToggle({
  required final List<String> _labels,
  required final int _selectedIndex,
  required final ValueChanged<int> _onChanged,
  final bool _isExpanded = true,
  final Color? _trackColor,
  final Color? _activeColor,
  final Color? _activeTextColor,
  final Color? _inactiveTextColor,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trackColor = _trackColor ?? context.c.surfaceContainerHigh;
    final activeColor = _activeColor ?? context.c.inverseSurface;
    final activeTextColor = _activeTextColor ?? context.c.onInverseSurface;
    final inactiveTextColor = _inactiveTextColor ?? context.c.onSurfaceVariant;
    return Container(
      height: segmentedToggleHeight,
      padding: const EdgeInsets.all(_trackPadding),
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: _isExpanded ? MainAxisSize.max : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var index = 0; index < _labels.length; index++)
            _Segment(
              label: _labels[index],
              isExpanded: _isExpanded,
              isSelected: index == _selectedIndex,
              activeColor: activeColor,
              activeTextColor: activeTextColor,
              inactiveTextColor: inactiveTextColor,
              onTap: () => _onChanged(index),
            ),
        ],
      ),
    );
  }
}

class const _Segment({
  required final String _label,
  required final bool _isExpanded,
  required final bool _isSelected,
  required final Color _activeColor,
  required final Color _activeTextColor,
  required final Color _inactiveTextColor,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final segment = InkTapBox(
      onTap: _onTap,
      color: _isSelected ? _activeColor : Colors.transparent,
      radius: Spacing.radiusFull,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
      // * widthFactor keeps the label measurable while the row is only as wide as its content
      child: Align(
        widthFactor: 1,
        child: Text(
          _label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.t.labelMedium?.copyWith(
            color: _isSelected ? _activeTextColor : _inactiveTextColor,
            fontSize: _labelFontSize,
          ),
        ),
      ),
    );
    return _isExpanded ? Expanded(child: segment) : segment;
  }
}
