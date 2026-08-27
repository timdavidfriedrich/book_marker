const parameterId = "id";

enum NavigationRoute {
  library("/library"),
  libraryBook("/library/book/:$parameterId"),
  libraryMark("/library/mark/:$parameterId"),
  themes("/themes"),
  capture("/capture"),
  addBook("/capture/add-book"),
  barcodeScanner("/capture/scan"),
  marking("/capture/mark");

  const NavigationRoute(this.path);
  final String path;
}
