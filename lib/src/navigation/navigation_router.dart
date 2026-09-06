import 'package:book_marker/src/di/service_locator.dart';
import 'package:book_marker/src/navigation/navigation_shell_container.dart';
import 'package:book_marker/src/theme/app_theme.dart';
import 'package:feature_capture/presentation/add_book/add_book_bloc.dart';
import 'package:feature_capture/presentation/add_book/add_book_event.dart';
import 'package:feature_capture/presentation/add_book/add_book_screen.dart';
import 'package:feature_capture/presentation/barcode_scanner/barcode_scanner_screen.dart';
import 'package:feature_capture/presentation/capture/camera_cubit.dart';
import 'package:feature_capture/presentation/capture/capture_screen.dart';
import 'package:feature_capture/presentation/capture/page_detection_cubit.dart';
import 'package:feature_capture/presentation/crop/crop_bloc.dart';
import 'package:feature_capture/presentation/crop/crop_event.dart';
import 'package:feature_capture/presentation/crop/crop_screen.dart';
import 'package:feature_capture/presentation/marking/marking_bloc.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_screen.dart';
import 'package:feature_library/presentation/book_detail/book_detail_bloc.dart';
import 'package:feature_library/presentation/book_detail/book_detail_event.dart';
import 'package:feature_library/presentation/book_detail/book_detail_screen.dart';
import 'package:feature_library/presentation/library/library_bloc.dart';
import 'package:feature_library/presentation/library/library_event.dart';
import 'package:feature_library/presentation/library/library_screen.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_bloc.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_event.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_screen.dart';
import 'package:feature_library/presentation/shelf_detail/shelf_detail_bloc.dart';
import 'package:feature_library/presentation/shelf_detail/shelf_detail_event.dart';
import 'package:feature_library/presentation/shelf_detail/shelf_detail_screen.dart';
import 'package:feature_settings/presentation/settings/settings_bloc.dart';
import 'package:feature_settings/presentation/settings/settings_event.dart';
import 'package:feature_settings/presentation/settings/settings_screen.dart';
import 'package:feature_themes/presentation/theme_detail/theme_detail_bloc.dart';
import 'package:feature_themes/presentation/theme_detail/theme_detail_event.dart';
import 'package:feature_themes/presentation/theme_detail/theme_detail_screen.dart';
import 'package:feature_themes/presentation/themes/themes_bloc.dart';
import 'package:feature_themes/presentation/themes/themes_event.dart';
import 'package:feature_themes/presentation/themes/themes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kaisel/kaisel.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/route_change_observer.dart';
import 'package:shared/presentation/navigation/routes.dart';

const _sheetBarrier = Color(0x8A000000);
const _sheetTransition = Duration(milliseconds: 280);

@lazySingleton
class NavigationRouter() {
  late final KaiselRouterConfig<AppRoute> config = KaiselRouterConfig<AppRoute>(
    initial: const MainShell(),
    builder: (context, route) => _AppPage(route: route),
    pageWrapper: _wrapPage,
    observers: () => [RouteChangeObserver(notifier: sl<RouteChangeNotifier>())],
  );
}

class const _AppPage({
  required final AppRoute _route,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => switch (_route) {
    MainShell() => const _AppShell(),
    BookDetail(:final bookId) => BlocProvider(
      create: (_) => sl<BookDetailBloc>(param1: bookId)..add(const BookDetailStarted()),
      child: const BookDetailScreen(),
    ),
    QuoteDetail(:final quoteId) => Theme(
      data: AppTheme.darkOf(context.contrast),
      child: BlocProvider(
        create: (_) => sl<QuoteDetailBloc>(param1: quoteId)..add(const QuoteDetailStarted()),
        child: const QuoteDetailScreen(),
      ),
    ),
    ShelfDetail(:final shelfId) => BlocProvider(
      create: (_) => sl<ShelfDetailBloc>(param1: shelfId)..add(const ShelfDetailStarted()),
      child: const ShelfDetailScreen(),
    ),
    ThemeDetail(:final themeId) => BlocProvider(
      create: (_) => sl<ThemeDetailBloc>(param1: themeId)..add(const ThemeDetailStarted()),
      child: const ThemeDetailScreen(),
    ),
    Settings() => BlocProvider(
      create: (_) => sl<SettingsBloc>()..add(const SettingsStarted()),
      child: const SettingsScreen(),
    ),
    Capture(:final addsPage) => Theme(
      data: AppTheme.darkOf(context.contrast),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<CameraCubit>()),
          BlocProvider(create: (_) => sl<PageDetectionCubit>()),
        ],
        child: CaptureScreen(addsPage: addsPage),
      ),
    ),
    AddBook() => BlocProvider(
      create: (_) => sl<AddBookBloc>()..add(const AddBookStarted()),
      child: const AddBookScreen(),
    ),
    BarcodeScanner() => const BarcodeScannerScreen(),
    final Crop crop => Theme(
      data: AppTheme.darkOf(context.contrast),
      child: BlocProvider(
        create: (_) => sl<CropBloc>(param1: crop)..add(const CropStarted()),
        child: const CropScreen(),
      ),
    ),
    final Marking marking => BlocProvider(
      create: (_) => sl<MarkingBloc>(param1: marking)..add(const MarkingStarted()),
      child: const MarkingScreen(),
    ),
  };
}

class const _AppShell() extends StatelessWidget {
  @override
  Widget build(BuildContext context) => KaiselShell<TabRoute>(
    branchInitials: const [LibraryTab(), ThemesTab()],
    pageBuilder: (context, route) => _TabPage(route: route),
    chromeBuilder: (context, activeBranch, branchContent, switchBranch) => NavigationShellContainer(
      activeBranch: activeBranch,
      branchContent: branchContent,
      onBranchSelected: switchBranch,
    ),
  );
}

class const _TabPage({
  required final TabRoute _route,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => switch (_route) {
    LibraryTab() => BlocProvider(
      create: (_) => sl<LibraryBloc>()..add(const LibraryStarted()),
      child: const LibraryScreen(),
    ),
    ThemesTab() => BlocProvider(
      create: (_) => sl<ThemesBloc>()..add(const ThemesStarted()),
      child: const ThemesScreen(),
    ),
  };
}

// * MaterialPage carries Flutter's predictive back transition, so only the sheet opts out
Page<Object?> _wrapPage(KaiselPageWrapperContext<AppRoute> page) => switch (page.route) {
  AddBook() => _SheetPage(child: page.child, key: page.key),
  _ => MaterialPage<Object?>(child: page.child, key: page.key),
};

class const _SheetPage({
  required final Widget _child,
  required super.key,
}) extends Page<Object?> {
  @override
  Route<Object?> createRoute(BuildContext context) => PageRouteBuilder<Object?>(
    settings: this,
    opaque: false,
    barrierColor: _sheetBarrier,
    barrierDismissible: true,
    transitionDuration: _sheetTransition,
    reverseTransitionDuration: _sheetTransition,
    pageBuilder: (context, animation, secondaryAnimation) => _child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
      position: Tween(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
      child: child,
    ),
  );
}
