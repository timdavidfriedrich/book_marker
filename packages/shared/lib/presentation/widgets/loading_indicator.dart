import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const LoadingIndicator({
  final String? _message,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (_message case final String message) ...[
            const SizedBox(height: Spacing.m),
            Text(message, textAlign: TextAlign.center, style: context.typography.label),
          ],
        ],
      ),
    );
  }
}
