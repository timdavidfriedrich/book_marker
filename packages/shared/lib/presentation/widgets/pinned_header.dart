import 'package:flutter/material.dart';

class const PinnedHeader({
  required final double _height,
  required final Widget _child,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _PinnedHeaderDelegate(height: _height, child: _child),
    );
  }
}

class const _PinnedHeaderDelegate({
  required final double height,
  required final Widget child,
}) extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) =>
      SizedBox(height: height, child: child);

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(_PinnedHeaderDelegate oldDelegate) =>
      oldDelegate.height != height || oldDelegate.child != child;
}
