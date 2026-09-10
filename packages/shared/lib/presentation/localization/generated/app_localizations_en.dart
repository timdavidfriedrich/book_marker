// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Commonplace';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';

  @override
  String get undo => 'Undo';

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
  String get errorMicrophonePermission => 'Allow microphone access to record a voice note.';

  @override
  String get errorNotFound => 'Not found.';

  @override
  String get errorRateLimit =>
      'The book catalogue is temporarily unavailable. Please try again later.';

  @override
  String get errorServiceUnavailable => 'The book catalogue did not respond. Please try again.';

  @override
  String get errorUnexpected => 'An unexpected error occurred.';

  @override
  String get libraryTitle => 'Library';

  @override
  String get libraryEmptyMessage => 'No quotes yet. Take a photo of a book page to get started.';

  @override
  String get libraryBooksEmptyMessage =>
      'No books yet. Take a photo of a book page to get started.';

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
  String get librarySearchBooksHint => 'Search books…';

  @override
  String get librarySearchShelvesHint => 'Search shelves…';

  @override
  String get librarySearchQuotesHint => 'Search quotes…';

  @override
  String get libraryTabBooks => 'books';

  @override
  String get libraryTabShelves => 'shelves';

  @override
  String get libraryTabQuotes => 'quotes';

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
  String libraryFilterFavorites(int count) {
    return 'favorites $count';
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
  String libraryBooksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count books',
      one: '1 book',
    );
    return '$_temp0';
  }

  @override
  String libraryShelvesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count shelves',
      one: '1 shelf',
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
  String get navLibraryLabel => 'library';

  @override
  String get navThemesLabel => 'themes';

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
  String bookDetailFavoritesFilter(int count) {
    return 'favorites $count';
  }

  @override
  String bookDetailVoiceNoteFilter(int count) {
    return 'with voice note $count';
  }

  @override
  String get bookDetailEmptyMessage => 'No quotes in this book yet.';

  @override
  String get captureGalleryLabel => 'from gallery';

  @override
  String get captureGalleryPlaceholder => 'Importing from the gallery is coming soon.';

  @override
  String get captureLightOn => 'light on';

  @override
  String get captureLightOff => 'light off';

  @override
  String get cropAdjustHint => 'Adjust corners, if needed';

  @override
  String get cropUnsureTitle => 'Check edges';

  @override
  String get cropRotateLabel => 'Rotate page';

  @override
  String get cropAddPageLabel => 'Add page';

  @override
  String cropPageLabel(int number) {
    return 'Page $number';
  }

  @override
  String get cropRemovePageButton => 'Remove page';

  @override
  String get cropRemovePageTitle => 'Remove page?';

  @override
  String get cropRemovePageMessage => 'The photo of this page is discarded.';

  @override
  String get cropCancelTitle => 'Discard capture?';

  @override
  String get cropCancelMessage => 'All captured pages are discarded.';

  @override
  String get cropCancelConfirmButton => 'Discard capture';

  @override
  String get markingAddBookButton => 'Add new book';

  @override
  String get cropLoadingMessage => 'Finding the page…';

  @override
  String cropContinueButton(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continue with $count pages',
      one: 'Continue with 1 page',
    );
    return '$_temp0';
  }

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
  String get markingSaveSheetTitle => 'Save this quote';

  @override
  String get pageFieldLabel => 'Page';

  @override
  String get pageFieldHint => 'Add';

  @override
  String get markingNoteHint => 'write a note…';

  @override
  String get voiceNoteHint => 'add voice note';

  @override
  String get markingUncertainLegend => '= uncertain words, tap to correct';

  @override
  String get markingCorrectionTitle => 'Is this word correct?';

  @override
  String get markingCorrectionFirstWordLabel => 'first word of the text';

  @override
  String get markingCorrectionLastWordLabel => 'last word of the text';

  @override
  String get markingCorrectionNoNeighbourLabel => '–';

  @override
  String get markingCorrectionJoinPreviousButton => 'Join with the word before';

  @override
  String get markingCorrectionJoinNextButton => 'Join with the word after';

  @override
  String get markingCorrectionUndoJoinButton => 'undo';

  @override
  String get markingCorrectionClearButton => 'Clear the word';

  @override
  String get markingCorrectionAppliedMessage => 'Word corrected';

  @override
  String get markingCorrectionApplyButton => 'Apply';

  @override
  String markingUnsureWordsLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count words may be misread',
      one: '1 word may be misread',
    );
    return '$_temp0';
  }

  @override
  String get markingNewThemeChip => '+ new';

  @override
  String get quoteDetailNotePlaceholder => 'Add a note — coming soon.';

  @override
  String get quoteDetailFavoriteLabel => 'favorite';

  @override
  String get quoteDetailShareButton => 'Share quote';

  @override
  String quoteShareBody(String quote, String source) {
    return '“$quote”\n\n— $source';
  }

  @override
  String get quoteDetailMoreLabel => 'more';

  @override
  String get quoteDetailQuoteHint => 'Write the quote…';

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
  String get themesNewThemeButton => 'Create theme';

  @override
  String get themeDetailAddQuotes => 'Add quotes to this theme';

  @override
  String get themeDetailEmpty => 'No quotes in this theme yet.';

  @override
  String get themeAddQuotesTitle => 'Add quotes';

  @override
  String get themeRenameTitle => 'Rename theme';

  @override
  String get themeDeleteAction => 'Delete theme';

  @override
  String get themeDeleteTitle => 'Delete theme?';

  @override
  String get themeDeleteMessage => 'The theme is removed. Your quotes and books stay.';

  @override
  String get shelfRenameTitle => 'Rename shelf';

  @override
  String get shelfDeleteAction => 'Delete shelf';

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
  String get voiceNoteDeleteAction => 'Delete voice note';

  @override
  String get voiceNoteDeleteTitle => 'Delete voice note?';

  @override
  String get voiceNoteDeleteMessage => 'This deletes the recording. This can\'t be undone.';

  @override
  String get quoteEditAction => 'Edit quote';

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
  String get libraryNewShelfButton => 'Create shelf';

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
  String get settingsAppearanceLabel => 'Appearance';

  @override
  String get settingsColorSchemeLabel => 'Color scheme';

  @override
  String get settingsColorSchemeSystem => 'System';

  @override
  String get settingsColorSchemeLight => 'Light';

  @override
  String get settingsColorSchemeDark => 'Dark';

  @override
  String get settingsContrastLabel => 'Contrast';

  @override
  String get settingsContrastSystem => 'System';

  @override
  String get settingsContrastStandard => 'Standard';

  @override
  String get settingsContrastHigh => 'High';

  @override
  String get settingsLanguageLabel => 'Language';

  @override
  String get settingsLanguageSystem => 'System';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageGerman => 'German';

  @override
  String settingsLanguageSystemValue(String language) {
    return 'System ($language)';
  }

  @override
  String get settingsAboutLabel => 'About this app';

  @override
  String get settingsVersionLabel => 'Version';

  @override
  String get filterNoResultsMessage => 'Nothing matches this filter.';

  @override
  String get markingBookPickerTitle => 'Choose book';

  @override
  String get quoteDetailAddThemeChip => '+ theme';

  @override
  String get quoteDetailThemePickerTitle => 'Themes';

  @override
  String get settingsLicensesLabel => 'Open-source licenses';

  @override
  String get settingsDebugLabel => 'Debug';

  @override
  String get settingsSeedSampleDataButton => 'Load sample data';

  @override
  String get showMore => 'show more';

  @override
  String get showLess => 'show less';

  @override
  String get errorAccountBlocked => 'Account suspended. Sync and cloud OCR are paused.';

  @override
  String get errorSignInCancelled => 'Cancelled. Nothing changed.';

  @override
  String get signInTitle => 'Secure your data';

  @override
  String get signInLead =>
      'Your library sits encrypted on the server. You will not notice it day to day. You only need the code from the next step when restoring on a new device.';

  @override
  String get signInWithGoogle => 'Continue with Google';

  @override
  String get signInWithApple => 'Continue with Apple';

  @override
  String get signInRetry => 'Try again';

  @override
  String get signInCancel => 'Cancel';

  @override
  String get signInInProgress => 'Signing in…';

  @override
  String get recoveryCodeTitle => 'Your recovery code';

  @override
  String get recoveryCodeLead => 'It is the only key to your secured library. We do not have it.';

  @override
  String get recoveryCodeCopy => 'Copy code';

  @override
  String get recoveryCodeCopyAgain => 'Copy again';

  @override
  String get recoveryCodeCopied => 'Copied';

  @override
  String get recoveryCodeShare => 'Share';

  @override
  String get recoveryCodeConsequenceTitle => 'If the code is gone, the secured library is gone.';

  @override
  String get recoveryCodeConsequenceReset => 'We cannot reset it and cannot look it up.';

  @override
  String get recoveryCodeConsequenceDevice => 'After a device change Commonplace asks for it.';

  @override
  String get recoveryCodeConsequenceClipboard =>
      'It will not survive the next copy in your clipboard. Save it somewhere safe.';

  @override
  String get recoveryCodeConfirm => 'I have saved the code';

  @override
  String get recoveryCodeContinue => 'Continue';

  @override
  String get recoveryCodeStart => 'Start securing';

  @override
  String get recoveryCodeLeaveTitle => 'No backup without a saved code';

  @override
  String get recoveryCodeLeaveMessage =>
      'The code cannot be generated again later. If you leave now your library stays on this device and is not secured.';

  @override
  String get recoveryCodeLeaveBack => 'Back to the code';

  @override
  String get recoveryCodeLeaveAbort => 'Cancel securing';

  @override
  String get unlockTitle => 'Unlock library';

  @override
  String get unlockLead => 'The key is missing on this device. Your secured data is safe.';

  @override
  String get unlockAction => 'Unlock';

  @override
  String get unlockRetry => 'Check again';

  @override
  String get unlockWrongCode => 'That code is not right. Check your entry and try again.';

  @override
  String get unlockUnreachableTitle => 'Server unreachable';

  @override
  String get unlockUnreachableBody =>
      'The code is checked against your backup, and that needs a connection for a moment.';

  @override
  String get unlockUnreachableAction => 'Try again';

  @override
  String get unlockNoBackupTitle => 'No backup yet';

  @override
  String get unlockNoBackupBody =>
      'No code has been created for this account. Set up the backup and your library is stored encrypted on the server.';

  @override
  String get unlockNoBackupAction => 'Set up backup';

  @override
  String get sicherungSetUpTitle => 'Backup not finished';

  @override
  String get sicherungSetUpBody =>
      'Your library lives on this device only. Create the recovery code so you can get it back after switching devices.';

  @override
  String get sicherungSetUpCta => 'Create code';

  @override
  String get recoveryCodeUnreachable =>
      'The server cannot be reached. The backup cannot be started without it.';

  @override
  String get recoveryCodeAlreadySecured =>
      'This account already has a backup. Enter the existing code.';

  @override
  String get sicherungLabel => 'Backup';

  @override
  String get sicherungSignInCta => 'Sign in to secure your data';

  @override
  String get sicherungSignedOut => 'Not signed in';

  @override
  String get sicherungSecured => 'Secured';

  @override
  String get syncStatusSyncing => 'Backing up';

  @override
  String get syncStatusSynced => 'Backed up';

  @override
  String get syncStatusOffline => 'Offline · waiting';

  @override
  String get syncStatusFailed => 'Backup failed';

  @override
  String get syncStatusRetry => 'Retry';

  @override
  String get syncStatusOfflineShort => 'Offline';

  @override
  String get syncStatusFailedShort => 'Failed';

  @override
  String get syncStatusNever => 'Not backed up yet';

  @override
  String get sicherungLockedTitle => 'Locked on this device';

  @override
  String get sicherungLockedBody =>
      'The key was lost when the device was reset. Your library is fully secured, it just cannot be read without the code.';

  @override
  String get sicherungLockedCta => 'Enter code';

  @override
  String get sicherungBlockedTitle => 'Account suspended';

  @override
  String get sicherungBlockedBody =>
      'Sync and cloud OCR are paused. Everything still works on this device: reading, capturing, editing, exporting.';

  @override
  String get sicherungBlockedCta => 'Contact support';

  @override
  String get sicherungSignOut => 'Sign out';

  @override
  String get deleteAccountTitle => 'Delete account';

  @override
  String get deleteAccountLead => 'Permanent, with no way back. Deletion happens within 30 days.';

  @override
  String get deleteAccountRemovedTitle => 'What goes';

  @override
  String get deleteAccountRemovedIdentity => 'Account, e-mail and key';

  @override
  String get deleteAccountRemovedLibrary => 'The backed-up library on the server';

  @override
  String get deleteAccountRemovedUsage => 'Cloud OCR quota and logs';

  @override
  String get deleteAccountKeptTitle => 'What stays';

  @override
  String get deleteAccountKeptLibrary => 'Your library on this device';

  @override
  String get deleteAccountAction => 'Delete account';

  @override
  String get deleteAccountDialogTitle => 'Delete account and backed-up library';

  @override
  String get deleteAccountDialogBody =>
      'Your library on the server will be deleted. This cannot be undone.';

  @override
  String get deleteAccountConfirmAction => 'Delete permanently';

  @override
  String get deleteAccountFailed =>
      'The account could not be deleted. Check your connection and try again.';

  @override
  String get signOutTitle => 'Sign out';

  @override
  String get signOutQuestion => 'What should happen to the library on this device?';

  @override
  String get signOutKeepTitle => 'Keep on this device';

  @override
  String get signOutKeepBody => 'Local data stays, backup pauses';

  @override
  String get signOutRemoveTitle => 'Remove from this device';

  @override
  String get signOutRemoveBody => 'Delete everything locally, backup pauses';

  @override
  String get signOutRemoveWarning =>
      'Only this device is emptied. The backup remains, and your code brings it back.';

  @override
  String signOutConfirmHint(String word) {
    return 'Type $word to continue';
  }

  @override
  String get signOutConfirmWord => 'CONFIRM';

  @override
  String get signOutRemoveAction => 'Remove and sign out';
}
