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
  String get libraryTitle => 'Your marks';

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
}
