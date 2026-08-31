const _rangeSeparator = "–";
const _listSeparator = ", ";
const _maxPageNumber = 9999;
const _maxRangeLength = 50;
final _partPattern = RegExp(r"[,;]");
final _numberPattern = RegExp(r"\d+");

extension PageNumberExtensions on List<int> {
  String toPageLabel() {
    if (isEmpty) return "";
    final ordered = [...this]..sort();
    if (ordered.length == 1) return "${ordered.first}";
    if (ordered.last - ordered.first == ordered.length - 1) {
      return "${ordered.first}$_rangeSeparator${ordered.last}";
    }
    return ordered.join(_listSeparator);
  }
}

extension PageNumberTextExtensions on String {
  List<int> toPageNumbers() {
    final numbers = <int>{};
    for (final part in split(_partPattern)) {
      final parsed = [
        for (final match in _numberPattern.allMatches(part))
          int.tryParse(match.group(0) ?? "") ?? 0,
      ].where((page) => page > 0 && page <= _maxPageNumber).toList();
      if (parsed.isEmpty) continue;
      final first = parsed.first;
      final last = parsed.last;
      if (parsed.length >= 2 && first < last && last - first < _maxRangeLength) {
        for (var page = first; page <= last; page++) {
          numbers.add(page);
        }
        continue;
      }
      numbers.addAll(parsed);
    }
    return numbers.toList()..sort();
  }
}
