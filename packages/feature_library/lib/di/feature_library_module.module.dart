// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_bloc.dart'
    as _i946;
import 'package:feature_library/presentation/library/library_bloc.dart'
    as _i415;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/book_repository.dart' as _i748;
import 'package:shared/domain/repositories/bookmark_repository.dart' as _i245;

class FeatureLibraryPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i415.LibraryBloc>(() => _i415.LibraryBloc(
          gh<_i245.BookmarkRepository>(),
          gh<_i748.BookRepository>(),
        ));
    gh.factoryParam<_i946.BookmarkDetailBloc, String, dynamic>((
      _bookmarkId,
      _,
    ) =>
        _i946.BookmarkDetailBloc(
          gh<_i245.BookmarkRepository>(),
          gh<_i748.BookRepository>(),
          _bookmarkId,
        ));
  }
}
