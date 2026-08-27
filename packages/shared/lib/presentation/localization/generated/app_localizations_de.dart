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
  String libraryHeaderStats(int books, int marks) {
    return '$books Bücher · $marks Markierungen';
  }

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
  String bookmarkDetailPhotoMeta(int page, String date) {
    return 'Seite $page · aufgenommen $date';
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
  String get bookmarkDetailMoreLabel => 'mehr';
}
