// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Book Marker';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';

  @override
  String get save => 'Save';

  @override
  String get tryAgain => 'Try again';

  @override
  String get commonRename => 'Rename';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonChangeMark => 'Change mark';

  @override
  String get markPickerTitle => 'Choose a mark';

  @override
  String get markPickerSymbolLabel => 'symbol';

  @override
  String get markPickerColorLabel => 'color';

  @override
  String get error => 'Error';

  @override
  String get errorConnection => 'No internet connection.';

  @override
  String errorApi(String message) {
    return 'Error while communicating with the server: $message.';
  }

  @override
  String get errorAuth => 'You are not signed in.';

  @override
  String get errorValidation => 'The data received is invalid.';

  @override
  String get errorNotFound => 'Not found.';

  @override
  String get errorUnexpected => 'An unexpected error occurred.';

  @override
  String get libraryTitle => 'Library';

  @override
  String get libraryEmptyMessage => 'No quotes yet. Take a photo of a book page to get started.';

  @override
  String get libraryUnknownBook => 'Unknown book';

  @override
  String libraryPageLabel(int page) {
    return 'Page $page';
  }

  @override
  String get libraryNoPageLabel => 'No page';

  @override
  String get bookAuthorsUnknown => 'Unknown author';

  @override
  String get captureTitle => 'Capture page';

  @override
  String get captureSelectBookHint => 'Select book';

  @override
  String get captureNoBooksMessage => 'Add a book first to start marking pages.';

  @override
  String get captureAddBookButton => 'Add book';

  @override
  String get captureShutterLabel => 'Capture page';

  @override
  String get captureCameraUnavailable => 'The camera is not available on this device.';

  @override
  String get addBookTitle => 'Add book';

  @override
  String get addBookSearchHint => 'Search by title, author or ISBN';

  @override
  String get addBookScanButton => 'Scan barcode';

  @override
  String get addBookInitialMessage => 'Search for a book or scan its barcode.';

  @override
  String get addBookEmptyMessage => 'No books found. Try another search.';

  @override
  String get barcodeScannerTitle => 'Scan barcode';

  @override
  String get barcodeScannerHint => 'Point the camera at the book\'s barcode.';

  @override
  String get markingTitle => 'Mark page';

  @override
  String get markingProcessingMessage => 'Reading text…';

  @override
  String get markingInstruction => 'Tap the lines you want to mark.';

  @override
  String get markingNoTextMessage => 'No text was found on this page.';

  @override
  String get markingPageNumberLabel => 'Page number';

  @override
  String get markingPageNumberHint => 'Add page number';

  @override
  String get markingPageNumberMissing => 'Page number not detected. Add it manually.';

  @override
  String get markingSelectedLabel => 'Selected text';

  @override
  String get markingNothingSelectedMessage => 'Nothing selected yet.';

  @override
  String get markingSaveButton => 'Save quote';

  @override
  String get markingSavedMessage => 'Quote saved.';

  @override
  String get markingSelectPrompt => 'Select at least one line to save.';

  @override
  String get quoteDetailTitle => 'Quote';

  @override
  String get quoteDetailQuoteLabel => 'Quote';

  @override
  String quoteDetailPageLabel(int page) {
    return 'Page $page';
  }

  @override
  String get quoteDetailNoPage => 'No page number';

  @override
  String get quoteDetailFavoriteAdd => 'Add to favorites';

  @override
  String get quoteDetailFavoriteRemove => 'Remove from favorites';

  @override
  String get librarySearchHint => 'Search books and quotes…';

  @override
  String get libraryTabBooks => 'books';

  @override
  String get libraryTabShelves => 'shelves';

  @override
  String get libraryAddShelfLabel => '+ shelf';

  @override
  String libraryFilterAll(int count) {
    return 'all $count';
  }

  @override
  String libraryFilterReading(int count) {
    return 'reading $count';
  }

  @override
  String libraryFilterPaused(int count) {
    return 'paused $count';
  }

  @override
  String libraryFilterFinished(int count) {
    return 'finished $count';
  }

  @override
  String libraryQuotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count quotes',
      one: '1 quote',
    );
    return '$_temp0';
  }

  @override
  String libraryFavoritesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count favorites',
      one: '1 favorite',
    );
    return '$_temp0';
  }

  @override
  String get libraryStatusReading => 'reading';

  @override
  String get libraryStatusPaused => 'paused';

  @override
  String get libraryShelvesPlaceholder => 'Shelves arrive in the next update.';

  @override
  String get librarySearchScopeAll => 'all books';

  @override
  String get librarySearchScopeFavorites => 'favorites';

  @override
  String get librarySearchScopeNotes => 'my notes';

  @override
  String libraryBookMeta(int quotes, int favorites) {
    String _temp0 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes quotes',
      one: '1 quote',
    );
    String _temp1 = intl.Intl.pluralLogic(
      favorites,
      locale: localeName,
      other: '$favorites favorites',
      one: '1 favorite',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String libraryBookMetaWithStatus(int quotes, int favorites, String status) {
    String _temp0 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes quotes',
      one: '1 quote',
    );
    String _temp1 = intl.Intl.pluralLogic(
      favorites,
      locale: localeName,
      other: '$favorites favorites',
      one: '1 favorite',
    );
    return '$_temp0, $_temp1,\n$status';
  }

  @override
  String libraryShelfMeta(int books, int quotes) {
    String _temp0 = intl.Intl.pluralLogic(
      books,
      locale: localeName,
      other: '$books books',
      one: '1 book',
    );
    String _temp1 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes quotes',
      one: '1 quote',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String quoteSourceLabel(String title, String pages) {
    return '$title, p.$pages';
  }

  @override
  String librarySearchCount(int quotes, int books) {
    String _temp0 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes quotes',
      one: '1 quote',
    );
    String _temp1 = intl.Intl.pluralLogic(
      books,
      locale: localeName,
      other: '$books books',
      one: '1 book',
    );
    return '$_temp0 in $_temp1';
  }

  @override
  String get navLibraryLabel => 'library';

  @override
  String get navThemesLabel => 'themes';

  @override
  String get profileYouLabel => 'you';

  @override
  String pageShortLabel(String pages) {
    return 'p.$pages';
  }

  @override
  String quoteVoiceNoteLabel(String duration) {
    return 'voice note $duration';
  }

  @override
  String get comingSoonMessage => 'Coming soon.';

  @override
  String get themesTitle => 'Themes';

  @override
  String get themesSubtitlePlaceholder => 'Gather quotes across your books';

  @override
  String get themesPlaceholderMessage =>
      'Themes gather quotes from across your books. They arrive in the next update.';

  @override
  String bookDetailAllFilter(int count) {
    return 'all $count';
  }

  @override
  String get bookDetailFavoritesFilter => 'favorites';

  @override
  String get bookDetailVoiceNoteFilter => 'with voice note';

  @override
  String bookDetailQuotesStat(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count quotes',
      one: '1 quote',
    );
    return '$_temp0';
  }

  @override
  String bookDetailFavoritesStat(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count favorites',
      one: '1 favorite',
    );
    return '$_temp0';
  }

  @override
  String get bookDetailEmptyMessage => 'No quotes in this book yet.';

  @override
  String get captureSteadyHint => 'hold steady for sharper text';

  @override
  String get captureModeOnePage => 'one page';

  @override
  String get captureModeSpread => 'spread';

  @override
  String get captureMarkingInto => 'marking into';

  @override
  String get captureSwitchButton => 'switch';

  @override
  String get captureGalleryLabel => 'from gallery';

  @override
  String get captureGalleryPlaceholder => 'Importing from the gallery is coming soon.';

  @override
  String get captureLightOn => 'light on';

  @override
  String get captureLightOff => 'light off';

  @override
  String get captureModeAuto => 'auto';

  @override
  String get captureModeManual => 'manual';

  @override
  String get cropTitle => 'Mark the page';

  @override
  String get cropHint => 'drag the dots onto the page corners';

  @override
  String get cropLoadingMessage => 'Finding the page…';

  @override
  String get cropContinueButton => 'Continue';

  @override
  String get addBookQuestionTitle => 'Which book is this?';

  @override
  String get addBookInLibraryLabel => 'in your library';

  @override
  String get addBookNotInLibraryLabel => 'not in your library, yet';

  @override
  String get addBookSelectButton => 'select';

  @override
  String get addBookAddButton => '+ add';

  @override
  String get addBookCatalogueFooter =>
      'Catalogue results arrive from an online book service. No match? Scan the barcode, or type the title yourself.';

  @override
  String get addBookNoCatalogueResults =>
      'No catalogue matches. Scan the barcode or refine your search.';

  @override
  String get markingModeText => 'text';

  @override
  String get markingModePhoto => 'photo';

  @override
  String get markingContinueButton => 'Continue';

  @override
  String markingSaveSheetTitle(String book) {
    return 'Save to $book';
  }

  @override
  String get pageFieldLabel => 'page';

  @override
  String get pageFieldHint => '42–43';

  @override
  String get pageAutoLabel => 'auto';

  @override
  String get markingNoteHint => 'add a note';

  @override
  String get markingVoiceNoteHint => 'voice note';

  @override
  String get markingDoneButton => 'Done';

  @override
  String get markingUncertainLegend => '= uncertain words, tap to correct';

  @override
  String get markingCorrectionTitle => 'Unsure word';

  @override
  String get markingCorrectionHint => 'compare it with the photo and fix what the scan got wrong';

  @override
  String markingJoinNextButton(String word) {
    return 'Join with “$word” after';
  }

  @override
  String markingJoinPreviousButton(String word) {
    return 'Join with “$word” before';
  }

  @override
  String get markingCorrectionApplyButton => 'Apply';

  @override
  String markingUnsureWordsLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count words may be misread — check the quote',
      one: '1 word may be misread — check the quote',
    );
    return '$_temp0';
  }

  @override
  String get markingNewThemeChip => '+ new';

  @override
  String quoteDetailPhotoMeta(String pages, String date) {
    return 'p.$pages, shot $date';
  }

  @override
  String quoteDetailShotMeta(String date) {
    return 'shot $date';
  }

  @override
  String get quoteDetailNotePlaceholder => 'Add a note — coming soon.';

  @override
  String get quoteDetailFavoriteLabel => 'favorite';

  @override
  String get quoteDetailShareLabel => 'share';

  @override
  String quoteShareBody(String quote, String source) {
    return '“$quote”\n\n— $source';
  }

  @override
  String get quoteDetailMoreLabel => 'more';

  @override
  String get quoteDetailNoteHint => 'Add a note…';

  @override
  String get libraryStatusFinished => 'finished';

  @override
  String libraryFinishedFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count finished books',
      one: '1 finished book',
    );
    return '$_temp0';
  }

  @override
  String get libraryShowFinished => 'show them';

  @override
  String get bookDetailMarkFinished => 'Mark as finished';

  @override
  String get bookDetailMarkReading => 'Mark as reading';

  @override
  String get bookDetailMarkPaused => 'Mark as paused';

  @override
  String themesBooksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count books',
      one: '1 book',
    );
    return '$_temp0';
  }

  @override
  String themesThemeMeta(int quotes, int books) {
    String _temp0 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes quotes',
      one: '1 quote',
    );
    String _temp1 = intl.Intl.pluralLogic(
      books,
      locale: localeName,
      other: '$books books',
      one: '1 book',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get themesNewThemeLabel => 'New theme';

  @override
  String get themesNewThemeTitle => 'New theme';

  @override
  String get themesNewThemeHint => 'Theme name';

  @override
  String themeDetailStats(int quotes, int books, int favorites) {
    String _temp0 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes quotes',
      one: '1 quote',
    );
    String _temp1 = intl.Intl.pluralLogic(
      books,
      locale: localeName,
      other: '$books books',
      one: '1 book',
    );
    String _temp2 = intl.Intl.pluralLogic(
      favorites,
      locale: localeName,
      other: '$favorites favorites',
      one: '1 favorite',
    );
    return '$_temp0 in $_temp1, $_temp2';
  }

  @override
  String get themeDetailAddQuotes => 'Add quotes to this theme';

  @override
  String get themeDetailEmpty => 'No quotes in this theme yet.';

  @override
  String get themeAddQuotesTitle => 'Add quotes';

  @override
  String get themeRenameTitle => 'Rename theme';

  @override
  String get themeDeleteTitle => 'Delete theme?';

  @override
  String get themeDeleteMessage => 'The theme is removed. Your quotes and books stay.';

  @override
  String get shelfRenameTitle => 'Rename shelf';

  @override
  String get shelfDeleteTitle => 'Delete shelf?';

  @override
  String get shelfDeleteMessage => 'The shelf is removed. Your books stay.';

  @override
  String get bookDeleteAction => 'Delete book';

  @override
  String get bookDeleteTitle => 'Delete book?';

  @override
  String get bookDeleteMessage =>
      'This deletes the book and all its quotes. This can\'t be undone.';

  @override
  String get quoteDeleteAction => 'Delete quote';

  @override
  String get quoteDeleteTitle => 'Delete quote?';

  @override
  String get quoteDeleteMessage => 'This deletes the quote. This can\'t be undone.';

  @override
  String get libraryNewShelfLabel => 'New shelf';

  @override
  String get libraryNewShelfTitle => 'New shelf';

  @override
  String get libraryNewShelfHint => 'Shelf name';

  @override
  String shelfDetailStats(int books, int quotes) {
    String _temp0 = intl.Intl.pluralLogic(
      books,
      locale: localeName,
      other: '$books books',
      one: '1 book',
    );
    String _temp1 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes quotes',
      one: '1 quote',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get shelfDetailAddBooks => 'Add books to this shelf';

  @override
  String get shelfDetailEmpty => 'No books on this shelf yet.';

  @override
  String get shelfAddBooksTitle => 'Add books';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsProfileNameHint => 'Your name';

  @override
  String settingsStats(int books, int quotes, int themes) {
    String _temp0 = intl.Intl.pluralLogic(
      books,
      locale: localeName,
      other: '$books books',
      one: '1 book',
    );
    String _temp1 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes quotes',
      one: '1 quote',
    );
    String _temp2 = intl.Intl.pluralLogic(
      themes,
      locale: localeName,
      other: '$themes themes',
      one: '1 theme',
    );
    return '$_temp0, $_temp1, $_temp2';
  }

  @override
  String get settingsLanguageLabel => 'Language';

  @override
  String get settingsLanguageSystem => 'System';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageGerman => 'German';

  @override
  String get settingsAboutLabel => 'About';

  @override
  String settingsVersionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get filterNoResultsMessage => 'Nothing matches this filter.';

  @override
  String libraryBookMetaStatus(int quotes, String status) {
    String _temp0 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes quotes',
      one: '1 quote',
    );
    return '$_temp0,\n$status';
  }

  @override
  String get markingBookFieldLabel => 'book';

  @override
  String get markingBookPickerTitle => 'Choose book';

  @override
  String get quoteDetailAddThemeChip => '+ add';

  @override
  String get quoteDetailThemePickerTitle => 'Themes';

  @override
  String get settingsLicensesLabel => 'Open-source licenses';

  @override
  String get captureSpreadHint => 'photograph every page the quote runs across';

  @override
  String get captureSpreadShotsHint => 'tap to remove · hold to reorder';

  @override
  String captureSpreadContinueButton(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continue with $count pages',
      one: 'Continue with 1 page',
    );
    return '$_temp0';
  }

  @override
  String get captureSpreadRemoveLabel => 'Remove page';

  @override
  String get quoteDetailNoPhotoMessage => 'No photo was saved with this quote.';

  @override
  String get showMore => 'show more';

  @override
  String get showLess => 'show less';

  @override
  String get quoteDetailSourceLabel => 'source';

  @override
  String get quoteDetailNotesLabel => 'my thoughts';
}
