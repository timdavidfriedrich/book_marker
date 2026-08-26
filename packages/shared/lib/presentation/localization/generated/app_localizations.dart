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
  /// **'Your marks'**
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
