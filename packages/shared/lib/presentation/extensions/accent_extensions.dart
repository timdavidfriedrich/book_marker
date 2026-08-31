import 'package:core/theme/theme_extensions.dart';

const _hashPrime = 31;
const _hashMask = 0x7fffffff;

extension AccentKeyExtensions on String {
  AccentColor get accent {
    var hash = 0;
    for (final unit in codeUnits) {
      hash = (hash * _hashPrime + unit) & _hashMask;
    }
    return AccentColor.autoValues[hash % AccentColor.autoValues.length];
  }
}
