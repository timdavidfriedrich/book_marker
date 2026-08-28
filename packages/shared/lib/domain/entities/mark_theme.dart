import 'package:core/theme/accent_color.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'mark_theme.mapper.dart';

@MappableClass()
class const MarkTheme({
  required final String id,
  required final String name,
  required final DateTime createdAt,
  final AccentColor? accent,
}) with MarkThemeMappable;
