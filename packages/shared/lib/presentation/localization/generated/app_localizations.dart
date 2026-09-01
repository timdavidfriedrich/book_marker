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

  /// No description provided for @commonRename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get commonRename;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonChangeMark.
  ///
  /// In en, this message translates to:
  /// **'Change mark'**
  String get commonChangeMark;

  /// No description provided for @markPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a mark'**
  String get markPickerTitle;

  /// No description provided for @markPickerSymbolLabel.
  ///
  /// In en, this message translates to:
  /// **'symbol'**
  String get markPickerSymbolLabel;

  /// No description provided for @markPickerColorLabel.
  ///
  /// In en, this message translates to:
  /// **'color'**
  String get markPickerColorLabel;

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
  /// **'No quotes yet. Take a photo of a book page to get started.'**
  String get libraryEmptyMessage;

  /// No description provided for @libraryBooksEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No books yet. Take a photo of a book page to get started.'**
  String get libraryBooksEmptyMessage;

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
  /// **'Save quote'**
  String get markingSaveButton;

  /// No description provided for @markingSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Quote saved.'**
  String get markingSavedMessage;

  /// No description provided for @markingSelectPrompt.
  ///
  /// In en, this message translates to:
  /// **'Select at least one line to save.'**
  String get markingSelectPrompt;

  /// No description provided for @quoteDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get quoteDetailTitle;

  /// No description provided for @quoteDetailQuoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get quoteDetailQuoteLabel;

  /// No description provided for @quoteDetailPageLabel.
  ///
  /// In en, this message translates to:
  /// **'Page {page}'**
  String quoteDetailPageLabel(int page);

  /// No description provided for @quoteDetailNoPage.
  ///
  /// In en, this message translates to:
  /// **'No page number'**
  String get quoteDetailNoPage;

  /// No description provided for @quoteDetailFavoriteAdd.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get quoteDetailFavoriteAdd;

  /// No description provided for @quoteDetailFavoriteRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get quoteDetailFavoriteRemove;

  /// No description provided for @librarySearchBooksHint.
  ///
  /// In en, this message translates to:
  /// **'Search books…'**
  String get librarySearchBooksHint;

  /// No description provided for @librarySearchShelvesHint.
  ///
  /// In en, this message translates to:
  /// **'Search shelves…'**
  String get librarySearchShelvesHint;

  /// No description provided for @librarySearchQuotesHint.
  ///
  /// In en, this message translates to:
  /// **'Search quotes…'**
  String get librarySearchQuotesHint;

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

  /// No description provided for @libraryTabQuotes.
  ///
  /// In en, this message translates to:
  /// **'quotes'**
  String get libraryTabQuotes;

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

  /// No description provided for @libraryFilterPaused.
  ///
  /// In en, this message translates to:
  /// **'paused {count}'**
  String libraryFilterPaused(int count);

  /// No description provided for @libraryFilterFinished.
  ///
  /// In en, this message translates to:
  /// **'finished {count}'**
  String libraryFilterFinished(int count);

  /// No description provided for @libraryFilterFavorites.
  ///
  /// In en, this message translates to:
  /// **'favorites {count}'**
  String libraryFilterFavorites(int count);

  /// No description provided for @libraryQuotesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 quote} other{{count} quotes}}'**
  String libraryQuotesCount(int count);

  /// No description provided for @libraryBooksCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 book} other{{count} books}}'**
  String libraryBooksCount(int count);

  /// No description provided for @libraryShelvesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 shelf} other{{count} shelves}}'**
  String libraryShelvesCount(int count);

  /// No description provided for @libraryFavoritesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 favorite} other{{count} favorites}}'**
  String libraryFavoritesCount(int count);

  /// No description provided for @libraryStatusReading.
  ///
  /// In en, this message translates to:
  /// **'reading'**
  String get libraryStatusReading;

  /// No description provided for @libraryStatusPaused.
  ///
  /// In en, this message translates to:
  /// **'paused'**
  String get libraryStatusPaused;

  /// No description provided for @libraryShelvesPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Shelves arrive in the next update.'**
  String get libraryShelvesPlaceholder;

  /// No description provided for @libraryBookMeta.
  ///
  /// In en, this message translates to:
  /// **'{quotes, plural, =1{1 quote} other{{quotes} quotes}}, {favorites, plural, =1{1 favorite} other{{favorites} favorites}}'**
  String libraryBookMeta(int quotes, int favorites);

  /// No description provided for @libraryBookMetaWithStatus.
  ///
  /// In en, this message translates to:
  /// **'{quotes, plural, =1{1 quote} other{{quotes} quotes}}, {favorites, plural, =1{1 favorite} other{{favorites} favorites}},\n{status}'**
  String libraryBookMetaWithStatus(int quotes, int favorites, String status);

  /// No description provided for @libraryShelfMeta.
  ///
  /// In en, this message translates to:
  /// **'{books, plural, =1{1 book} other{{books} books}}, {quotes, plural, =1{1 quote} other{{quotes} quotes}}'**
  String libraryShelfMeta(int books, int quotes);

  /// No description provided for @quoteSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'{title}, p.{pages}'**
  String quoteSourceLabel(String title, String pages);

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
  /// **'p.{pages}'**
  String pageShortLabel(String pages);

  /// No description provided for @quoteVoiceNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'voice note {duration}'**
  String quoteVoiceNoteLabel(String duration);

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
  /// **'Gather quotes across your books'**
  String get themesSubtitlePlaceholder;

  /// No description provided for @themesPlaceholderMessage.
  ///
  /// In en, this message translates to:
  /// **'Themes gather quotes from across your books. They arrive in the next update.'**
  String get themesPlaceholderMessage;

  /// No description provided for @bookDetailAllFilter.
  ///
  /// In en, this message translates to:
  /// **'all {count}'**
  String bookDetailAllFilter(int count);

  /// No description provided for @bookDetailFavoritesFilter.
  ///
  /// In en, this message translates to:
  /// **'favorites'**
  String get bookDetailFavoritesFilter;

  /// No description provided for @bookDetailVoiceNoteFilter.
  ///
  /// In en, this message translates to:
  /// **'with voice note'**
  String get bookDetailVoiceNoteFilter;

  /// No description provided for @bookDetailQuotesStat.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 quote} other{{count} quotes}}'**
  String bookDetailQuotesStat(int count);

  /// No description provided for @bookDetailFavoritesStat.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 favorite} other{{count} favorites}}'**
  String bookDetailFavoritesStat(int count);

  /// No description provided for @bookDetailEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No quotes in this book yet.'**
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

  /// No description provided for @captureModeAuto.
  ///
  /// In en, this message translates to:
  /// **'auto'**
  String get captureModeAuto;

  /// No description provided for @captureModeManual.
  ///
  /// In en, this message translates to:
  /// **'manual'**
  String get captureModeManual;

  /// No description provided for @cropTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark the page'**
  String get cropTitle;

  /// No description provided for @cropHint.
  ///
  /// In en, this message translates to:
  /// **'drag the dots onto the page corners'**
  String get cropHint;

  /// No description provided for @cropLoadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Finding the page…'**
  String get cropLoadingMessage;

  /// No description provided for @cropContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get cropContinueButton;

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

  /// No description provided for @pageFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'page'**
  String get pageFieldLabel;

  /// No description provided for @pageFieldHint.
  ///
  /// In en, this message translates to:
  /// **'42–43'**
  String get pageFieldHint;

  /// No description provided for @pageAutoLabel.
  ///
  /// In en, this message translates to:
  /// **'auto'**
  String get pageAutoLabel;

  /// No description provided for @markingNoteHint.
  ///
  /// In en, this message translates to:
  /// **'add a note'**
  String get markingNoteHint;

  /// No description provided for @markingVoiceNoteHint.
  ///
  /// In en, this message translates to:
  /// **'voice note'**
  String get markingVoiceNoteHint;

  /// No description provided for @markingDoneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get markingDoneButton;

  /// No description provided for @markingUncertainLegend.
  ///
  /// In en, this message translates to:
  /// **'= uncertain words, tap to correct'**
  String get markingUncertainLegend;

  /// No description provided for @markingCorrectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Unsure word'**
  String get markingCorrectionTitle;

  /// No description provided for @markingCorrectionHint.
  ///
  /// In en, this message translates to:
  /// **'compare it with the photo and fix what the scan got wrong'**
  String get markingCorrectionHint;

  /// No description provided for @markingJoinNextButton.
  ///
  /// In en, this message translates to:
  /// **'Join with “{word}” after'**
  String markingJoinNextButton(String word);

  /// No description provided for @markingJoinPreviousButton.
  ///
  /// In en, this message translates to:
  /// **'Join with “{word}” before'**
  String markingJoinPreviousButton(String word);

  /// No description provided for @markingCorrectionApplyButton.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get markingCorrectionApplyButton;

  /// No description provided for @markingUnsureWordsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 word may be misread — check the quote} other{{count} words may be misread — check the quote}}'**
  String markingUnsureWordsLabel(int count);

  /// No description provided for @markingNewThemeChip.
  ///
  /// In en, this message translates to:
  /// **'+ new'**
  String get markingNewThemeChip;

  /// No description provided for @quoteDetailPhotoMeta.
  ///
  /// In en, this message translates to:
  /// **'p.{pages}, shot {date}'**
  String quoteDetailPhotoMeta(String pages, String date);

  /// No description provided for @quoteDetailShotMeta.
  ///
  /// In en, this message translates to:
  /// **'shot {date}'**
  String quoteDetailShotMeta(String date);

  /// No description provided for @quoteDetailNotePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Add a note — coming soon.'**
  String get quoteDetailNotePlaceholder;

  /// No description provided for @quoteDetailFavoriteLabel.
  ///
  /// In en, this message translates to:
  /// **'favorite'**
  String get quoteDetailFavoriteLabel;

  /// No description provided for @quoteDetailShareLabel.
  ///
  /// In en, this message translates to:
  /// **'share'**
  String get quoteDetailShareLabel;

  /// No description provided for @quoteShareBody.
  ///
  /// In en, this message translates to:
  /// **'“{quote}”\n\n— {source}'**
  String quoteShareBody(String quote, String source);

  /// No description provided for @quoteDetailMoreLabel.
  ///
  /// In en, this message translates to:
  /// **'more'**
  String get quoteDetailMoreLabel;

  /// No description provided for @quoteDetailNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Add a note…'**
  String get quoteDetailNoteHint;

  /// No description provided for @libraryStatusFinished.
  ///
  /// In en, this message translates to:
  /// **'finished'**
  String get libraryStatusFinished;

  /// No description provided for @libraryFinishedFooter.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 finished book} other{{count} finished books}}'**
  String libraryFinishedFooter(int count);

  /// No description provided for @libraryShowFinished.
  ///
  /// In en, this message translates to:
  /// **'show them'**
  String get libraryShowFinished;

  /// No description provided for @bookDetailMarkFinished.
  ///
  /// In en, this message translates to:
  /// **'Mark as finished'**
  String get bookDetailMarkFinished;

  /// No description provided for @bookDetailMarkReading.
  ///
  /// In en, this message translates to:
  /// **'Mark as reading'**
  String get bookDetailMarkReading;

  /// No description provided for @bookDetailMarkPaused.
  ///
  /// In en, this message translates to:
  /// **'Mark as paused'**
  String get bookDetailMarkPaused;

  /// No description provided for @themesBooksCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 book} other{{count} books}}'**
  String themesBooksCount(int count);

  /// No description provided for @themesThemeMeta.
  ///
  /// In en, this message translates to:
  /// **'{quotes, plural, =1{1 quote} other{{quotes} quotes}}, {books, plural, =1{1 book} other{{books} books}}'**
  String themesThemeMeta(int quotes, int books);

  /// No description provided for @themesNewThemeLabel.
  ///
  /// In en, this message translates to:
  /// **'New theme'**
  String get themesNewThemeLabel;

  /// No description provided for @themesNewThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'New theme'**
  String get themesNewThemeTitle;

  /// No description provided for @themesNewThemeHint.
  ///
  /// In en, this message translates to:
  /// **'Theme name'**
  String get themesNewThemeHint;

  /// No description provided for @themeDetailStats.
  ///
  /// In en, this message translates to:
  /// **'{quotes, plural, =1{1 quote} other{{quotes} quotes}} in {books, plural, =1{1 book} other{{books} books}}, {favorites, plural, =1{1 favorite} other{{favorites} favorites}}'**
  String themeDetailStats(int quotes, int books, int favorites);

  /// No description provided for @themeDetailAddQuotes.
  ///
  /// In en, this message translates to:
  /// **'Add quotes to this theme'**
  String get themeDetailAddQuotes;

  /// No description provided for @themeDetailEmpty.
  ///
  /// In en, this message translates to:
  /// **'No quotes in this theme yet.'**
  String get themeDetailEmpty;

  /// No description provided for @themeAddQuotesTitle.
  ///
  /// In en, this message translates to:
  /// **'Add quotes'**
  String get themeAddQuotesTitle;

  /// No description provided for @themeRenameTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename theme'**
  String get themeRenameTitle;

  /// No description provided for @themeDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete theme?'**
  String get themeDeleteTitle;

  /// No description provided for @themeDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'The theme is removed. Your quotes and books stay.'**
  String get themeDeleteMessage;

  /// No description provided for @shelfRenameTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename shelf'**
  String get shelfRenameTitle;

  /// No description provided for @shelfDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete shelf?'**
  String get shelfDeleteTitle;

  /// No description provided for @shelfDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'The shelf is removed. Your books stay.'**
  String get shelfDeleteMessage;

  /// No description provided for @bookDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete book'**
  String get bookDeleteAction;

  /// No description provided for @bookDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete book?'**
  String get bookDeleteTitle;

  /// No description provided for @bookDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This deletes the book and all its quotes. This can\'t be undone.'**
  String get bookDeleteMessage;

  /// No description provided for @quoteDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete quote'**
  String get quoteDeleteAction;

  /// No description provided for @quoteDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete quote?'**
  String get quoteDeleteTitle;

  /// No description provided for @quoteDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This deletes the quote. This can\'t be undone.'**
  String get quoteDeleteMessage;

  /// No description provided for @libraryNewShelfLabel.
  ///
  /// In en, this message translates to:
  /// **'New shelf'**
  String get libraryNewShelfLabel;

  /// No description provided for @libraryNewShelfTitle.
  ///
  /// In en, this message translates to:
  /// **'New shelf'**
  String get libraryNewShelfTitle;

  /// No description provided for @libraryNewShelfHint.
  ///
  /// In en, this message translates to:
  /// **'Shelf name'**
  String get libraryNewShelfHint;

  /// No description provided for @shelfDetailStats.
  ///
  /// In en, this message translates to:
  /// **'{books, plural, =1{1 book} other{{books} books}}, {quotes, plural, =1{1 quote} other{{quotes} quotes}}'**
  String shelfDetailStats(int books, int quotes);

  /// No description provided for @shelfDetailAddBooks.
  ///
  /// In en, this message translates to:
  /// **'Add books to this shelf'**
  String get shelfDetailAddBooks;

  /// No description provided for @shelfDetailEmpty.
  ///
  /// In en, this message translates to:
  /// **'No books on this shelf yet.'**
  String get shelfDetailEmpty;

  /// No description provided for @shelfAddBooksTitle.
  ///
  /// In en, this message translates to:
  /// **'Add books'**
  String get shelfAddBooksTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsProfileNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get settingsProfileNameHint;

  /// No description provided for @settingsStats.
  ///
  /// In en, this message translates to:
  /// **'{books, plural, =1{1 book} other{{books} books}}, {quotes, plural, =1{1 quote} other{{quotes} quotes}}, {themes, plural, =1{1 theme} other{{themes} themes}}'**
  String settingsStats(int books, int quotes, int themes);

  /// No description provided for @settingsLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageLabel;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get settingsLanguageGerman;

  /// No description provided for @settingsAboutLabel.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutLabel;

  /// No description provided for @settingsVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsVersionLabel(String version);

  /// No description provided for @filterNoResultsMessage.
  ///
  /// In en, this message translates to:
  /// **'Nothing matches this filter.'**
  String get filterNoResultsMessage;

  /// No description provided for @libraryBookMetaStatus.
  ///
  /// In en, this message translates to:
  /// **'{quotes, plural, =1{1 quote} other{{quotes} quotes}},\n{status}'**
  String libraryBookMetaStatus(int quotes, String status);

  /// No description provided for @markingBookFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'book'**
  String get markingBookFieldLabel;

  /// No description provided for @markingBookPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose book'**
  String get markingBookPickerTitle;

  /// No description provided for @quoteDetailAddThemeChip.
  ///
  /// In en, this message translates to:
  /// **'+ add'**
  String get quoteDetailAddThemeChip;

  /// No description provided for @quoteDetailThemePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get quoteDetailThemePickerTitle;

  /// No description provided for @settingsLicensesLabel.
  ///
  /// In en, this message translates to:
  /// **'Open-source licenses'**
  String get settingsLicensesLabel;

  /// No description provided for @captureSpreadHint.
  ///
  /// In en, this message translates to:
  /// **'photograph every page the quote runs across'**
  String get captureSpreadHint;

  /// No description provided for @captureSpreadShotsHint.
  ///
  /// In en, this message translates to:
  /// **'tap to remove · hold to reorder'**
  String get captureSpreadShotsHint;

  /// No description provided for @captureSpreadContinueButton.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Continue with 1 page} other{Continue with {count} pages}}'**
  String captureSpreadContinueButton(int count);

  /// No description provided for @captureSpreadRemoveLabel.
  ///
  /// In en, this message translates to:
  /// **'Remove page'**
  String get captureSpreadRemoveLabel;

  /// No description provided for @quoteDetailNoPhotoMessage.
  ///
  /// In en, this message translates to:
  /// **'No photo was saved with this quote.'**
  String get quoteDetailNoPhotoMessage;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'show more'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'show less'**
  String get showLess;

  /// No description provided for @quoteDetailSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'source'**
  String get quoteDetailSourceLabel;

  /// No description provided for @quoteDetailNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'my thoughts'**
  String get quoteDetailNotesLabel;
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
