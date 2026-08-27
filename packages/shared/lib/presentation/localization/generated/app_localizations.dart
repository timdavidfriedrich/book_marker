import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('de'), Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Book Marker'**
  String get appTitle;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get errorConnection;

  /// No description provided for @errorApi.
  ///
  /// In en, this message translates to:
  /// **'Error while communicating with the server: {message}.'**
  String errorApi(String message);

  /// No description provided for @errorAuth.
  ///
  /// In en, this message translates to:
  /// **'You are not signed in.'**
  String get errorAuth;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'The data received is invalid.'**
  String get errorValidation;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Not found.'**
  String get errorNotFound;

  /// No description provided for @errorUnexpected.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get errorUnexpected;

  /// No description provided for @libraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryTitle;

  /// No description provided for @libraryEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No marks yet. Take a photo of a book page to get started.'**
  String get libraryEmptyMessage;

  /// No description provided for @libraryUnknownBook.
  ///
  /// In en, this message translates to:
  /// **'Unknown book'**
  String get libraryUnknownBook;

  /// No description provided for @libraryPageLabel.
  ///
  /// In en, this message translates to:
  /// **'Page {page}'**
  String libraryPageLabel(int page);

  /// No description provided for @libraryNoPageLabel.
  ///
  /// In en, this message translates to:
  /// **'No page'**
  String get libraryNoPageLabel;

  /// No description provided for @bookAuthorsUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown author'**
  String get bookAuthorsUnknown;

  /// No description provided for @captureTitle.
  ///
  /// In en, this message translates to:
  /// **'Capture page'**
  String get captureTitle;

  /// No description provided for @captureSelectBookHint.
  ///
  /// In en, this message translates to:
  /// **'Select book'**
  String get captureSelectBookHint;

  /// No description provided for @captureNoBooksMessage.
  ///
  /// In en, this message translates to:
  /// **'Add a book first to start marking pages.'**
  String get captureNoBooksMessage;

  /// No description provided for @captureAddBookButton.
  ///
  /// In en, this message translates to:
  /// **'Add book'**
  String get captureAddBookButton;

  /// No description provided for @captureShutterLabel.
  ///
  /// In en, this message translates to:
  /// **'Capture page'**
  String get captureShutterLabel;

  /// No description provided for @captureCameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The camera is not available on this device.'**
  String get captureCameraUnavailable;

  /// No description provided for @addBookTitle.
  ///
  /// In en, this message translates to:
  /// **'Add book'**
  String get addBookTitle;

  /// No description provided for @addBookSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by title, author or ISBN'**
  String get addBookSearchHint;

  /// No description provided for @addBookScanButton.
  ///
  /// In en, this message translates to:
  /// **'Scan barcode'**
  String get addBookScanButton;

  /// No description provided for @addBookInitialMessage.
  ///
  /// In en, this message translates to:
  /// **'Search for a book or scan its barcode.'**
  String get addBookInitialMessage;

  /// No description provided for @addBookEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No books found. Try another search.'**
  String get addBookEmptyMessage;

  /// No description provided for @barcodeScannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan barcode'**
  String get barcodeScannerTitle;

  /// No description provided for @barcodeScannerHint.
  ///
  /// In en, this message translates to:
  /// **'Point the camera at the book\'s barcode.'**
  String get barcodeScannerHint;

  /// No description provided for @markingTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark page'**
  String get markingTitle;

  /// No description provided for @markingProcessingMessage.
  ///
  /// In en, this message translates to:
  /// **'Reading text…'**
  String get markingProcessingMessage;

  /// No description provided for @markingInstruction.
  ///
  /// In en, this message translates to:
  /// **'Tap the lines you want to mark.'**
  String get markingInstruction;

  /// No description provided for @markingNoTextMessage.
  ///
  /// In en, this message translates to:
  /// **'No text was found on this page.'**
  String get markingNoTextMessage;

  /// No description provided for @markingPageNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Page number'**
  String get markingPageNumberLabel;

  /// No description provided for @markingPageNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Add page number'**
  String get markingPageNumberHint;

  /// No description provided for @markingPageNumberMissing.
  ///
  /// In en, this message translates to:
  /// **'Page number not detected. Add it manually.'**
  String get markingPageNumberMissing;

  /// No description provided for @markingSelectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Selected text'**
  String get markingSelectedLabel;

  /// No description provided for @markingNothingSelectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Nothing selected yet.'**
  String get markingNothingSelectedMessage;

  /// No description provided for @markingSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save mark'**
  String get markingSaveButton;

  /// No description provided for @markingSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Mark saved.'**
  String get markingSavedMessage;

  /// No description provided for @markingSelectPrompt.
  ///
  /// In en, this message translates to:
  /// **'Select at least one line to save.'**
  String get markingSelectPrompt;

  /// No description provided for @bookmarkDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark'**
  String get bookmarkDetailTitle;

  /// No description provided for @bookmarkDetailQuoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Marked text'**
  String get bookmarkDetailQuoteLabel;

  /// No description provided for @bookmarkDetailPageLabel.
  ///
  /// In en, this message translates to:
  /// **'Page {page}'**
  String bookmarkDetailPageLabel(int page);

  /// No description provided for @bookmarkDetailNoPage.
  ///
  /// In en, this message translates to:
  /// **'No page number'**
  String get bookmarkDetailNoPage;

  /// No description provided for @bookmarkDetailFavoriteAdd.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get bookmarkDetailFavoriteAdd;

  /// No description provided for @bookmarkDetailFavoriteRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get bookmarkDetailFavoriteRemove;

  /// No description provided for @libraryHeaderStats.
  ///
  /// In en, this message translates to:
  /// **'{books} books · {marks} marks'**
  String libraryHeaderStats(int books, int marks);

  /// No description provided for @librarySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search books and marks…'**
  String get librarySearchHint;

  /// No description provided for @libraryTabBooks.
  ///
  /// In en, this message translates to:
  /// **'books'**
  String get libraryTabBooks;

  /// No description provided for @libraryTabShelves.
  ///
  /// In en, this message translates to:
  /// **'shelves'**
  String get libraryTabShelves;

  /// No description provided for @libraryAddShelfLabel.
  ///
  /// In en, this message translates to:
  /// **'+ shelf'**
  String get libraryAddShelfLabel;

  /// No description provided for @libraryFilterAll.
  ///
  /// In en, this message translates to:
  /// **'all {count}'**
  String libraryFilterAll(int count);

  /// No description provided for @libraryFilterReading.
  ///
  /// In en, this message translates to:
  /// **'reading {count}'**
  String libraryFilterReading(int count);

  /// No description provided for @libraryFilterFinished.
  ///
  /// In en, this message translates to:
  /// **'finished {count}'**
  String libraryFilterFinished(int count);

  /// No description provided for @libraryMarksCount.
  ///
  /// In en, this message translates to:
  /// **'{count} marks'**
  String libraryMarksCount(int count);

  /// No description provided for @libraryStarredCount.
  ///
  /// In en, this message translates to:
  /// **'{count} starred'**
  String libraryStarredCount(int count);

  /// No description provided for @libraryStatusReading.
  ///
  /// In en, this message translates to:
  /// **'reading'**
  String get libraryStatusReading;

  /// No description provided for @libraryShelvesPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Shelves arrive in the next update.'**
  String get libraryShelvesPlaceholder;

  /// No description provided for @librarySearchScopeAll.
  ///
  /// In en, this message translates to:
  /// **'all books'**
  String get librarySearchScopeAll;

  /// No description provided for @librarySearchScopeStarred.
  ///
  /// In en, this message translates to:
  /// **'starred'**
  String get librarySearchScopeStarred;

  /// No description provided for @librarySearchScopeNotes.
  ///
  /// In en, this message translates to:
  /// **'my notes'**
  String get librarySearchScopeNotes;

  /// No description provided for @librarySearchCount.
  ///
  /// In en, this message translates to:
  /// **'{marks} marks in {books} books'**
  String librarySearchCount(int marks, int books);

  /// No description provided for @navLibraryLabel.
  ///
  /// In en, this message translates to:
  /// **'library'**
  String get navLibraryLabel;

  /// No description provided for @navThemesLabel.
  ///
  /// In en, this message translates to:
  /// **'themes'**
  String get navThemesLabel;

  /// No description provided for @profileYouLabel.
  ///
  /// In en, this message translates to:
  /// **'you'**
  String get profileYouLabel;

  /// No description provided for @pageShortLabel.
  ///
  /// In en, this message translates to:
  /// **'p.{page}'**
  String pageShortLabel(int page);

  /// No description provided for @markVoiceLabel.
  ///
  /// In en, this message translates to:
  /// **'voice {duration}'**
  String markVoiceLabel(String duration);

  /// No description provided for @comingSoonMessage.
  ///
  /// In en, this message translates to:
  /// **'Coming soon.'**
  String get comingSoonMessage;

  /// No description provided for @themesTitle.
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get themesTitle;

  /// No description provided for @themesSubtitlePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Gather marks across your books'**
  String get themesSubtitlePlaceholder;

  /// No description provided for @themesPlaceholderMessage.
  ///
  /// In en, this message translates to:
  /// **'Themes gather marks from across your books. They arrive in the next update.'**
  String get themesPlaceholderMessage;

  /// No description provided for @bookDetailAllFilter.
  ///
  /// In en, this message translates to:
  /// **'all {count}'**
  String bookDetailAllFilter(int count);

  /// No description provided for @bookDetailStarredFilter.
  ///
  /// In en, this message translates to:
  /// **'starred'**
  String get bookDetailStarredFilter;

  /// No description provided for @bookDetailVoiceFilter.
  ///
  /// In en, this message translates to:
  /// **'with voice'**
  String get bookDetailVoiceFilter;

  /// No description provided for @bookDetailMarksStat.
  ///
  /// In en, this message translates to:
  /// **'{count} marks'**
  String bookDetailMarksStat(int count);

  /// No description provided for @bookDetailStarredStat.
  ///
  /// In en, this message translates to:
  /// **'{count} starred'**
  String bookDetailStarredStat(int count);

  /// No description provided for @bookDetailEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No marks in this book yet.'**
  String get bookDetailEmptyMessage;

  /// No description provided for @captureSteadyHint.
  ///
  /// In en, this message translates to:
  /// **'hold steady for sharper text'**
  String get captureSteadyHint;

  /// No description provided for @captureModeOnePage.
  ///
  /// In en, this message translates to:
  /// **'one page'**
  String get captureModeOnePage;

  /// No description provided for @captureModeSpread.
  ///
  /// In en, this message translates to:
  /// **'spread'**
  String get captureModeSpread;

  /// No description provided for @captureMarkingInto.
  ///
  /// In en, this message translates to:
  /// **'marking into'**
  String get captureMarkingInto;

  /// No description provided for @captureSwitchButton.
  ///
  /// In en, this message translates to:
  /// **'switch'**
  String get captureSwitchButton;

  /// No description provided for @captureGalleryLabel.
  ///
  /// In en, this message translates to:
  /// **'from gallery'**
  String get captureGalleryLabel;

  /// No description provided for @captureGalleryPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Importing from the gallery is coming soon.'**
  String get captureGalleryPlaceholder;

  /// No description provided for @captureLightOn.
  ///
  /// In en, this message translates to:
  /// **'light on'**
  String get captureLightOn;

  /// No description provided for @captureLightOff.
  ///
  /// In en, this message translates to:
  /// **'light off'**
  String get captureLightOff;

  /// No description provided for @addBookQuestionTitle.
  ///
  /// In en, this message translates to:
  /// **'Which book is this?'**
  String get addBookQuestionTitle;

  /// No description provided for @addBookInLibraryLabel.
  ///
  /// In en, this message translates to:
  /// **'in your library'**
  String get addBookInLibraryLabel;

  /// No description provided for @addBookNotInLibraryLabel.
  ///
  /// In en, this message translates to:
  /// **'not in your library, yet'**
  String get addBookNotInLibraryLabel;

  /// No description provided for @addBookSelectButton.
  ///
  /// In en, this message translates to:
  /// **'select'**
  String get addBookSelectButton;

  /// No description provided for @addBookAddButton.
  ///
  /// In en, this message translates to:
  /// **'+ add'**
  String get addBookAddButton;

  /// No description provided for @addBookCatalogueFooter.
  ///
  /// In en, this message translates to:
  /// **'Catalogue results arrive from an online book service. No match? Scan the barcode, or type the title yourself.'**
  String get addBookCatalogueFooter;

  /// No description provided for @addBookNoCatalogueResults.
  ///
  /// In en, this message translates to:
  /// **'No catalogue matches. Scan the barcode or refine your search.'**
  String get addBookNoCatalogueResults;

  /// No description provided for @markingModeText.
  ///
  /// In en, this message translates to:
  /// **'text'**
  String get markingModeText;

  /// No description provided for @markingModePhoto.
  ///
  /// In en, this message translates to:
  /// **'photo'**
  String get markingModePhoto;

  /// No description provided for @markingContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get markingContinueButton;

  /// No description provided for @markingSaveSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Save to {book}'**
  String markingSaveSheetTitle(String book);

  /// No description provided for @markingPageFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'page'**
  String get markingPageFieldLabel;

  /// No description provided for @markingPageAutoLabel.
  ///
  /// In en, this message translates to:
  /// **'auto'**
  String get markingPageAutoLabel;

  /// No description provided for @markingNoteHint.
  ///
  /// In en, this message translates to:
  /// **'what did this land on?'**
  String get markingNoteHint;

  /// No description provided for @markingVoiceHint.
  ///
  /// In en, this message translates to:
  /// **'hold to say it out loud'**
  String get markingVoiceHint;

  /// No description provided for @markingDoneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get markingDoneButton;

  /// No description provided for @bookmarkDetailPhotoMeta.
  ///
  /// In en, this message translates to:
  /// **'page {page} · shot {date}'**
  String bookmarkDetailPhotoMeta(int page, String date);

  /// No description provided for @bookmarkDetailShotMeta.
  ///
  /// In en, this message translates to:
  /// **'shot {date}'**
  String bookmarkDetailShotMeta(String date);

  /// No description provided for @bookmarkDetailNotePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Add a note — coming soon.'**
  String get bookmarkDetailNotePlaceholder;

  /// No description provided for @bookmarkDetailStarredLabel.
  ///
  /// In en, this message translates to:
  /// **'starred'**
  String get bookmarkDetailStarredLabel;

  /// No description provided for @bookmarkDetailShareLabel.
  ///
  /// In en, this message translates to:
  /// **'share'**
  String get bookmarkDetailShareLabel;

  /// No description provided for @bookmarkDetailMoreLabel.
  ///
  /// In en, this message translates to:
  /// **'more'**
  String get bookmarkDetailMoreLabel;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
