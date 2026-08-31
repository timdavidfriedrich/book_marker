import 'package:flutter/material.dart';

class const FloatingHeader({
  required final double _height,
  required final Widget _child,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      primary: false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: _height,
      flexibleSpace: _child,
    );
  }
}
