import 'package:core/theme/accent_color.dart';

const _accentAmber = "amber";
const _accentTeal = "teal";
const _accentCoral = "coral";
const _accentSand = "sand";

extension AccentColorValueMappers on String {
  AccentColor? toAccentColor() => switch (this) {
    _accentAmber => AccentColor.amber,
    _accentTeal => AccentColor.teal,
    _accentCoral => AccentColor.coral,
    _accentSand => AccentColor.sand,
    _ => null,
  };
}

extension AccentColorMappers on AccentColor {
  String get value => switch (this) {
    AccentColor.amber => _accentAmber,
    AccentColor.teal => _accentTeal,
    AccentColor.coral => _accentCoral,
    AccentColor.sand => _accentSand,
  };
}
