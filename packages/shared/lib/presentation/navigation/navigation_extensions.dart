import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:shared/presentation/navigation/routes.dart';

extension NavigationExtension on BuildContext {
  void pushCapture() => push(NavigationRoute.capture.path);

  Future<String?> pushAddBook() => push<String>(NavigationRoute.addBook.path);

  Future<String?> pushBarcodeScanner() => push<String>(NavigationRoute.barcodeScanner.path);

  void pushMarking(MarkingArguments arguments) =>
      push(NavigationRoute.marking.path, extra: arguments);

  void pushBookmarkDetail(String bookmarkId) =>
      push(NavigationRoute.bookmarkDetail.path.replaceFirst(":$parameterId", bookmarkId));

  void closeScreen() => pop();

  void closeScreenWithResult(String result) => pop(result);
}
