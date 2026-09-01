import 'package:core/theme/accent_color.dart';
import 'package:core/theme/collection_symbol.dart';

const _accentSeed = 31;
const _symbolSeed = 131;
const _hashMask = 0x7fffffff;

abstract final class MarkDefaults {
  const MarkDefaults._();

  static AccentColor accentFor(Iterable<AccentColor> used) => _leastUsed(AccentColor.values, used);

  static CollectionSymbol symbolFor(Iterable<CollectionSymbol> used) =>
      _leastUsed(CollectionSymbol.values, used);

  static AccentColor accentForKey(String key) =>
      AccentColor.values[_hash(key, _accentSeed) % AccentColor.values.length];

  static CollectionSymbol symbolForKey(String key) =>
      CollectionSymbol.values[_hash(key, _symbolSeed) % CollectionSymbol.values.length];

  static T _leastUsed<T>(List<T> values, Iterable<T> used) {
    final counts = {for (final value in values) value: 0};
    for (final value in used) {
      counts.update(value, (count) => count + 1, ifAbsent: () => 1);
    }
    return values.reduce((best, value) => counts[value]! < counts[best]! ? value : best);
  }

  static int _hash(String key, int seed) {
    var hash = 0;
    for (final unit in key.codeUnits) {
      hash = (hash * seed + unit) & _hashMask;
    }
    return hash;
  }
}
