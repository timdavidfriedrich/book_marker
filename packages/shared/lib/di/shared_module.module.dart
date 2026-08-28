// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:dio/dio.dart' as _i361;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/data/data_sources/book_local_data_source.dart' as _i315;
import 'package:shared/data/data_sources/book_remote_data_source.dart' as _i697;
import 'package:shared/data/data_sources/bookmark_local_data_source.dart'
    as _i760;
import 'package:shared/data/data_sources/image_storage_data_source.dart'
    as _i47;
import 'package:shared/data/data_sources/settings_local_data_source.dart'
    as _i115;
import 'package:shared/data/data_sources/shelf_local_data_source.dart'
    as _i1026;
import 'package:shared/data/data_sources/theme_local_data_source.dart' as _i814;
import 'package:shared/data/database/app_database.dart' as _i50;
import 'package:shared/data/database/database_module.dart' as _i860;
import 'package:shared/data/repositories/book_repository_impl.dart' as _i245;
import 'package:shared/data/repositories/bookmark_repository_impl.dart'
    as _i277;
import 'package:shared/data/repositories/settings_repository_impl.dart'
    as _i921;
import 'package:shared/data/repositories/shelf_repository_impl.dart' as _i812;
import 'package:shared/data/repositories/theme_repository_impl.dart' as _i308;
import 'package:shared/data/sample_data_seeder.dart' as _i716;
import 'package:shared/domain/repositories/book_repository.dart' as _i748;
import 'package:shared/domain/repositories/bookmark_repository.dart' as _i246;
import 'package:shared/domain/repositories/settings_repository.dart' as _i0;
import 'package:shared/domain/repositories/shelf_repository.dart' as _i793;
import 'package:shared/domain/repositories/theme_repository.dart' as _i640;

class SharedPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final databaseModule = _$DatabaseModule();
    gh.lazySingleton<_i50.AppDatabase>(() => databaseModule.appDatabase());
    gh.factory<_i697.BookRemoteDataSource>(
        () => _i697.BookRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.factory<_i814.ThemeLocalDataSource>(
        () => _i814.ThemeLocalDataSourceImpl(gh<_i50.AppDatabase>()));
    gh.factory<_i315.BookLocalDataSource>(
        () => _i315.BookLocalDataSourceImpl(gh<_i50.AppDatabase>()));
    gh.factory<_i748.BookRepository>(() => _i245.BookRepositoryImpl(
          gh<_i315.BookLocalDataSource>(),
          gh<_i697.BookRemoteDataSource>(),
        ));
    gh.factory<_i115.SettingsLocalDataSource>(
        () => _i115.SettingsLocalDataSourceImpl(gh<_i50.AppDatabase>()));
    gh.factory<_i47.ImageStorageDataSource>(
        () => const _i47.ImageStorageDataSourceImpl());
    gh.factory<_i1026.ShelfLocalDataSource>(
        () => _i1026.ShelfLocalDataSourceImpl(gh<_i50.AppDatabase>()));
    gh.factory<_i0.SettingsRepository>(() =>
        _i921.SettingsRepositoryImpl(gh<_i115.SettingsLocalDataSource>()));
    gh.factory<_i760.BookmarkLocalDataSource>(
        () => _i760.BookmarkLocalDataSourceImpl(gh<_i50.AppDatabase>()));
    gh.factory<_i246.BookmarkRepository>(() => _i277.BookmarkRepositoryImpl(
          gh<_i760.BookmarkLocalDataSource>(),
          gh<_i47.ImageStorageDataSource>(),
        ));
    gh.factory<_i640.ThemeRepository>(
        () => _i308.ThemeRepositoryImpl(gh<_i814.ThemeLocalDataSource>()));
    gh.factory<_i793.ShelfRepository>(
        () => _i812.ShelfRepositoryImpl(gh<_i1026.ShelfLocalDataSource>()));
    gh.lazySingleton<_i716.SampleDataSeeder>(() => _i716.SampleDataSeeder(
          gh<_i315.BookLocalDataSource>(),
          gh<_i760.BookmarkLocalDataSource>(),
          gh<_i814.ThemeLocalDataSource>(),
          gh<_i1026.ShelfLocalDataSource>(),
        ));
  }
}

class _$DatabaseModule extends _i860.DatabaseModule {}
