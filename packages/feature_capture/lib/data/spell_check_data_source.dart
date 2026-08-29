import 'dart:ui';

import 'package:feature_capture/domain/spell_check_report.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

const _candidateLanguages = ["de", "en", "fr", "es", "it", "nl", "pt"];
const _sampleLength = 400;
const _chunkLength = 500;
const _minMisspelledRatio = 0.02;
const _maxMisspelledRatio = 0.4;
const _minWords = 12;

abstract class SpellCheckDataSource {
  Future<SpellCheckReport?> checkPage(List<String> words);

  Future<Set<int>?> checkWords(List<String> words);
}

@LazySingleton(as: SpellCheckDataSource)
class SpellCheckDataSourceImpl() implements SpellCheckDataSource {
  final SpellCheckService _service = DefaultSpellCheckService();
  Locale? _locale;

  @override
  Future<SpellCheckReport?> checkPage(List<String> words) async {
    if (words.length < _minWords) return null;
    final (:text, :ranges) = _layout(words);
    final locale = await _resolveLocale(text);
    if (locale == null) return null;
    final report = await _report(locale, text, ranges);
    if (report == null) return null;
    if (report.misspelled.length > words.length * _maxMisspelledRatio) return null;
    return report;
  }

  @override
  Future<Set<int>?> checkWords(List<String> words) async {
    if (words.isEmpty) return null;
    if (_locale case final Locale locale) {
      final (:text, :ranges) = _layout(words);
      return (await _report(locale, text, ranges))?.misspelled;
    }
    return null;
  }

  Future<SpellCheckReport?> _report(
    Locale locale,
    String text,
    List<TextRange> ranges,
  ) async {
    final spans = await _spans(locale, text);
    if (spans == null) return null;
    final misspelled = <int>{};
    final suggestions = <int, List<String>>{};
    for (final span in spans) {
      for (var index = 0; index < ranges.length; index++) {
        final range = ranges[index];
        if (range.start >= span.range.end || range.end <= span.range.start) continue;
        misspelled.add(index);
        if (span.suggestions.isNotEmpty) suggestions[index] = span.suggestions;
      }
    }
    return SpellCheckReport(misspelled: misspelled, suggestions: suggestions);
  }

  ({String text, List<TextRange> ranges}) _layout(List<String> words) {
    final buffer = StringBuffer();
    final ranges = <TextRange>[];
    for (var index = 0; index < words.length; index++) {
      final start = buffer.length;
      buffer.write(words[index]);
      ranges.add(TextRange(start: start, end: buffer.length));
      if (index < words.length - 1) buffer.write(" ");
    }
    return (text: buffer.toString(), ranges: ranges);
  }

  Future<Locale?> _resolveLocale(String text) async {
    final sample = text.length <= _sampleLength ? text : text.substring(0, _sampleLength);
    if (_locale case final Locale cached) {
      if (await _misspelledRatio(cached, sample) != null) return cached;
    }
    Locale? best;
    var bestRatio = double.infinity;
    for (final candidate in _candidates()) {
      final ratio = await _misspelledRatio(candidate, sample);
      if (ratio == null || ratio >= bestRatio) continue;
      best = candidate;
      bestRatio = ratio;
    }
    _locale = best;
    return best;
  }

  List<Locale> _candidates() {
    final platform = PlatformDispatcher.instance.locale;
    final languages = <String>{platform.languageCode, ..._candidateLanguages};
    return [for (final language in languages) Locale(language)];
  }

  Future<double?> _misspelledRatio(Locale locale, String sample) async {
    final spans = await _spans(locale, sample);
    if (spans == null) return null;
    var misspelledLength = 0;
    for (final span in spans) {
      misspelledLength += span.range.end - span.range.start;
    }
    final ratio = misspelledLength / sample.length;
    // * a locale without a dictionary reports nothing at all, which must not win the comparison
    if (ratio < _minMisspelledRatio || ratio > _maxMisspelledRatio) return null;
    return ratio;
  }

  Future<List<SuggestionSpan>?> _spans(Locale locale, String text) async {
    final spans = <SuggestionSpan>[];
    var start = 0;
    while (start < text.length) {
      final end = _chunkEnd(text, start);
      final chunk = text.substring(start, end);
      final result = await _service.fetchSpellCheckSuggestions(locale, chunk);
      if (result == null) return null;
      for (final span in result) {
        spans.add(
          SuggestionSpan(
            TextRange(start: span.range.start + start, end: span.range.end + start),
            span.suggestions,
          ),
        );
      }
      start = end + 1;
    }
    return spans;
  }

  int _chunkEnd(String text, int start) {
    final limit = start + _chunkLength;
    if (limit >= text.length) return text.length;
    final boundary = text.lastIndexOf(" ", limit);
    return boundary <= start ? limit : boundary;
  }
}
