import 'package:flutter/widgets.dart';
import 'package:kaisel/kaisel.dart';
import 'package:shared/presentation/navigation/routes.dart';

extension NavigationExtension on BuildContext {
  // * screens inside a shell branch sit under a TabRoute router, so every push that should
  // * cover the navigation chrome has to name the app router explicitly
  KaiselRouter<AppRoute> get appRouter => router<AppRoute>();

  void closeScreen() => pop();

  void closeScreenWithResult<T extends Object>(T result) => pop(result);

  Future<void> goToShell() => appRouter.set(const [MainShell()]);
}
