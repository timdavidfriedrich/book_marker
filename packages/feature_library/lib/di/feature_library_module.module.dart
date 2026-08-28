// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:feature_library/presentation/book_detail/book_detail_bloc.dart'
    as _i1003;
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_bloc.dart'
    as _i946;
import 'package:feature_library/presentation/library/library_bloc.dart'
    as _i415;
import 'package:feature_library/presentation/shelf_detail/shelf_detail_bloc.dart'
    as _i481;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/book_repository.dart' as _i748;
import 'package:shared/domain/repositories/bookmark_repository.dart' as _i245;
import 'package:shared/domain/repositories/shelf_repository.dart' as _i793;

class FeatureLibraryPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factoryParam<_i1003.BookDetailBloc, String, dynamic>((
      _bookId,
      _,
    ) =>
        _i1003.BookDetailBloc(
          gh<_i245.BookmarkRepository>(),
          gh<_i748.BookRepository>(),
          _bookId,
        ));
    gh.factoryParam<_i481.ShelfDetailBloc, String, dynamic>((
      _shelfId,
      _,
    ) =>
        _i481.ShelfDetailBloc(
          gh<_i793.ShelfRepository>(),
          gh<_i748.BookRepository>(),
          gh<_i245.BookmarkRepository>(),
          _shelfId,
        ));
    gh.factory<_i415.LibraryBloc>(() => _i415.LibraryBloc(
          gh<_i245.BookmarkRepository>(),
          gh<_i748.BookRepository>(),
          gh<_i793.ShelfRepository>(),
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
