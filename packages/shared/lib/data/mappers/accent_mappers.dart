import 'package:core/theme/accent_color.dart';

extension AccentColorValueMappers on String {
  AccentColor? toAccentColor() => AccentColor.values.asNameMap()[this];
}

extension AccentColorMappers on AccentColor {
  String get value => name;
}
