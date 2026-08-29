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
  String get commonChangeColor => 'Farbe ändern';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonAutomatic => 'Automatisch';

  @override
  String get accentPickerTitle => 'Farbe wählen';

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
  String get errorNotFound => 'Nicht gefunden.';

  @override
  String get errorUnexpected => 'Ein unerwarteter Fehler ist aufgetreten.';

  @override
  String get libraryTitle => 'Bibliothek';

  @override
  String get libraryEmptyMessage =>
      'Noch keine Markierungen. Fotografiere eine Buchseite, um zu beginnen.';

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
  String get markingSaveButton => 'Markierung speichern';

  @override
  String get markingSavedMessage => 'Markierung gespeichert.';

  @override
  String get markingSelectPrompt => 'Wähle mindestens eine Zeile zum Speichern aus.';

  @override
  String get bookmarkDetailTitle => 'Markierung';

  @override
  String get bookmarkDetailQuoteLabel => 'Markierter Text';

  @override
  String bookmarkDetailPageLabel(int page) {
    return 'Seite $page';
  }

  @override
  String get bookmarkDetailNoPage => 'Keine Seitenzahl';

  @override
  String get bookmarkDetailFavoriteAdd => 'Zu Favoriten hinzufügen';

  @override
  String get bookmarkDetailFavoriteRemove => 'Aus Favoriten entfernen';

  @override
  String get librarySearchHint => 'Bücher und Markierungen suchen…';

  @override
  String get libraryTabBooks => 'Bücher';

  @override
  String get libraryTabShelves => 'Regale';

  @override
  String get libraryAddShelfLabel => '+ Regal';

  @override
  String libraryFilterAll(int count) {
    return 'alle $count';
  }

  @override
  String libraryFilterReading(int count) {
    return 'am Lesen $count';
  }

  @override
  String libraryFilterFinished(int count) {
    return 'fertig $count';
  }

  @override
  String libraryMarksCount(int count) {
    return '$count Markierungen';
  }

  @override
  String libraryStarredCount(int count) {
    return '$count mit Stern';
  }

  @override
  String get libraryStatusReading => 'am Lesen';

  @override
  String get libraryShelvesPlaceholder => 'Regale kommen im nächsten Update.';

  @override
  String get librarySearchScopeAll => 'alle Bücher';

  @override
  String get librarySearchScopeStarred => 'mit Stern';

  @override
  String get librarySearchScopeNotes => 'meine Notizen';

  @override
  String librarySearchCount(int marks, int books) {
    return '$marks Markierungen in $books Büchern';
  }

  @override
  String get navLibraryLabel => 'Bibliothek';

  @override
  String get navThemesLabel => 'Themen';

  @override
  String get profileYouLabel => 'du';

  @override
  String pageShortLabel(int page) {
    return 'S.$page';
  }

  @override
  String markVoiceLabel(String duration) {
    return 'Sprache $duration';
  }

  @override
  String get comingSoonMessage => 'Bald verfügbar.';

  @override
  String get themesTitle => 'Themen';

  @override
  String get themesSubtitlePlaceholder => 'Markierungen über Bücher hinweg';

  @override
  String get themesPlaceholderMessage =>
      'Themen sammeln Markierungen aus all deinen Büchern. Sie kommen im nächsten Update.';

  @override
  String bookDetailAllFilter(int count) {
    return 'alle $count';
  }

  @override
  String get bookDetailStarredFilter => 'mit Stern';

  @override
  String get bookDetailVoiceFilter => 'mit Sprache';

  @override
  String bookDetailMarksStat(int count) {
    return '$count Markierungen';
  }

  @override
  String bookDetailStarredStat(int count) {
    return '$count mit Stern';
  }

  @override
  String get bookDetailEmptyMessage => 'Noch keine Markierungen in diesem Buch.';

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
  String get markingPageFieldLabel => 'Seite';

  @override
  String get markingPageAutoLabel => 'auto';

  @override
  String get markingNoteHint => 'worauf bezieht sich das?';

  @override
  String get markingVoiceHint => 'gedrückt halten zum Sprechen';

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
  String bookmarkDetailPhotoMeta(int page, String date) {
    return 'Seite $page, aufgenommen $date';
  }

  @override
  String bookmarkDetailShotMeta(String date) {
    return 'aufgenommen $date';
  }

  @override
  String get bookmarkDetailNotePlaceholder => 'Notiz hinzufügen — bald verfügbar.';

  @override
  String get bookmarkDetailStarredLabel => 'Stern';

  @override
  String get bookmarkDetailShareLabel => 'teilen';

  @override
  String markShareBody(String quote, String source) {
    return '„$quote“\n\n— $source';
  }

  @override
  String get bookmarkDetailMoreLabel => 'mehr';

  @override
  String get bookmarkDetailNoteHint => 'Notiz hinzufügen…';

  @override
  String get libraryStatusFinished => 'fertig';

  @override
  String libraryFinishedFooter(int count) {
    return '$count fertige Bücher';
  }

  @override
  String get libraryShowFinished => 'anzeigen';

  @override
  String get bookDetailMarkFinished => 'Als fertig markieren';

  @override
  String get bookDetailMarkReading => 'Als am Lesen markieren';

  @override
  String themesBooksCount(int count) {
    return '$count Bücher';
  }

  @override
  String get themesNewThemeLabel => 'Neues Thema';

  @override
  String get themesNewThemeTitle => 'Neues Thema';

  @override
  String get themesNewThemeHint => 'Themenname';

  @override
  String themeDetailStats(int marks, int books, int starred) {
    return '$marks Markierungen in $books Büchern,\n$starred favorisiert';
  }

  @override
  String get themeDetailAddMarks => 'Markierungen hinzufügen';

  @override
  String get themeDetailEmpty => 'Noch keine Markierungen in diesem Thema.';

  @override
  String get themeAddMarksTitle => 'Markierungen hinzufügen';

  @override
  String get themeRenameTitle => 'Thema umbenennen';

  @override
  String get themeDeleteTitle => 'Thema löschen?';

  @override
  String get themeDeleteMessage =>
      'Das Thema wird entfernt. Deine Markierungen und Bücher bleiben.';

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
      'Damit werden das Buch und alle seine Markierungen gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get markDeleteAction => 'Markierung löschen';

  @override
  String get markDeleteTitle => 'Markierung löschen?';

  @override
  String get markDeleteMessage =>
      'Damit wird die Markierung gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get libraryNewShelfLabel => 'Neues Regal';

  @override
  String get libraryNewShelfTitle => 'Neues Regal';

  @override
  String get libraryNewShelfHint => 'Regalname';

  @override
  String shelfDetailStats(int books, int marks) {
    return '$books Bücher, $marks Markierungen';
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
  String settingsStats(int books, int marks, int themes) {
    return '$books Bücher\n$marks Markierungen\n$themes Themen';
  }

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
  String get settingsLicensesLabel => 'Open-Source-Lizenzen';
}
