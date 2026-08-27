import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _markerSize = 30.0;
const _captureSize = 64.0;
const _captureDotSize = 28.0;

class const NavigationShellContainer({
  required final StatefulNavigationShell _navigationShell,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigationShell,
      bottomNavigationBar: _BottomBar(navigationShell: _navigationShell),
    );
  }
}

class const _BottomBar({
  required final StatefulNavigationShell _navigationShell,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final index = _navigationShell.currentIndex;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.xxl, vertical: Spacing.xs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _TabItem(
              label: context.s.navLibraryLabel,
              active: index == 0,
              rounded: true,
              onTap: () => _navigationShell.goBranch(0),
            ),
            _CaptureButton(onTap: context.pushCapture),
            _TabItem(
              label: context.s.navThemesLabel,
              active: index == 1,
              rounded: false,
              onTap: () => _navigationShell.goBranch(1),
            ),
          ],
        ),
      ),
    );
  }
}

class const _TabItem({
  required final String _label,
  required final bool _active,
  required final bool _rounded,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: _onTap,
      radius: Spacing.radiusM,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xs),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _markerSize,
            height: _markerSize,
            decoration: BoxDecoration(
              color: _active ? context.c.primary : context.c.surfaceContainerHighest,
              shape: _rounded ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: _rounded ? BorderRadius.circular(Spacing.radiusS) : null,
            ),
          ),
          const SizedBox(height: Spacing.xxs),
          Text(
            _label,
            style: (_active ? context.typography.monoLabelStrong : context.typography.monoLabel)
                .copyWith(color: _active ? context.c.onSurface : context.c.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class const _CaptureButton({
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: _onTap,
      circle: true,
      color: context.c.inverseSurface,
      child: SizedBox(
        width: _captureSize,
        height: _captureSize,
        child: Center(
          child: Container(
            width: _captureDotSize,
            height: _captureDotSize,
            decoration: BoxDecoration(color: context.c.primary, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}
