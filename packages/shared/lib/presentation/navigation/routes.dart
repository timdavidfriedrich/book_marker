const parameterId = "id";

enum NavigationRoute {
  library("/library"),
  libraryBook("/library/book/:$parameterId"),
  libraryQuote("/library/quote/:$parameterId"),
  libraryShelf("/library/shelf/:$parameterId"),
  themes("/themes"),
  themeDetail("/themes/:$parameterId"),
  capture("/capture"),
  addBook("/capture/add-book"),
  barcodeScanner("/capture/scan"),
  crop("/capture/crop"),
  marking("/capture/quote"),
  settings("/settings");

  const NavigationRoute(this.path);
  final String path;
}
