import 'package:kaisel/kaisel.dart';
import 'package:shared/domain/entities/captured_shot.dart';
import 'package:shared/domain/entities/quote.dart';

sealed class AppRoute extends KaiselRoute {
  const AppRoute();
}

class const MainShell() extends AppRoute;

class const BookDetail({
  required final String bookId,
}) extends AppRoute {
  @override
  List<Object?> get props => [bookId];
}

class const QuoteDetail({
  required final String quoteId,
}) extends AppRoute {
  @override
  List<Object?> get props => [quoteId];
}

class const ShelfDetail({
  required final String shelfId,
}) extends AppRoute {
  @override
  List<Object?> get props => [shelfId];
}

class const ThemeDetail({
  required final String themeId,
}) extends AppRoute {
  @override
  List<Object?> get props => [themeId];
}

class const Settings() extends AppRoute;

class const SignIn() extends AppRoute;

class const RecoveryCodeSetup() extends AppRoute;

class const RecoveryCodeUnlock() extends AppRoute;

class const DeleteAccount() extends AppRoute;

class const Capture({
  required final bool addsPage,
}) extends AppRoute {
  @override
  List<Object?> get props => [addsPage];
}

class const AddBook() extends AppRoute;

class const BarcodeScanner() extends AppRoute;

class const Crop({
  required final List<String> imagePaths,
}) extends AppRoute {
  @override
  List<Object?> get props => [imagePaths];
}

class const Marking({
  required final List<CapturedShot> shots,
  // * left empty for a fresh capture, where the book is only picked while marking
  final String? bookId,
  // * set when an existing quote is re-marked instead of freshly captured
  final Quote? quote,
}) extends AppRoute {
  @override
  List<Object?> get props => [shots, bookId, quote];
}

sealed class TabRoute extends KaiselRoute {
  const TabRoute();
}

class const LibraryTab() extends TabRoute;

class const ThemesTab() extends TabRoute;
