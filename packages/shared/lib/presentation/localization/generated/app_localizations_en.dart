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
  String get commonChangeColor => 'Change color';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonAutomatic => 'Automatic';

  @override
  String get accentPickerTitle => 'Choose a color';

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
  String get libraryEmptyMessage => 'No marks yet. Take a photo of a book page to get started.';

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
  String get markingSaveButton => 'Save mark';

  @override
  String get markingSavedMessage => 'Mark saved.';

  @override
  String get markingSelectPrompt => 'Select at least one line to save.';

  @override
  String get bookmarkDetailTitle => 'Mark';

  @override
  String get bookmarkDetailQuoteLabel => 'Marked text';

  @override
  String bookmarkDetailPageLabel(int page) {
    return 'Page $page';
  }

  @override
  String get bookmarkDetailNoPage => 'No page number';

  @override
  String get bookmarkDetailFavoriteAdd => 'Add to favorites';

  @override
  String get bookmarkDetailFavoriteRemove => 'Remove from favorites';

  @override
  String get librarySearchHint => 'Search books and marks…';

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
  String libraryFilterFinished(int count) {
    return 'finished $count';
  }

  @override
  String libraryMarksCount(int count) {
    return '$count marks';
  }

  @override
  String libraryStarredCount(int count) {
    return '$count starred';
  }

  @override
  String get libraryStatusReading => 'reading';

  @override
  String get libraryShelvesPlaceholder => 'Shelves arrive in the next update.';

  @override
  String get librarySearchScopeAll => 'all books';

  @override
  String get librarySearchScopeStarred => 'starred';

  @override
  String get librarySearchScopeNotes => 'my notes';

  @override
  String librarySearchCount(int marks, int books) {
    return '$marks marks in $books books';
  }

  @override
  String get navLibraryLabel => 'library';

  @override
  String get navThemesLabel => 'themes';

  @override
  String get profileYouLabel => 'you';

  @override
  String pageShortLabel(int page) {
    return 'p.$page';
  }

  @override
  String markVoiceLabel(String duration) {
    return 'voice $duration';
  }

  @override
  String get comingSoonMessage => 'Coming soon.';

  @override
  String get themesTitle => 'Themes';

  @override
  String get themesSubtitlePlaceholder => 'Gather marks across your books';

  @override
  String get themesPlaceholderMessage =>
      'Themes gather marks from across your books. They arrive in the next update.';

  @override
  String bookDetailAllFilter(int count) {
    return 'all $count';
  }

  @override
  String get bookDetailStarredFilter => 'starred';

  @override
  String get bookDetailVoiceFilter => 'with voice';

  @override
  String bookDetailMarksStat(int count) {
    return '$count marks';
  }

  @override
  String bookDetailStarredStat(int count) {
    return '$count starred';
  }

  @override
  String get bookDetailEmptyMessage => 'No marks in this book yet.';

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
  String get markingPageFieldLabel => 'page';

  @override
  String get markingPageAutoLabel => 'auto';

  @override
  String get markingNoteHint => 'what did this land on?';

  @override
  String get markingVoiceHint => 'hold to say it out loud';

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
  String bookmarkDetailPhotoMeta(int page, String date) {
    return 'page $page, shot $date';
  }

  @override
  String bookmarkDetailShotMeta(String date) {
    return 'shot $date';
  }

  @override
  String get bookmarkDetailNotePlaceholder => 'Add a note — coming soon.';

  @override
  String get bookmarkDetailStarredLabel => 'starred';

  @override
  String get bookmarkDetailShareLabel => 'share';

  @override
  String markShareBody(String quote, String source) {
    return '“$quote”\n\n— $source';
  }

  @override
  String get bookmarkDetailMoreLabel => 'more';

  @override
  String get bookmarkDetailNoteHint => 'Add a note…';

  @override
  String get libraryStatusFinished => 'finished';

  @override
  String libraryFinishedFooter(int count) {
    return '$count finished books';
  }

  @override
  String get libraryShowFinished => 'show them';

  @override
  String get bookDetailMarkFinished => 'Mark as finished';

  @override
  String get bookDetailMarkReading => 'Mark as reading';

  @override
  String themesBooksCount(int count) {
    return '$count books';
  }

  @override
  String get themesNewThemeLabel => 'New theme';

  @override
  String get themesNewThemeTitle => 'New theme';

  @override
  String get themesNewThemeHint => 'Theme name';

  @override
  String themeDetailStats(int marks, int books, int starred) {
    return '$marks marks in $books books,\n$starred starred';
  }

  @override
  String get themeDetailAddMarks => 'Add marks to this theme';

  @override
  String get themeDetailEmpty => 'No marks in this theme yet.';

  @override
  String get themeAddMarksTitle => 'Add marks';

  @override
  String get themeRenameTitle => 'Rename theme';

  @override
  String get themeDeleteTitle => 'Delete theme?';

  @override
  String get themeDeleteMessage => 'The theme is removed. Your marks and books stay.';

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
  String get bookDeleteMessage => 'This deletes the book and all its marks. This can\'t be undone.';

  @override
  String get markDeleteAction => 'Delete mark';

  @override
  String get markDeleteTitle => 'Delete mark?';

  @override
  String get markDeleteMessage => 'This deletes the mark. This can\'t be undone.';

  @override
  String get libraryNewShelfLabel => 'New shelf';

  @override
  String get libraryNewShelfTitle => 'New shelf';

  @override
  String get libraryNewShelfHint => 'Shelf name';

  @override
  String shelfDetailStats(int books, int marks) {
    return '$books books, $marks marks';
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
  String settingsStats(int books, int marks, int themes) {
    return '$books books\n$marks marks\n$themes themes';
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
  String get settingsLicensesLabel => 'Open-source licenses';
}
