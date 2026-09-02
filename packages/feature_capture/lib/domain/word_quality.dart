import 'dart:math' as math;

import 'package:feature_capture/domain/spell_check_report.dart';
import 'package:shared/domain/entities/recognized_word.dart';

const _uncertainThreshold = 0.55;
const _maxUncertainRatio = 0.1;
const _minUncertainLimit = 3;
const _misspelledPenalty = 0.7;
const _knownWordBonus = 0.35;
const _repeatedWordBonus = 0.4;
const _heightPenalty = 0.45;
const _junkPenalty = 0.7;
const _mixedPenalty = 0.65;
const _minHeightRatio = 0.55;
const _minRepeatLength = 3;
final _junkPattern = RegExp(r"[|\\_^~`]");
final _mixedCharacterPattern = RegExp(
  r"[A-Za-zÀ-ɏ]\d[A-Za-zÀ-ɏ]|\d[A-Za-zÀ-ɏ]\d",
);
final _nonLetterPattern = RegExp(r"[^A-Za-zÀ-ɏ]");

List<RecognizedWord> markUncertainWords(List<RecognizedWord> words, SpellCheckReport? spelling) {
  if (words.isEmpty) return words;
  final medianHeight = _medianHeight(words);
  final repeated = _repeatedTokens(words);
  final scores = [
    for (var index = 0; index < words.length; index++)
      _suspicion(words[index], index, medianHeight, repeated, spelling),
  ];
  final ranked = [for (var index = 0; index < words.length; index++) index]
    ..sort((first, second) => scores[second].compareTo(scores[first]));
  final limit = math.max(_minUncertainLimit, (words.length * _maxUncertainRatio).floor());
  final uncertain = <int>{};
  for (final index in ranked) {
    if (uncertain.length >= limit || scores[index] < _uncertainThreshold) break;
    uncertain.add(index);
  }
  return [
    for (var index = 0; index < words.length; index++)
      _resolved(words[index], uncertain.contains(index), spelling?.suggestions[index]),
  ];
}

double _suspicion(
  RecognizedWord word,
  int index,
  double medianHeight,
  Set<String> repeated,
  SpellCheckReport? spelling,
) {
  final confidence = word.confidence;
  var score = confidence == null ? 0.0 : math.max(0.0, 1 - confidence);
  if (medianHeight > 0 && word.height < medianHeight * _minHeightRatio) score += _heightPenalty;
  if (_junkPattern.hasMatch(word.text)) score += _junkPenalty;
  if (_mixedCharacterPattern.hasMatch(word.text)) score += _mixedPenalty;
  if (spelling != null) {
    score += spelling.misspelled.contains(index) ? _misspelledPenalty : -_knownWordBonus;
  }
  if (repeated.contains(_normalized(word.text))) score -= _repeatedWordBonus;
  return score;
}

Set<String> _repeatedTokens(List<RecognizedWord> words) {
  final counts = <String, int>{};
  for (final word in words) {
    final token = _normalized(word.text);
    if (token.length < _minRepeatLength) continue;
    counts[token] = (counts[token] ?? 0) + 1;
  }
  return {
    for (final entry in counts.entries)
      if (entry.value > 1) entry.key,
  };
}

String _normalized(String text) => text.toLowerCase().replaceAll(_nonLetterPattern, "");

double _medianHeight(List<RecognizedWord> words) {
  final heights = [for (final word in words) word.height]..sort();
  return heights[heights.length ~/ 2];
}

RecognizedWord _resolved(RecognizedWord word, bool isUncertain, List<String>? suggestions) {
  if (!isUncertain && word.suggestions.isEmpty) return word;
  return RecognizedWord(
    text: word.text,
    left: word.left,
    top: word.top,
    width: word.width,
    height: word.height,
    lineIndex: word.lineIndex,
    pageIndex: word.pageIndex,
    confidence: word.confidence,
    isUncertain: isUncertain,
    joinsWithNext: word.joinsWithNext,
    suggestions: isUncertain ? (suggestions ?? const []) : const [],
  );
}
