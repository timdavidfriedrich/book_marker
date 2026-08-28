import 'package:book_marker/src/di/service_locator.dart';
import 'package:book_marker/src/navigation/navigation_router.dart';
import 'package:book_marker/src/settings/app_settings_cubit.dart';
import 'package:book_marker/src/theme/app_theme.dart';
import 'package:core/config/build_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared/data/sample_data_seeder.dart';
import 'package:shared/domain/entities/user_settings.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/locale_preference_extensions.dart';
import 'package:shared/presentation/localization/generated/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  if (seedSampleData) await sl<SampleDataSeeder>().seedIfEmpty();
  runApp(const App());
}

class const App({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AppSettingsCubit>()..start(),
      child: BlocBuilder<AppSettingsCubit, UserSettings>(
        builder: (context, settings) => MaterialApp.router(
          routerConfig: sl<NavigationRouter>().router,
          onGenerateTitle: (context) => context.s.appTitle,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          locale: settings.localePreference.toLocale(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}
