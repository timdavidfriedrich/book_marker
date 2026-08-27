const _hyphens = {"-", "‐", "­"};

bool _endsWithHyphen(String text) => text.isNotEmpty && _hyphens.contains(text[text.length - 1]);

String joinMarkedLines(Iterable<String> lines) {
  final buffer = StringBuffer();
  for (final raw in lines) {
    final text = raw.trim();
    if (text.isEmpty) continue;
    final current = buffer.toString();
    if (current.isEmpty) {
      buffer.write(text);
    } else if (_endsWithHyphen(current)) {
      buffer.clear();
      buffer
        ..write(current.substring(0, current.length - 1))
        ..write(text);
    } else {
      buffer
        ..write(" ")
        ..write(text);
    }
  }
  return buffer.toString().replaceAll(RegExp(r"\s+"), " ").trim();
}
