import 'package:core/theme/accent_color.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'quote_theme.mapper.dart';

@MappableClass()
class const QuoteTheme({
  required final String id,
  required final String name,
  required final DateTime createdAt,
  final AccentColor? accent,
}) with QuoteThemeMappable;
