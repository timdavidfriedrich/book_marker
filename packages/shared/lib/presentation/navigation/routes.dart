const parameterId = "id";

enum NavigationRoute {
  library("/library"),
  libraryBook("/library/book/:$parameterId"),
  libraryMark("/library/mark/:$parameterId"),
  libraryShelf("/library/shelf/:$parameterId"),
  themes("/themes"),
  themeDetail("/themes/:$parameterId"),
  capture("/capture"),
  addBook("/capture/add-book"),
  barcodeScanner("/capture/scan"),
  crop("/capture/crop"),
  marking("/capture/mark"),
  settings("/settings");

  const NavigationRoute(this.path);
  final String path;
}
