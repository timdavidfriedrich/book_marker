import 'package:book_marker/src/di/service_locator.dart';
import 'package:book_marker/src/navigation/navigation_shell_container.dart';
import 'package:book_marker/src/theme/app_theme.dart';
import 'package:feature_capture/presentation/add_book/add_book_bloc.dart';
import 'package:feature_capture/presentation/add_book/add_book_event.dart';
import 'package:feature_capture/presentation/add_book/add_book_screen.dart';
import 'package:feature_capture/presentation/barcode_scanner/barcode_scanner_screen.dart';
import 'package:feature_capture/presentation/capture/capture_bloc.dart';
import 'package:feature_capture/presentation/capture/capture_event.dart';
import 'package:feature_capture/presentation/capture/capture_screen.dart';
import 'package:feature_capture/presentation/marking/marking_bloc.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_screen.dart';
import 'package:feature_library/presentation/book_detail/book_detail_bloc.dart';
import 'package:feature_library/presentation/book_detail/book_detail_event.dart';
import 'package:feature_library/presentation/book_detail/book_detail_screen.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_bloc.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_event.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_screen.dart';
import 'package:feature_library/presentation/library/library_bloc.dart';
import 'package:feature_library/presentation/library/library_event.dart';
import 'package:feature_library/presentation/library/library_screen.dart';
import 'package:feature_themes/presentation/themes/themes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:shared/presentation/navigation/routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");
final _libraryNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "library");
final _themesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "themes");

const _sheetBarrier = Color(0x8A000000);

@singleton
class NavigationRouter {
  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: NavigationRoute.library.path,
    redirect: (context, state) => state.uri.path == "/" ? NavigationRoute.library.path : null,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            NavigationShellContainer(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _libraryNavigatorKey,
            routes: [
              GoRoute(
                path: NavigationRoute.library.path,
                builder: (context, state) => BlocProvider(
                  create: (_) => sl<LibraryBloc>()..add(const LibraryStarted()),
                  child: const LibraryScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _themesNavigatorKey,
            routes: [
              GoRoute(
                path: NavigationRoute.themes.path,
                builder: (context, state) => const ThemesScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: NavigationRoute.libraryBook.path,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => BlocProvider(
          create: (_) =>
              sl<BookDetailBloc>(param1: state.pathParameters[parameterId])
                ..add(const BookDetailStarted()),
          child: const BookDetailScreen(),
        ),
      ),
      GoRoute(
        path: NavigationRoute.libraryMark.path,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => Theme(
          data: AppTheme.dark,
          child: BlocProvider(
            create: (_) =>
                sl<BookmarkDetailBloc>(param1: state.pathParameters[parameterId])
                  ..add(const BookmarkDetailStarted()),
            child: const BookmarkDetailScreen(),
          ),
        ),
      ),
      GoRoute(
        path: NavigationRoute.capture.path,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => Theme(
          data: AppTheme.dark,
          child: BlocProvider(
            create: (_) => sl<CaptureBloc>()..add(const CaptureStarted()),
            child: const CaptureScreen(),
          ),
        ),
        routes: [
          GoRoute(
            path: "add-book",
            parentNavigatorKey: _rootNavigatorKey,
            pageBuilder: (context, state) => CustomTransitionPage<String>(
              opaque: false,
              barrierColor: _sheetBarrier,
              barrierDismissible: true,
              transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
                position: Tween(begin: const Offset(0, 1), end: Offset.zero)
                    .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
                child: child,
              ),
              child: BlocProvider(
                create: (_) => sl<AddBookBloc>()..add(const AddBookStarted()),
                child: const AddBookScreen(),
              ),
            ),
          ),
          GoRoute(
            path: "scan",
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => const BarcodeScannerScreen(),
          ),
          GoRoute(
            path: "mark",
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) {
              final arguments = state.extra;
              if (arguments is! MarkingArguments) return const CaptureScreen();
              return Theme(
                data: AppTheme.light,
                child: BlocProvider(
                  create: (_) => sl<MarkingBloc>(param1: arguments)..add(const MarkingStarted()),
                  child: const MarkingScreen(),
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
