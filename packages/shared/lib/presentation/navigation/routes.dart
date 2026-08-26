const parameterId = "id";

enum NavigationRoute {
  library("/library"),
  bookmarkDetail("/library/:$parameterId"),
  capture("/capture"),
  addBook("/capture/add-book"),
  barcodeScanner("/capture/scan"),
  marking("/capture/mark");

  const NavigationRoute(this.path);

  final String path;
}
