import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

class const BarcodeScannerScreen({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(MobileScannerController.new);
    final hasPopped = useRef(false);

    useEffect(() => controller.dispose, [controller]);

    return Scaffold(
      appBar: AppBar(title: Text(context.s.barcodeScannerTitle)),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              if (hasPopped.value) return;
              final code = capture.barcodes
                  .map((barcode) => barcode.rawValue)
                  .firstWhere((value) => value != null, orElse: () => null);
              if (code == null) return;
              hasPopped.value = true;
              context.closeScreenWithResult(code);
            },
          ),
          Positioned(
            bottom: Spacing.xxl,
            left: Spacing.l,
            right: Spacing.l,
            child: Text(
              context.s.barcodeScannerHint,
              textAlign: TextAlign.center,
              style: context.t.titleMedium?.copyWith(color: context.c.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
