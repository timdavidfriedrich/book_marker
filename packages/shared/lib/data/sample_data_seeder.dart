import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/book_local_data_source.dart';
import 'package:shared/data/data_sources/bookmark_local_data_source.dart';
import 'package:shared/data/data_sources/shelf_local_data_source.dart';
import 'package:shared/data/data_sources/theme_local_data_source.dart';
import 'package:shared/data/database/app_database.dart';

// * Dev-only: seeds example books/marks/themes/shelves on first launch when the
// * library is empty. To remove: delete this file, its call in main.dart, and the
// * `seedSampleData` flag in core/config/build_config.dart.
@lazySingleton
class const SampleDataSeeder(
  final BookLocalDataSource _bookLocalDataSource,
  final BookmarkLocalDataSource _bookmarkLocalDataSource,
  final ThemeLocalDataSource _themeLocalDataSource,
  final ShelfLocalDataSource _shelfLocalDataSource,
) {
  Future<void> seedIfEmpty() async {
    final existing = await _bookLocalDataSource.watchBooks().first;
    if (existing.isNotEmpty) return;

    final now = DateTime.now().toUtc();
    DateTime at(int minutesAgo) => now.subtract(Duration(minutes: minutesAgo));

    final books = [
      _book("seed-braiding", "Braiding Sweetgrass", "Robin Wall Kimmerer", "reading", at(10)),
      _book("seed-four-thousand", "Four Thousand Weeks", "Oliver Burkeman", "reading", at(40)),
      _book("seed-wintering", "Wintering", "Katherine May", "reading", at(90)),
      _book("seed-dispossessed", "The Dispossessed", "Ursula K. Le Guin", "finished", at(600)),
    ];
    for (final book in books) {
      await _bookLocalDataSource.upsertBook(book);
    }

    final marks = [
      _mark("seed-m1", "seed-braiding", 143, "To notice a thing is to begin to owe it something.",
          note: "bring this to the reading group", isFavorite: true, createdAt: at(10)),
      _mark("seed-m2", "seed-braiding", 91, "The land keeps no ledger, and still nothing goes unreturned.",
          isFavorite: true, createdAt: at(60)),
      _mark("seed-m3", "seed-braiding", 206, "A gift is not a gift until it moves.", createdAt: at(120)),
      _mark("seed-m4", "seed-four-thousand", 88, "Time is a gift you cannot save for later.",
          isFavorite: true, createdAt: at(40)),
      _mark("seed-m5", "seed-four-thousand", 121,
          "You can only ever have made the time for what you actually did.", createdAt: at(200)),
      _mark("seed-m6", "seed-wintering", 22,
          "Winter is a season of noticing, because so little else moves.", createdAt: at(90)),
      _mark("seed-m7", "seed-dispossessed", 74, "You cannot buy the revolution. You can only be the revolution.",
          note: "the gift economy chapter answers Shevek", createdAt: at(600)),
    ];
    for (final mark in marks) {
      await _bookmarkLocalDataSource.insertBookmark(mark);
    }

    await _themeLocalDataSource.upsertTheme(LocalTheme(id: "seed-t1", name: "Attention", createdAt: at(30)));
    await _themeLocalDataSource.upsertTheme(LocalTheme(id: "seed-t2", name: "Reciprocity", createdAt: at(50)));
    for (final markId in ["seed-m1", "seed-m5", "seed-m6"]) {
      await _themeLocalDataSource.addMark("seed-t1", markId);
    }
    for (final markId in ["seed-m2", "seed-m3", "seed-m7"]) {
      await _themeLocalDataSource.addMark("seed-t2", markId);
    }

    await _shelfLocalDataSource.upsertShelf(LocalShelf(id: "seed-s1", name: "Nature writing", createdAt: at(20)));
    for (final bookId in ["seed-braiding", "seed-wintering"]) {
      await _shelfLocalDataSource.addBook("seed-s1", bookId);
    }
  }

  LocalBook _book(String id, String title, String author, String status, DateTime createdAt) {
    return LocalBook(
      id: id,
      title: title,
      authors: [author],
      status: status,
      createdAt: createdAt,
      lastUsedAt: createdAt,
    );
  }

  LocalBookmark _mark(
    String id,
    String bookId,
    int page,
    String quote, {
    String? note,
    bool isFavorite = false,
    required DateTime createdAt,
  }) {
    return LocalBookmark(
      id: id,
      bookId: bookId,
      pageNumber: page,
      quote: quote,
      note: note,
      photoPath: "",
      imageAspectRatio: 0.72,
      highlights: const [],
      isFavorite: isFavorite,
      createdAt: createdAt,
    );
  }
}
