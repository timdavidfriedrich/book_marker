import 'package:shared/domain/entities/highlight_region.dart';
import 'package:shared/domain/entities/recognized_word.dart';

class const WordGroup({
  required final List<int> indexes,
  required final String text,
  required final int? number,
});

extension RecognizedWordListExtensions on List<RecognizedWord> {
  List<WordGroup> wordGroups() {
    final groups = <WordGroup>[];
    var index = 0;
    var number = 0;
    while (index < length) {
      final indexes = <int>[index];
      while (this[indexes.last].joinsWithNext && indexes.last + 1 < length) {
        indexes.add(indexes.last + 1);
      }
      final isUncertain = indexes.any((entry) => this[entry].isUncertain);
      if (isUncertain) number++;
      groups.add(
        WordGroup(
          indexes: indexes,
          text: [for (final entry in indexes) this[entry].text].join(),
          number: isUncertain ? number : null,
        ),
      );
      index = indexes.last + 1;
    }
    return groups;
  }

  WordGroup? groupAt(int wordIndex) {
    for (final group in wordGroups()) {
      if (group.indexes.contains(wordIndex)) return group;
    }
    return null;
  }

  String joinMarked(Iterable<int> indexes) {
    final ordered = indexes.toList()..sort();
    final buffer = StringBuffer();
    int? previous;
    for (final index in ordered) {
      if (index < 0 || index >= length) continue;
      final text = this[index].text.trim();
      if (text.isEmpty) continue;
      if (previous != null && !(previous + 1 == index && this[previous].joinsWithNext)) {
        buffer.write(" ");
      }
      buffer.write(text);
      previous = index;
    }
    return buffer.toString().replaceAll(RegExp(r"\s+"), " ").trim();
  }

  // * the marks a page shows are a projection of the marked words, never a separate truth
  List<HighlightRegion> markedRegionsOn(int pageIndex, Iterable<int> markedIndexes) {
    final ordered = markedIndexes.toList()..sort();
    return [
      for (final index in ordered)
        if (index >= 0 && index < length && this[index].pageIndex == pageIndex)
          HighlightRegion(
            text: this[index].text,
            left: this[index].left,
            top: this[index].top,
            width: this[index].width,
            height: this[index].height,
          ),
    ];
  }
}
