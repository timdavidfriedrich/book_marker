import 'dart:async';

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/loading_indicator.dart';

const _indicatorDelay = Duration(milliseconds: 150);

class const LoadingScreen({
  final String? _message,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final showsIndicator = useState(false);
    useEffect(() {
      final timer = Timer(_indicatorDelay, () => showsIndicator.value = true);
      return timer.cancel;
    }, const []);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.layout.pageMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: Spacing.s),
            Align(
              alignment: Alignment.centerLeft,
              child: CircleIconButton(
                icon: Icons.arrow_back,
                tooltip: context.s.back,
                onPressed: context.closeScreen,
              ),
            ),
            Expanded(
              child: showsIndicator.value
                  ? LoadingIndicator(message: _message)
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
