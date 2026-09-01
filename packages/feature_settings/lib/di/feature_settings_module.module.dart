// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:feature_settings/presentation/settings/settings_bloc.dart'
    as _i235;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/book_repository.dart' as _i748;
import 'package:shared/domain/repositories/quote_repository.dart' as _i570;
import 'package:shared/domain/repositories/sample_data_repository.dart'
    as _i124;
import 'package:shared/domain/repositories/settings_repository.dart' as _i0;
import 'package:shared/domain/repositories/theme_repository.dart' as _i640;

class FeatureSettingsPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i235.SettingsBloc>(() => _i235.SettingsBloc(
          gh<_i0.SettingsRepository>(),
          gh<_i748.BookRepository>(),
          gh<_i570.QuoteRepository>(),
          gh<_i640.ThemeRepository>(),
          gh<_i124.SampleDataRepository>(),
        ));
  }
}
