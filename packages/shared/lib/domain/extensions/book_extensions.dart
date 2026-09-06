import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/extensions/isbn_extensions.dart';

final _whitespacePattern = RegExp(r"\s+");

extension BookIdentityExtensions on Book {
  // * a catalogue hit carries a freshly minted id, so identity has to come from the edition itself
  bool isSameBookAs(Book other) {
    final identifier = isbn?.toCanonicalIsbn();
    final otherIdentifier = other.isbn?.toCanonicalIsbn();
    if (identifier != null && otherIdentifier != null) return identifier == otherIdentifier;
    return title.toComparable() == other.title.toComparable() &&
        authors.join(" ").toComparable() == other.authors.join(" ").toComparable();
  }

  bool matchesQuery(String query) {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) return true;
    if (query.trim().isIsbn && isbn?.toCanonicalIsbn() == query.trim().toCanonicalIsbn()) {
      return true;
    }
    return "$title ${authors.join(" ")} ${isbn ?? ""}".toLowerCase().contains(needle);
  }
}

extension on String {
  String toComparable() => toLowerCase().replaceAll(_whitespacePattern, " ").trim();
}
