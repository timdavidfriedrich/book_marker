import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/models/remote_google_book.dart';
import 'package:shared/data/models/remote_open_library_book.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/extensions/isbn_extensions.dart';

const _isbn13Type = "ISBN_13";
const _isbn10Type = "ISBN_10";
const _insecureScheme = "http://";
const _secureScheme = "https://";
const _curlParameter = "&edge=curl";
const _statusReading = "reading";
const _statusPaused = "paused";
const _statusFinished = "finished";
const _googleCoverEndpoint = "https://books.google.com/books/content";
const _openLibraryCoverEndpoint = "https://covers.openlibrary.org/b/id";
const _openLibraryCoverSize = "M";

extension LocalBookMappers on LocalBook {
  Book toBook() {
    return Book(
      id: id,
      title: title,
      authors: authors,
      isbn: isbn,
      thumbnailUrl: thumbnailUrl,
      coverPath: coverPath,
      status: status.toBookStatus(),
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
      coverPath: coverPath,
      status: status.value,
      createdAt: createdAt,
      lastUsedAt: lastUsedAt,
    );
  }
}

extension RemoteGoogleBookMappers on RemoteGoogleBook {
  Book toBook({required String id, required DateTime timestamp}) {
    final info = volumeInfo;
    final identifier = info?.industryIdentifiers.toIsbn();
    return Book(
      id: id,
      title: info?.title ?? "",
      authors: info?.authors ?? const [],
      isbn: identifier,
      thumbnailUrl: info?.imageLinks.toThumbnailUrl() ?? identifier.toGoogleCoverUrl(),
      coverPath: null,
      status: BookStatus.reading,
      createdAt: timestamp,
      lastUsedAt: timestamp,
    );
  }
}

extension RemoteOpenLibraryBookMappers on RemoteOpenLibraryBook {
  Book toBook({required String id, required DateTime timestamp}) {
    final identifier = isbn?.toPreferredIsbn();
    return Book(
      id: id,
      title: title ?? "",
      authors: authorNames ?? const [],
      isbn: identifier,
      // * Open Library only serves a cover behind a cover id, so an edition without one falls back
      // * to Google's content server, which resolves a cover from the ISBN without spending quota
      thumbnailUrl: coverId.toOpenLibraryCoverUrl() ?? identifier.toGoogleCoverUrl(),
      coverPath: null,
      status: BookStatus.reading,
      createdAt: timestamp,
      lastUsedAt: timestamp,
    );
  }
}

extension BookStatusValueMappers on String {
  BookStatus toBookStatus() => switch (this) {
    _statusPaused => BookStatus.paused,
    _statusFinished => BookStatus.finished,
    _ => BookStatus.reading,
  };
}

extension BookStatusMappers on BookStatus {
  String get value => switch (this) {
    BookStatus.reading => _statusReading,
    BookStatus.paused => _statusPaused,
    BookStatus.finished => _statusFinished,
  };
}

extension _IsbnMappers on List<RemoteGoogleIndustryIdentifier>? {
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

extension _ThumbnailMappers on RemoteGoogleImageLinks? {
  String? toThumbnailUrl() {
    final links = this;
    final url = links?.thumbnail ?? links?.smallThumbnail;
    // * the curl parameter draws a fake page fold over the cover
    return url?.replaceFirst(_insecureScheme, _secureScheme).replaceFirst(_curlParameter, "");
  }
}

extension _GoogleCoverMappers on String? {
  String? toGoogleCoverUrl() {
    final identifier = this;
    if (identifier == null) return null;
    return "$_googleCoverEndpoint?vid=ISBN$identifier&printsec=frontcover&img=1&zoom=1";
  }
}

extension _OpenLibraryCoverMappers on int? {
  String? toOpenLibraryCoverUrl() {
    final coverId = this;
    if (coverId == null) return null;
    return "$_openLibraryCoverEndpoint/$coverId-$_openLibraryCoverSize.jpg";
  }
}
