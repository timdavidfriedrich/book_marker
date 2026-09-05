import 'dart:io';

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _remoteScheme = "http";
const _monogramSizeRatio = 0.44;

class const BookCover({
  required final String _title,
  final String? _image,
  final double _width = 48,
  final double _height = 64,
  final double _radius = Spacing.radiusM,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final placeholder = _CoverPlaceholder(title: _title, width: _width);
    return ClipRRect(
      borderRadius: BorderRadius.circular(_radius),
      child: SizedBox(
        width: _width,
        height: _height,
        child: switch (_image) {
          null => placeholder,
          final image when image.startsWith(_remoteScheme) => Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => placeholder,
          ),
          final image => Image.file(
            File(image),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => placeholder,
          ),
        },
      ),
    );
  }
}

class const _CoverPlaceholder({
  required final String _title,
  required final double _width,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trimmed = _title.trim();
    return ColoredBox(
      color: context.c.surfaceContainerHighest,
      child: Center(
        child: Text(
          trimmed.isEmpty ? "" : trimmed.substring(0, 1).toUpperCase(),
          style: context.t.headlineSmall?.copyWith(
            color: context.c.onSurfaceVariant,
            fontSize: _width * _monogramSizeRatio,
          ),
        ),
      ),
    );
  }
}
