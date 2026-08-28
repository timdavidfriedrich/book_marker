import 'package:shared/data/database/app_database.dart';
import 'package:shared/domain/entities/bookmark.dart';

extension LocalBookmarkMappers on LocalBookmark {
  Bookmark toBookmark() {
    return Bookmark(
      id: id,
      bookId: bookId,
      pageNumber: pageNumber,
      quote: quote,
      note: note,
      voicePath: voicePath,
      voiceDurationMs: voiceDurationMs,
      photoPath: photoPath,
      imageAspectRatio: imageAspectRatio,
      highlights: highlights,
      isFavorite: isFavorite,
      createdAt: createdAt,
    );
  }
}

extension BookmarkMappers on Bookmark {
  LocalBookmark toLocalBookmark() {
    return LocalBookmark(
      id: id,
      bookId: bookId,
      pageNumber: pageNumber,
      quote: quote,
      note: note,
      voicePath: voicePath,
      voiceDurationMs: voiceDurationMs,
      photoPath: photoPath,
      imageAspectRatio: imageAspectRatio,
      highlights: highlights,
      isFavorite: isFavorite,
      createdAt: createdAt,
    );
  }
}
