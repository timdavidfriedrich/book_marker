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
  String get libraryTitle => 'Deine Markierungen';

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
}
