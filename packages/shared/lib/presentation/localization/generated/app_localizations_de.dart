// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Book Marker';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get close => 'Schließen';

  @override
  String get back => 'Zurück';

  @override
  String get save => 'Speichern';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get commonRename => 'Umbenennen';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonChangeMark => 'Markierung ändern';

  @override
  String get markPickerTitle => 'Markierung wählen';

  @override
  String get markPickerSymbolLabel => 'Symbol';

  @override
  String get markPickerColorLabel => 'Farbe';

  @override
  String get error => 'Fehler';

  @override
  String get errorConnection => 'Keine Internetverbindung.';

  @override
  String errorApi(String message) {
    return 'Fehler bei der Kommunikation mit dem Server: $message.';
  }

  @override
  String get errorAuth => 'Du bist nicht angemeldet.';

  @override
  String get errorValidation => 'Die empfangenen Daten sind ungültig.';

  @override
  String get errorMicrophonePermission =>
      'Erlaube den Mikrofonzugriff, um eine Sprachnotiz aufzunehmen.';

  @override
  String get errorNotFound => 'Nicht gefunden.';

  @override
  String get errorUnexpected => 'Ein unerwarteter Fehler ist aufgetreten.';

  @override
  String get libraryTitle => 'Bibliothek';

  @override
  String get libraryEmptyMessage =>
      'Noch keine Zitate. Fotografiere eine Buchseite, um zu beginnen.';

  @override
  String get libraryBooksEmptyMessage =>
      'Noch keine Bücher. Fotografiere eine Buchseite, um zu beginnen.';

  @override
  String get libraryUnknownBook => 'Unbekanntes Buch';

  @override
  String libraryPageLabel(int page) {
    return 'Seite $page';
  }

  @override
  String get libraryNoPageLabel => 'Keine Seite';

  @override
  String get bookAuthorsUnknown => 'Unbekannter Autor';

  @override
  String get captureTitle => 'Seite aufnehmen';

  @override
  String get captureSelectBookHint => 'Buch auswählen';

  @override
  String get captureNoBooksMessage => 'Füge zuerst ein Buch hinzu, um Seiten zu markieren.';

  @override
  String get captureAddBookButton => 'Buch hinzufügen';

  @override
  String get captureShutterLabel => 'Seite aufnehmen';

  @override
  String get captureCameraUnavailable => 'Die Kamera ist auf diesem Gerät nicht verfügbar.';

  @override
  String get addBookTitle => 'Buch hinzufügen';

  @override
  String get addBookSearchHint => 'Nach Titel, Autor oder ISBN suchen';

  @override
  String get addBookScanButton => 'Barcode scannen';

  @override
  String get addBookInitialMessage => 'Suche nach einem Buch oder scanne seinen Barcode.';

  @override
  String get addBookEmptyMessage => 'Keine Bücher gefunden. Versuche eine andere Suche.';

  @override
  String get barcodeScannerTitle => 'Barcode scannen';

  @override
  String get barcodeScannerHint => 'Richte die Kamera auf den Barcode des Buches.';

  @override
  String get markingTitle => 'Seite markieren';

  @override
  String get markingProcessingMessage => 'Text wird gelesen…';

  @override
  String get markingInstruction => 'Tippe die Zeilen an, die du markieren möchtest.';

  @override
  String get markingNoTextMessage => 'Auf dieser Seite wurde kein Text gefunden.';

  @override
  String get markingPageNumberLabel => 'Seitenzahl';

  @override
  String get markingPageNumberHint => 'Seitenzahl hinzufügen';

  @override
  String get markingPageNumberMissing => 'Seitenzahl nicht erkannt. Bitte manuell hinzufügen.';

  @override
  String get markingSelectedLabel => 'Ausgewählter Text';

  @override
  String get markingNothingSelectedMessage => 'Noch nichts ausgewählt.';

  @override
  String get markingSaveButton => 'Zitat speichern';

  @override
  String get markingSavedMessage => 'Zitat gespeichert.';

  @override
  String get markingSelectPrompt => 'Wähle mindestens eine Zeile zum Speichern aus.';

  @override
  String get quoteDetailTitle => 'Zitat';

  @override
  String get quoteDetailQuoteLabel => 'Zitat';

  @override
  String quoteDetailPageLabel(int page) {
    return 'Seite $page';
  }

  @override
  String get quoteDetailNoPage => 'Keine Seitenzahl';

  @override
  String get quoteDetailFavoriteAdd => 'Zu Favoriten hinzufügen';

  @override
  String get quoteDetailFavoriteRemove => 'Aus Favoriten entfernen';

  @override
  String get librarySearchBooksHint => 'Bücher suchen…';

  @override
  String get librarySearchShelvesHint => 'Regale suchen…';

  @override
  String get librarySearchQuotesHint => 'Zitate suchen…';

  @override
  String get libraryTabBooks => 'Bücher';

  @override
  String get libraryTabShelves => 'Regale';

  @override
  String get libraryTabQuotes => 'Zitate';

  @override
  String get libraryAddShelfLabel => '+ Regal';

  @override
  String libraryFilterAll(int count) {
    return 'alle $count';
  }

  @override
  String libraryFilterReading(int count) {
    return 'Lese ich gerade $count';
  }

  @override
  String libraryFilterPaused(int count) {
    return 'Pausiert $count';
  }

  @override
  String libraryFilterFinished(int count) {
    return 'Abgeschlossen $count';
  }

  @override
  String libraryFilterFavorites(int count) {
    return 'Favoriten $count';
  }

  @override
  String libraryQuotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Zitate',
      one: '1 Zitat',
    );
    return '$_temp0';
  }

  @override
  String libraryBooksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Bücher',
      one: '1 Buch',
    );
    return '$_temp0';
  }

  @override
  String libraryShelvesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Regale',
      one: '1 Regal',
    );
    return '$_temp0';
  }

  @override
  String libraryFavoritesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Favoriten',
      one: '1 Favorit',
    );
    return '$_temp0';
  }

  @override
  String get libraryStatusReading => 'Lese ich gerade';

  @override
  String get libraryStatusPaused => 'Pausiert';

  @override
  String get libraryShelvesPlaceholder => 'Regale kommen im nächsten Update.';

  @override
  String libraryBookMeta(int quotes, int favorites) {
    String _temp0 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes Zitate',
      one: '1 Zitat',
    );
    String _temp1 = intl.Intl.pluralLogic(
      favorites,
      locale: localeName,
      other: '$favorites Favoriten',
      one: '1 Favorit',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String libraryBookMetaWithStatus(int quotes, int favorites, String status) {
    String _temp0 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes Zitate',
      one: '1 Zitat',
    );
    String _temp1 = intl.Intl.pluralLogic(
      favorites,
      locale: localeName,
      other: '$favorites Favoriten',
      one: '1 Favorit',
    );
    return '$_temp0, $_temp1,\n$status';
  }

  @override
  String libraryShelfMeta(int books, int quotes) {
    String _temp0 = intl.Intl.pluralLogic(
      books,
      locale: localeName,
      other: '$books Bücher',
      one: '1 Buch',
    );
    String _temp1 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes Zitate',
      one: '1 Zitat',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String quoteSourceLabel(String title, String pages) {
    return '$title, S.$pages';
  }

  @override
  String get navLibraryLabel => 'Bibliothek';

  @override
  String get navThemesLabel => 'Themen';

  @override
  String get profileYouLabel => 'du';

  @override
  String pageShortLabel(String pages) {
    return 'S.$pages';
  }

  @override
  String quoteVoiceNoteLabel(String duration) {
    return 'Sprachnotiz $duration';
  }

  @override
  String get comingSoonMessage => 'Bald verfügbar.';

  @override
  String get themesTitle => 'Themen';

  @override
  String get themesSubtitlePlaceholder => 'Zitate über Bücher hinweg';

  @override
  String get themesPlaceholderMessage =>
      'Themen sammeln Zitate aus all deinen Büchern. Sie kommen im nächsten Update.';

  @override
  String bookDetailAllFilter(int count) {
    return 'alle $count';
  }

  @override
  String get bookDetailFavoritesFilter => 'Favoriten';

  @override
  String get bookDetailVoiceNoteFilter => 'mit Sprachnotiz';

  @override
  String bookDetailQuotesStat(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Zitate',
      one: '1 Zitat',
    );
    return '$_temp0';
  }

  @override
  String bookDetailFavoritesStat(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Favoriten',
      one: '1 Favorit',
    );
    return '$_temp0';
  }

  @override
  String get bookDetailEmptyMessage => 'Noch keine Zitate in diesem Buch.';

  @override
  String get captureSteadyHint => 'ruhig halten für schärferen Text';

  @override
  String get captureModeOnePage => 'eine Seite';

  @override
  String get captureModeSpread => 'Doppelseite';

  @override
  String get captureMarkingInto => 'markiere in';

  @override
  String get captureSwitchButton => 'wechseln';

  @override
  String get captureGalleryLabel => 'aus Galerie';

  @override
  String get captureGalleryPlaceholder => 'Import aus der Galerie kommt bald.';

  @override
  String get captureLightOn => 'Licht an';

  @override
  String get captureLightOff => 'Licht aus';

  @override
  String get captureModeAuto => 'auto';

  @override
  String get captureModeManual => 'manuell';

  @override
  String get cropTitle => 'Seite markieren';

  @override
  String get cropHint => 'zieh die Punkte auf die Seitenecken';

  @override
  String get cropLoadingMessage => 'Seite wird gesucht…';

  @override
  String get cropContinueButton => 'Weiter';

  @override
  String get addBookQuestionTitle => 'Welches Buch ist das?';

  @override
  String get addBookInLibraryLabel => 'in deiner Bibliothek';

  @override
  String get addBookNotInLibraryLabel => 'noch nicht in deiner Bibliothek';

  @override
  String get addBookSelectButton => 'wählen';

  @override
  String get addBookAddButton => '+ neu';

  @override
  String get addBookCatalogueFooter =>
      'Katalogergebnisse stammen aus einem Online-Buchdienst. Kein Treffer? Scanne den Barcode oder tippe den Titel selbst ein.';

  @override
  String get addBookNoCatalogueResults =>
      'Keine Katalogtreffer. Scanne den Barcode oder verfeinere die Suche.';

  @override
  String get markingModeText => 'Text';

  @override
  String get markingModePhoto => 'Foto';

  @override
  String get markingContinueButton => 'Weiter';

  @override
  String markingSaveSheetTitle(String book) {
    return 'In $book speichern';
  }

  @override
  String get pageFieldLabel => 'Seite';

  @override
  String get pageFieldHint => '42–43';

  @override
  String get pageAutoLabel => 'auto';

  @override
  String get markingNoteHint => 'Notiz hinzufügen';

  @override
  String get voiceNoteHint => 'Sprachnotiz hinzufügen';

  @override
  String get markingDoneButton => 'Fertig';

  @override
  String get markingUncertainLegend => '= unsichere Wörter, zum Korrigieren tippen';

  @override
  String get markingCorrectionTitle => 'Unsicheres Wort';

  @override
  String get markingCorrectionHint =>
      'vergleich es mit dem Foto und korrigier, was der Scan falsch gelesen hat';

  @override
  String markingJoinNextButton(String word) {
    return 'Mit „$word“ danach verbinden';
  }

  @override
  String markingJoinPreviousButton(String word) {
    return 'Mit „$word“ davor verbinden';
  }

  @override
  String get markingCorrectionApplyButton => 'Übernehmen';

  @override
  String markingUnsureWordsLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wörter könnten falsch erkannt sein — prüf das Zitat',
      one: '1 Wort könnte falsch erkannt sein — prüf das Zitat',
    );
    return '$_temp0';
  }

  @override
  String get markingNewThemeChip => '+ neu';

  @override
  String quoteDetailPhotoMeta(String pages, String date) {
    return 'S.$pages, aufgenommen $date';
  }

  @override
  String quoteDetailShotMeta(String date) {
    return 'aufgenommen $date';
  }

  @override
  String get quoteDetailNotePlaceholder => 'Notiz hinzufügen — bald verfügbar.';

  @override
  String get quoteDetailFavoriteLabel => 'Favorit';

  @override
  String get quoteDetailShareLabel => 'teilen';

  @override
  String quoteShareBody(String quote, String source) {
    return '„$quote“\n\n— $source';
  }

  @override
  String get quoteDetailMoreLabel => 'mehr';

  @override
  String get quoteDetailNoteHint => 'Notiz hinzufügen…';

  @override
  String get libraryStatusFinished => 'Abgeschlossen';

  @override
  String libraryFinishedFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count abgeschlossene Bücher',
      one: '1 abgeschlossenes Buch',
    );
    return '$_temp0';
  }

  @override
  String get libraryShowFinished => 'anzeigen';

  @override
  String get bookDetailMarkFinished => 'Als Abgeschlossen markieren';

  @override
  String get bookDetailMarkReading => 'Als „Lese ich gerade“ markieren';

  @override
  String get bookDetailMarkPaused => 'Als Pausiert markieren';

  @override
  String themesBooksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Bücher',
      one: '1 Buch',
    );
    return '$_temp0';
  }

  @override
  String themesThemeMeta(int quotes, int books) {
    String _temp0 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes Zitate',
      one: '1 Zitat',
    );
    String _temp1 = intl.Intl.pluralLogic(
      books,
      locale: localeName,
      other: '$books Bücher',
      one: '1 Buch',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get themesNewThemeLabel => 'Neues Thema';

  @override
  String get themesNewThemeTitle => 'Neues Thema';

  @override
  String get themesNewThemeHint => 'Themenname';

  @override
  String themeDetailStats(int quotes, int books, int favorites) {
    String _temp0 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes Zitate',
      one: '1 Zitat',
    );
    String _temp1 = intl.Intl.pluralLogic(
      books,
      locale: localeName,
      other: '$books Büchern',
      one: '1 Buch',
    );
    String _temp2 = intl.Intl.pluralLogic(
      favorites,
      locale: localeName,
      other: '$favorites Favoriten',
      one: '1 Favorit',
    );
    return '$_temp0 in $_temp1, $_temp2';
  }

  @override
  String get themeDetailAddQuotes => 'Zitate hinzufügen';

  @override
  String get themeDetailEmpty => 'Noch keine Zitate in diesem Thema.';

  @override
  String get themeAddQuotesTitle => 'Zitate hinzufügen';

  @override
  String get themeRenameTitle => 'Thema umbenennen';

  @override
  String get themeDeleteTitle => 'Thema löschen?';

  @override
  String get themeDeleteMessage => 'Das Thema wird entfernt. Deine Zitate und Bücher bleiben.';

  @override
  String get shelfRenameTitle => 'Regal umbenennen';

  @override
  String get shelfDeleteTitle => 'Regal löschen?';

  @override
  String get shelfDeleteMessage => 'Das Regal wird entfernt. Deine Bücher bleiben.';

  @override
  String get bookDeleteAction => 'Buch löschen';

  @override
  String get bookDeleteTitle => 'Buch löschen?';

  @override
  String get bookDeleteMessage =>
      'Damit werden das Buch und alle seine Zitate gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get voiceNoteDeleteTitle => 'Sprachnotiz löschen?';

  @override
  String get voiceNoteDeleteMessage =>
      'Damit wird die Aufnahme gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get quoteDeleteAction => 'Zitat löschen';

  @override
  String get quoteDeleteTitle => 'Zitat löschen?';

  @override
  String get quoteDeleteMessage =>
      'Damit wird das Zitat gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get libraryNewShelfLabel => 'Neues Regal';

  @override
  String get libraryNewShelfTitle => 'Neues Regal';

  @override
  String get libraryNewShelfHint => 'Regalname';

  @override
  String shelfDetailStats(int books, int quotes) {
    String _temp0 = intl.Intl.pluralLogic(
      books,
      locale: localeName,
      other: '$books Bücher',
      one: '1 Buch',
    );
    String _temp1 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes Zitate',
      one: '1 Zitat',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get shelfDetailAddBooks => 'Bücher hinzufügen';

  @override
  String get shelfDetailEmpty => 'Noch keine Bücher in diesem Regal.';

  @override
  String get shelfAddBooksTitle => 'Bücher hinzufügen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsProfileNameHint => 'Dein Name';

  @override
  String settingsStats(int books, int quotes, int themes) {
    String _temp0 = intl.Intl.pluralLogic(
      books,
      locale: localeName,
      other: '$books Bücher',
      one: '1 Buch',
    );
    String _temp1 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes Zitate',
      one: '1 Zitat',
    );
    String _temp2 = intl.Intl.pluralLogic(
      themes,
      locale: localeName,
      other: '$themes Themen',
      one: '1 Thema',
    );
    return '$_temp0, $_temp1, $_temp2';
  }

  @override
  String get settingsAppearanceLabel => 'Darstellung';

  @override
  String get settingsColorSchemeLabel => 'Farbschema';

  @override
  String get settingsColorSchemeSystem => 'System';

  @override
  String get settingsColorSchemeLight => 'Hell';

  @override
  String get settingsColorSchemeDark => 'Dunkel';

  @override
  String get settingsContrastLabel => 'Kontrast';

  @override
  String get settingsContrastSystem => 'System';

  @override
  String get settingsContrastStandard => 'Standard';

  @override
  String get settingsContrastHigh => 'Hoch';

  @override
  String get settingsLanguageLabel => 'Sprache';

  @override
  String get settingsLanguageSystem => 'System';

  @override
  String get settingsLanguageEnglish => 'Englisch';

  @override
  String get settingsLanguageGerman => 'Deutsch';

  @override
  String get settingsAboutLabel => 'Über';

  @override
  String settingsVersionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get filterNoResultsMessage => 'Zu diesem Filter passt nichts.';

  @override
  String libraryBookMetaStatus(int quotes, String status) {
    String _temp0 = intl.Intl.pluralLogic(
      quotes,
      locale: localeName,
      other: '$quotes Zitate',
      one: '1 Zitat',
    );
    return '$_temp0,\n$status';
  }

  @override
  String get markingBookFieldLabel => 'Buch';

  @override
  String get markingBookPickerTitle => 'Buch wählen';

  @override
  String get quoteDetailAddThemeChip => '+ hinzufügen';

  @override
  String get quoteDetailThemePickerTitle => 'Themen';

  @override
  String get settingsLicensesLabel => 'Open-Source-Lizenzen';

  @override
  String get settingsDebugLabel => 'Debug';

  @override
  String get settingsSeedSampleDataButton => 'Beispieldaten laden';

  @override
  String get captureSpreadHint => 'fotografiere jede Seite, über die das Zitat läuft';

  @override
  String get captureSpreadShotsHint => 'tippen zum Entfernen · halten zum Sortieren';

  @override
  String captureSpreadContinueButton(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Weiter mit $count Seiten',
      one: 'Weiter mit 1 Seite',
    );
    return '$_temp0';
  }

  @override
  String get captureSpreadRemoveLabel => 'Seite entfernen';

  @override
  String get quoteDetailNoPhotoMessage => 'Zu diesem Zitat wurde kein Foto gespeichert.';

  @override
  String get showMore => 'mehr anzeigen';

  @override
  String get showLess => 'weniger anzeigen';

  @override
  String get quoteDetailSourceLabel => 'Quelle';

  @override
  String get quoteDetailNotesLabel => 'meine Gedanken';
}
