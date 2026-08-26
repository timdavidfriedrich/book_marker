import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/models/remote_book.dart';
import 'package:shared/domain/entities/book.dart';

const _isbn13Type = "ISBN_13";
const _isbn10Type = "ISBN_10";
const _insecureScheme = "http://";
const _secureScheme = "https://";

extension LocalBookMappers on LocalBook {
  Book toBook() {
    return Book(
      id: id,
      title: title,
      authors: authors,
      isbn: isbn,
      thumbnailUrl: thumbnailUrl,
      createdAt: createdAt,
      lastUsedAt: lastUsedAt,
    );
  }
}

extension BookMappers on Book {
  LocalBook toLocalBook() {
    return LocalBook(
      id: id,
      title: title,
      authors: authors,
      isbn: isbn,
      thumbnailUrl: thumbnailUrl,
      createdAt: createdAt,
      lastUsedAt: lastUsedAt,
    );
  }
}

extension RemoteBookMappers on RemoteBook {
  Book toBook({required String id, required DateTime timestamp}) {
    final info = volumeInfo;
    return Book(
      id: id,
      title: info?.title ?? "",
      authors: info?.authors ?? const [],
      isbn: info?.industryIdentifiers.toIsbn(),
      thumbnailUrl: info?.imageLinks.toThumbnailUrl(),
      createdAt: timestamp,
      lastUsedAt: timestamp,
    );
  }
}

extension _IsbnMappers on List<RemoteIndustryIdentifier>? {
  String? toIsbn() {
    final identifiers = this;
    if (identifiers == null) return null;
    String? isbn10;
    for (final identifier in identifiers) {
      if (identifier.type == _isbn13Type) return identifier.identifier;
      if (identifier.type == _isbn10Type) isbn10 ??= identifier.identifier;
    }
    return isbn10;
  }
}

extension _ThumbnailMappers on RemoteImageLinks? {
  String? toThumbnailUrl() {
    final links = this;
    final url = links?.thumbnail ?? links?.smallThumbnail;
    return url?.replaceFirst(_insecureScheme, _secureScheme);
  }
}
