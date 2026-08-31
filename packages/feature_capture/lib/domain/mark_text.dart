import 'dart:math' as math;

import 'package:feature_capture/domain/recognized_page.dart';

const _mergeGapRatio = 0.22;
const _minVerticalOverlap = 0.55;
const _minWidthSamples = 6;
const _hyphens = {"-", "‐", "‑", "­"};
const _ellipsisFollowers = {"und", "oder", "sowie", "bzw", "and", "or", "nor"};
final _letterPattern = RegExp(r"[A-Za-zÀ-ɏ]");
final _nonLetterPattern = RegExp(r"[^A-Za-zÀ-ɏ]");

bool endsWithLineBreakHyphen(String text) {
  if (text.length < 2) return false;
  if (!_hyphens.contains(text[text.length - 1])) return false;
  return _letterPattern.hasMatch(text[text.length - 2]);
}

String? lineBreakStem(String text, String continuation) {
  if (!endsWithLineBreakHyphen(text)) return null;
  final head = continuation.trim();
  if (head.isEmpty || !_letterPattern.hasMatch(head[0])) return null;
  final letters = head.replaceAll(_nonLetterPattern, "").toLowerCase();
  if (_ellipsisFollowers.contains(letters)) return null;
  // * an uppercase continuation marks a compound whose hyphen belongs to the word
  if (head[0].toUpperCase() == head[0]) return text;
  return text.substring(0, text.length - 1);
}

String joinMarkedWords(List<RecognizedWord> words, Iterable<int> indexes) {
  final ordered = indexes.toList()..sort();
  final buffer = StringBuffer();
  int? previous;
  for (final index in ordered) {
    if (index < 0 || index >= words.length) continue;
    final text = words[index].text.trim();
    if (text.isEmpty) continue;
    if (previous != null && !(previous + 1 == index && words[previous].joinsWithNext)) {
      buffer.write(" ");
    }
    buffer.write(text);
    previous = index;
  }
  return buffer.toString().replaceAll(RegExp(r"\s+"), " ").trim();
}

List<RecognizedWord> mergeSplitWords(List<RecognizedWord> words) {
  final characterWidth = _medianCharacterWidth(words);
  if (characterWidth <= 0) return words;
  final limit = characterWidth * _mergeGapRatio;
  final merged = <RecognizedWord>[];
  for (final word in words) {
    if (_mergesWithLast(merged, word, limit)) {
      merged[merged.length - 1] = _joined(merged.last, word);
      continue;
    }
    merged.add(word);
  }
  return merged;
}

List<JoinCandidate> joinCandidates(List<RecognizedWord> words, Set<int> unknown) {
  final candidates = <JoinCandidate>[];
  for (var index = 0; index < words.length - 1; index++) {
    final current = words[index];
    final next = words[index + 1];
    if (current.joinsWithNext) continue;
    if (!unknown.contains(index) && !unknown.contains(index + 1)) continue;
    if (!_isStem(current.text) || !_isContinuation(next.text)) continue;
    candidates.add(
      JoinCandidate(
        index: index,
        joined: current.text + next.text,
        crossesLine: !_sharesLine(current, next),
      ),
    );
  }
  return candidates;
}

List<RecognizedWord> applyJoins(List<RecognizedWord> words, Set<int> indexes) {
  final result = <RecognizedWord>[];
  for (var index = 0; index < words.length; index++) {
    final word = words[index];
    if (!indexes.contains(index) || index + 1 >= words.length) {
      result.add(word);
      continue;
    }
    final next = words[index + 1];
    if (_sharesLine(word, next)) {
      result.add(_joined(word, next));
      index++;
      continue;
    }
    result.add(_withStem(word, word.text));
  }
  return result;
}

List<RecognizedWord> markWrappedWords(List<RecognizedWord> words) {
  final marked = <RecognizedWord>[];
  for (var index = 0; index < words.length; index++) {
    final word = words[index];
    final next = index + 1 < words.length ? words[index + 1] : null;
    final endsLine = next != null && next.lineIndex != word.lineIndex;
    final stem = endsLine ? lineBreakStem(word.text, next.text) : null;
    marked.add(stem == null ? word : _withStem(word, stem));
  }
  return marked;
}

bool _mergesWithLast(List<RecognizedWord> merged, RecognizedWord word, double limit) {
  if (merged.isEmpty) return false;
  final previous = merged.last;
  if (previous.joinsWithNext) return false;
  // * the second half of a wrapped word must not absorb the word that follows it
  if (merged.length > 1 && merged[merged.length - 2].joinsWithNext) return false;
  if (!_sharesLine(previous, word)) return false;
  if (word.left < previous.left) return false;
  return word.left - (previous.left + previous.width) < limit;
}

bool _sharesLine(RecognizedWord first, RecognizedWord second) {
  final top = math.max(first.top, second.top);
  final bottom = math.min(first.top + first.height, second.top + second.height);
  final overlap = bottom - top;
  if (overlap <= 0) return false;
  return overlap >= math.min(first.height, second.height) * _minVerticalOverlap;
}

bool _isStem(String text) {
  return text.length >= 2 && _letterPattern.hasMatch(text[text.length - 1]);
}

bool _isContinuation(String text) {
  if (text.length < 2 || !_letterPattern.hasMatch(text[0])) return false;
  return text[0].toLowerCase() == text[0];
}

double _medianCharacterWidth(List<RecognizedWord> words) {
  final widths = <double>[];
  for (final word in words) {
    if (word.text.length < 2 || word.width <= 0) continue;
    widths.add(word.width / word.text.length);
  }
  if (widths.length < _minWidthSamples) return 0;
  widths.sort();
  return widths[widths.length ~/ 2];
}

RecognizedWord _joined(RecognizedWord first, RecognizedWord second) {
  final left = math.min(first.left, second.left);
  final top = math.min(first.top, second.top);
  final right = math.max(first.left + first.width, second.left + second.width);
  final bottom = math.max(first.top + first.height, second.top + second.height);
  final confidence = switch ((first.confidence, second.confidence)) {
    (final double one, final double other) => math.min(one, other),
    (final double one, null) => one,
    (null, final double other) => other,
    _ => null,
  };
  return RecognizedWord(
    text: first.text + second.text,
    left: left,
    top: top,
    width: right - left,
    height: bottom - top,
    lineIndex: first.lineIndex,
    confidence: confidence,
    isUncertain: first.isUncertain || second.isUncertain,
    joinsWithNext: second.joinsWithNext,
  );
}

RecognizedWord _withStem(RecognizedWord word, String stem) {
  return RecognizedWord(
    text: stem,
    left: word.left,
    top: word.top,
    width: word.width,
    height: word.height,
    lineIndex: word.lineIndex,
    confidence: word.confidence,
    isUncertain: word.isUncertain,
    joinsWithNext: true,
  );
}

class const JoinCandidate({
  required final int index,
  required final String joined,
  required final bool crossesLine,
});
