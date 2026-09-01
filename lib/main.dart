import 'package:book_marker/src/di/service_locator.dart';
import 'package:book_marker/src/navigation/navigation_router.dart';
import 'package:book_marker/src/settings/app_settings_cubit.dart';
import 'package:book_marker/src/theme/app_theme.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared/domain/entities/user_settings.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/locale_preference_extensions.dart';
import 'package:shared/presentation/extensions/theme_preference_extensions.dart';
import 'package:shared/presentation/localization/generated/app_localizations.dart';
import 'package:shared/presentation/voice_note_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}

class const App({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AppSettingsCubit>()..start()),
        // * one shared player keeps a single voice note audible across all screens
        BlocProvider(create: (_) => sl<VoiceNoteCubit>()),
      ],
      child: BlocBuilder<AppSettingsCubit, UserSettings>(
        builder: (context, settings) {
          final contrast = settings.contrastPreference.toContrastLevel();
          return MaterialApp.router(
            routerConfig: sl<NavigationRouter>().router,
            onGenerateTitle: (context) => context.s.appTitle,
            theme: AppTheme.lightOf(contrast ?? ContrastLevel.standard),
            darkTheme: AppTheme.darkOf(contrast ?? ContrastLevel.standard),
            highContrastTheme: AppTheme.lightOf(contrast ?? ContrastLevel.high),
            highContrastDarkTheme: AppTheme.darkOf(contrast ?? ContrastLevel.high),
            themeMode: settings.themePreference.toThemeMode(),
            debugShowCheckedModeBanner: false,
            locale: settings.localePreference.toLocale(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
