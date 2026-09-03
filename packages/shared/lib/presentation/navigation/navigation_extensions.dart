import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/presentation/navigation/capture_arguments.dart';
import 'package:shared/presentation/navigation/crop_arguments.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:shared/presentation/navigation/routes.dart';

extension NavigationExtension on BuildContext {
  Future<List<String>?> pushCapture(CaptureArguments arguments) =>
      push<List<String>>(NavigationRoute.capture.path, extra: arguments);
  Future<String?> pushAddBook() => push<String>(NavigationRoute.addBook.path);
  Future<String?> pushBarcodeScanner() => push<String>(NavigationRoute.barcodeScanner.path);
  Future<void> pushCrop(CropArguments arguments) =>
      push(NavigationRoute.crop.path, extra: arguments);
  Future<void> pushMarking(MarkingArguments arguments) =>
      push(NavigationRoute.marking.path, extra: arguments);
  void goLibrary() => go(NavigationRoute.library.path);
  void pushBookDetail(String bookId) =>
      push(NavigationRoute.libraryBook.path.replaceFirst(":$parameterId", bookId));
  void pushQuoteDetail(String quoteId) =>
      push(NavigationRoute.libraryQuote.path.replaceFirst(":$parameterId", quoteId));
  void pushThemeDetail(String themeId) =>
      push(NavigationRoute.themeDetail.path.replaceFirst(":$parameterId", themeId));
  void pushShelfDetail(String shelfId) =>
      push(NavigationRoute.libraryShelf.path.replaceFirst(":$parameterId", shelfId));
  void pushSettings() => push(NavigationRoute.settings.path);
  void closeScreen() => pop();
  void closeScreenWithResult<T extends Object>(T result) => pop(result);
}
