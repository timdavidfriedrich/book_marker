// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:feature_themes/presentation/theme_detail/theme_detail_bloc.dart' as _i377;
import 'package:feature_themes/presentation/themes/themes_bloc.dart' as _i664;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/book_repository.dart' as _i748;
import 'package:shared/domain/repositories/quote_repository.dart' as _i570;
import 'package:shared/domain/repositories/theme_repository.dart' as _i640;

class FeatureThemesPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factoryParam<_i377.ThemeDetailBloc, String, dynamic>(
      (
        _themeId,
        _,
      ) => _i377.ThemeDetailBloc(
        gh<_i640.ThemeRepository>(),
        gh<_i570.QuoteRepository>(),
        gh<_i748.BookRepository>(),
        _themeId,
      ),
    );
    gh.factory<_i664.ThemesBloc>(
      () => _i664.ThemesBloc(
        gh<_i640.ThemeRepository>(),
        gh<_i570.QuoteRepository>(),
      ),
    );
  }
}
