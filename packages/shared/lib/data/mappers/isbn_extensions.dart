const _isbn13Length = 13;
final _isbnPattern = RegExp(r"^\d{10}(\d{3})?$");

extension IsbnQueryExtensions on String {
  bool get isIsbn => _isbnPattern.hasMatch(this);
}

extension IsbnListExtensions on List<String> {
  String? toPreferredIsbn() {
    if (isEmpty) return null;
    for (final isbn in this) {
      if (isbn.length == _isbn13Length) return isbn;
    }
    return first;
  }
}
