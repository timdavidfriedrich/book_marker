import 'package:feature_capture/domain/recognized_page.dart';

class const WordGroup({
  required final List<int> indexes,
  required final String text,
  required final int? number,
});

extension RecognizedPageExtensions on RecognizedPage {
  List<WordGroup> wordGroups() {
    final groups = <WordGroup>[];
    var index = 0;
    var number = 0;
    while (index < words.length) {
      final indexes = <int>[index];
      while (words[indexes.last].joinsWithNext && indexes.last + 1 < words.length) {
        indexes.add(indexes.last + 1);
      }
      final isUncertain = indexes.any((entry) => words[entry].isUncertain);
      if (isUncertain) number++;
      groups.add(
        WordGroup(
          indexes: indexes,
          text: [for (final entry in indexes) words[entry].text].join(),
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
}
