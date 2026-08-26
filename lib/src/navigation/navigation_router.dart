import 'package:book_marker/src/di/service_locator.dart';
import 'package:feature_capture/presentation/add_book/add_book_bloc.dart';
import 'package:feature_capture/presentation/add_book/add_book_screen.dart';
import 'package:feature_capture/presentation/barcode_scanner/barcode_scanner_screen.dart';
import 'package:feature_capture/presentation/capture/capture_bloc.dart';
import 'package:feature_capture/presentation/capture/capture_event.dart';
import 'package:feature_capture/presentation/capture/capture_screen.dart';
import 'package:feature_capture/presentation/marking/marking_bloc.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_screen.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_bloc.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_event.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_screen.dart';
import 'package:feature_library/presentation/library/library_bloc.dart';
import 'package:feature_library/presentation/library/library_event.dart';
import 'package:feature_library/presentation/library/library_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:shared/presentation/navigation/routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");

@singleton
class NavigationRouter {
  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: NavigationRoute.library.path,
    redirect: (context, state) => state.uri.path == "/" ? NavigationRoute.library.path : null,
    routes: [
      GoRoute(
        path: NavigationRoute.library.path,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<LibraryBloc>()..add(const LibraryStarted()),
          child: const LibraryScreen(),
        ),
        routes: [
          GoRoute(
            path: ":$parameterId",
            builder: (context, state) => BlocProvider(
              create: (_) =>
                  sl<BookmarkDetailBloc>(param1: state.pathParameters[parameterId])
                    ..add(const BookmarkDetailStarted()),
              child: const BookmarkDetailScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: NavigationRoute.capture.path,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<CaptureBloc>()..add(const CaptureStarted()),
          child: const CaptureScreen(),
        ),
        routes: [
          GoRoute(
            path: "add-book",
            builder: (context, state) => BlocProvider(
              create: (_) => sl<AddBookBloc>(),
              child: const AddBookScreen(),
            ),
          ),
          GoRoute(
            path: "scan",
            builder: (context, state) => const BarcodeScannerScreen(),
          ),
          GoRoute(
            path: "mark",
            builder: (context, state) {
              final arguments = state.extra;
              if (arguments is! MarkingArguments) return const LibraryScreen();
              return BlocProvider(
                create: (_) => sl<MarkingBloc>(param1: arguments)..add(const MarkingStarted()),
                child: const MarkingScreen(),
              );
            },
          ),
        ],
      ),
    ],
  );
}
