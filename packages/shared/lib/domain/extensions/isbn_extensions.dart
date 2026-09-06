const _isbn10Length = 10;
const _isbn13Length = 13;
const _isbn13Prefix = "978";
const _oddWeight = 1;
const _evenWeight = 3;
const _checkModulus = 10;
final _isbnPattern = RegExp(r"^\d{10}(\d{3})?$");
final _separatorPattern = RegExp(r"[^0-9Xx]");

extension IsbnQueryExtensions on String {
  bool get isIsbn => _isbnPattern.hasMatch(this);

  // * the same edition is stored as ISBN-10 or ISBN-13 depending on the catalogue that supplied
  // * it, so both have to collapse onto one value before they can be compared
  String toCanonicalIsbn() {
    final digits = replaceAll(_separatorPattern, "");
    if (digits.length != _isbn10Length) return digits;
    final body = "$_isbn13Prefix${digits.substring(0, _isbn10Length - 1)}";
    return "$body${body.toCheckDigit()}";
  }

  String toCheckDigit() {
    var sum = 0;
    for (final (index, character) in split("").indexed) {
      sum += (int.tryParse(character) ?? 0) * (index.isEven ? _oddWeight : _evenWeight);
    }
    return "${(_checkModulus - sum % _checkModulus) % _checkModulus}";
  }
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
