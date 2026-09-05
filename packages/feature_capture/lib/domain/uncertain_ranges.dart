import 'dart:math' as math;

// * an edit is read as one replaced span, so a range survives unless the edit reaches into it
List<(int, int)> remapUncertainRanges(
  List<(int, int)> ranges, {
  required String previous,
  required String next,
}) {
  if (ranges.isEmpty || previous == next) return ranges;
  final shortest = math.min(previous.length, next.length);
  var prefix = 0;
  while (prefix < shortest && previous.codeUnitAt(prefix) == next.codeUnitAt(prefix)) {
    prefix++;
  }
  var suffix = 0;
  while (suffix < shortest - prefix &&
      previous.codeUnitAt(previous.length - 1 - suffix) ==
          next.codeUnitAt(next.length - 1 - suffix)) {
    suffix++;
  }
  final replacedStart = prefix;
  final replacedEnd = previous.length - suffix;
  final delta = (next.length - suffix - prefix) - (replacedEnd - replacedStart);
  final remapped = <(int, int)>[];
  for (final (start, end) in ranges) {
    if (replacedStart >= end) {
      remapped.add((start, end));
      continue;
    }
    if (replacedEnd <= start) remapped.add((start + delta, end + delta));
  }
  return remapped;
}
