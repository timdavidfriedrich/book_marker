import 'dart:async';

import 'package:book_marker/src/di/service_locator.dart';
import 'package:book_marker/src/navigation/navigation_router.dart';
import 'package:book_marker/src/settings/app_settings_cubit.dart';
import 'package:book_marker/src/theme/app_theme.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared/domain/entities/user_settings.dart';
import 'package:shared/presentation/account/account_bloc.dart';
import 'package:shared/presentation/account/account_event.dart';
import 'package:shared/presentation/account/account_state.dart';
import 'package:shared/presentation/app_config/app_config_cubit.dart';
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
        BlocProvider(create: (_) => sl<VoiceNoteCubit>()),
        BlocProvider(create: (_) => sl<AccountBloc>()..add(const AccountStarted())),
        BlocProvider(create: (_) => sl<AppConfigCubit>()..start()),
      ],
      child: BlocListener<AccountBloc, AccountState>(
        // * the transition, not the state: a refresh that failed at launch is
        // * worth retrying the moment the server is known to be reachable
        listenWhen: (previous, current) =>
            previous is AccountSignedOut && current is! AccountSignedOut,
        listener: (context, _) => unawaited(context.read<AppConfigCubit>().refresh()),
        child: BlocBuilder<AppSettingsCubit, UserSettings>(
          builder: (context, settings) {
            final contrast = settings.contrastPreference.toContrastLevel();
            return MaterialApp.router(
              routerConfig: sl<NavigationRouter>().config,
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
      ),
    );
  }
}
