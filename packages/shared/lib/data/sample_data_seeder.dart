import 'package:core/theme/accent_color.dart';
import 'package:core/theme/collection_symbol.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/book_local_data_source.dart';
import 'package:shared/data/data_sources/quote_local_data_source.dart';
import 'package:shared/data/data_sources/shelf_local_data_source.dart';
import 'package:shared/data/data_sources/theme_local_data_source.dart';
import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/mappers/accent_mappers.dart';
import 'package:shared/data/mappers/collection_symbol_mappers.dart';

// * Dev-only: seeds example books/quotes/themes/shelves, triggered from the debug
// * section of the settings screen. To remove: delete this file together with
// * SampleDataRepository and the debug section in settings_screen.dart.
const _coverEndpoint = "https://books.google.com/books/content?vid=ISBN";
const _coverParameters = "&printsec=frontcover&img=1&zoom=1";

@lazySingleton
class const SampleDataSeeder(
  final BookLocalDataSource _bookLocalDataSource,
  final QuoteLocalDataSource _quoteLocalDataSource,
  final ThemeLocalDataSource _themeLocalDataSource,
  final ShelfLocalDataSource _shelfLocalDataSource,
) {
  Future<bool> hasSampleData() async {
    for (final book in _sampleBooks(DateTime.now().toUtc())) {
      if (await _bookLocalDataSource.readBook(book.id) != null) return true;
    }
    return false;
  }

  Future<void> seedSampleData() async {
    final now = DateTime.now().toUtc();
    DateTime at(int minutesAgo) => now.subtract(Duration(minutes: minutesAgo));

    for (final book in _sampleBooks(now)) {
      await _bookLocalDataSource.upsertBook(book);
    }

    final quotes = [
      _quote(
        "seed-m1",
        "seed-braiding",
        143,
        "To notice a thing is to begin to owe it something.",
        note: "bring this to the reading group",
        isFavorite: true,
        createdAt: at(10),
      ),
      _quote(
        "seed-m2",
        "seed-braiding",
        91,
        "The land keeps no ledger, and still nothing goes unreturned.",
        isFavorite: true,
        createdAt: at(60),
      ),
      _quote(
        "seed-m3",
        "seed-braiding",
        206,
        "A gift is not a gift until it moves.",
        createdAt: at(120),
      ),
      _quote(
        "seed-m4",
        "seed-four-thousand",
        88,
        "Time is a gift you cannot save for later.",
        isFavorite: true,
        createdAt: at(40),
      ),
      _quote(
        "seed-m5",
        "seed-four-thousand",
        121,
        "You can only ever have made the time for what you actually did.",
        createdAt: at(200),
      ),
      _quote(
        "seed-m6",
        "seed-wintering",
        22,
        "Winter is a season of noticing, because so little else moves.",
        createdAt: at(90),
      ),
      _quote(
        "seed-m7",
        "seed-dispossessed",
        74,
        "You cannot buy the revolution. You can only be the revolution.",
        note: "the gift economy chapter answers Shevek",
        createdAt: at(600),
      ),
    ];
    for (final quote in quotes) {
      await _quoteLocalDataSource.insertQuote(quote);
    }

    await _themeLocalDataSource.upsertTheme(
      LocalTheme(
        id: "seed-t1",
        name: "Attention",
        createdAt: at(30),
        accent: AccentColor.teal.value,
        symbol: CollectionSymbol.eye.value,
      ),
    );
    await _themeLocalDataSource.upsertTheme(
      LocalTheme(
        id: "seed-t2",
        name: "Reciprocity",
        createdAt: at(50),
        accent: AccentColor.plum.value,
        symbol: CollectionSymbol.wave.value,
      ),
    );
    for (final quoteId in ["seed-m1", "seed-m5", "seed-m6"]) {
      await _themeLocalDataSource.addQuote("seed-t1", quoteId);
    }
    for (final quoteId in ["seed-m2", "seed-m3", "seed-m7"]) {
      await _themeLocalDataSource.addQuote("seed-t2", quoteId);
    }

    await _shelfLocalDataSource.upsertShelf(
      LocalShelf(
        id: "seed-s1",
        name: "Nature writing",
        createdAt: at(20),
        accent: AccentColor.forest.value,
        symbol: CollectionSymbol.leaf.value,
      ),
    );
    for (final bookId in ["seed-braiding", "seed-wintering"]) {
      await _shelfLocalDataSource.addBook("seed-s1", bookId);
    }
  }

  List<LocalBook> _sampleBooks(DateTime now) {
    DateTime at(int minutesAgo) => now.subtract(Duration(minutes: minutesAgo));
    return [
      _book(
        "seed-braiding",
        "Braiding Sweetgrass",
        "Robin Wall Kimmerer",
        "9781571313560",
        "reading",
        at(10),
      ),
      _book(
        "seed-four-thousand",
        "Four Thousand Weeks",
        "Oliver Burkeman",
        "9780374159122",
        "reading",
        at(40),
      ),
      _book("seed-wintering", "Wintering", "Katherine May", "9780593189481", "paused", at(90)),
      _book(
        "seed-dispossessed",
        "The Dispossessed",
        "Ursula K. Le Guin",
        "9780061054884",
        "finished",
        at(600),
      ),
    ];
  }

  LocalBook _book(
    String id,
    String title,
    String author,
    String isbn,
    String status,
    DateTime createdAt,
  ) {
    return LocalBook(
      id: id,
      title: title,
      authors: [author],
      isbn: isbn,
      thumbnailUrl: "$_coverEndpoint$isbn$_coverParameters",
      status: status,
      createdAt: createdAt,
      lastUsedAt: createdAt,
    );
  }

  LocalQuote _quote(
    String id,
    String bookId,
    int page,
    String quote, {
    String? note,
    bool isFavorite = false,
    required DateTime createdAt,
  }) {
    return LocalQuote(
      id: id,
      bookId: bookId,
      pageNumbers: [page],
      quote: quote,
      note: note,
      pages: const [],
      words: const [],
      markedWordIndexes: const [],
      isFavorite: isFavorite,
      createdAt: createdAt,
    );
  }
}
