// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:book_marker_client/book_marker_client.dart' as _i63;
import 'package:core/security/backup_verifier.dart' as _i93;
import 'package:core/security/database_key_store.dart' as _i405;
import 'package:core/security/field_cipher.dart' as _i92;
import 'package:core/security/master_key_store.dart' as _i375;
import 'package:dio/dio.dart' as _i361;
import 'package:injectable/injectable.dart' as _i526;
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart'
    as _i90;
import 'package:shared/data/data_sources/app_config_local_data_source.dart'
    as _i49;
import 'package:shared/data/data_sources/app_config_remote_data_source.dart'
    as _i223;
import 'package:shared/data/data_sources/book_cover_data_source.dart' as _i510;
import 'package:shared/data/data_sources/book_local_data_source.dart' as _i315;
import 'package:shared/data/data_sources/entitlement_remote_data_source.dart'
    as _i1039;
import 'package:shared/data/data_sources/google_books_data_source.dart'
    as _i357;
import 'package:shared/data/data_sources/image_storage_data_source.dart'
    as _i47;
import 'package:shared/data/data_sources/open_library_data_source.dart'
    as _i492;
import 'package:shared/data/data_sources/quote_local_data_source.dart' as _i516;
import 'package:shared/data/data_sources/serverpod_auth_data_source.dart'
    as _i502;
import 'package:shared/data/data_sources/settings_local_data_source.dart'
    as _i115;
import 'package:shared/data/data_sources/shelf_local_data_source.dart'
    as _i1026;
import 'package:shared/data/data_sources/theme_local_data_source.dart' as _i814;
import 'package:shared/data/database/app_database.dart' as _i50;
import 'package:shared/data/database/cipher_codec.dart' as _i807;
import 'package:shared/data/database/database_module.dart' as _i860;
import 'package:shared/data/database/sync_database.dart' as _i659;
import 'package:shared/data/network/serverpod_client_module.dart' as _i665;
import 'package:shared/data/repositories/app_config_repository_impl.dart'
    as _i509;
import 'package:shared/data/repositories/auth_repository_impl.dart' as _i674;
import 'package:shared/data/repositories/book_repository_impl.dart' as _i245;
import 'package:shared/data/repositories/entitlement_repository_impl.dart'
    as _i1011;
import 'package:shared/data/repositories/quote_repository_impl.dart' as _i943;
import 'package:shared/data/repositories/sample_data_repository_impl.dart'
    as _i136;
import 'package:shared/data/repositories/settings_repository_impl.dart'
    as _i921;
import 'package:shared/data/repositories/shelf_repository_impl.dart' as _i812;
import 'package:shared/data/repositories/theme_repository_impl.dart' as _i308;
import 'package:shared/data/repositories/voice_note_repository_impl.dart'
    as _i908;
import 'package:shared/data/sample_data_seeder.dart' as _i716;
import 'package:shared/domain/repositories/app_config_repository.dart' as _i541;
import 'package:shared/domain/repositories/auth_repository.dart' as _i1022;
import 'package:shared/domain/repositories/book_repository.dart' as _i748;
import 'package:shared/domain/repositories/entitlement_repository.dart'
    as _i446;
import 'package:shared/domain/repositories/quote_repository.dart' as _i570;
import 'package:shared/domain/repositories/sample_data_repository.dart'
    as _i124;
import 'package:shared/domain/repositories/settings_repository.dart' as _i0;
import 'package:shared/domain/repositories/shelf_repository.dart' as _i793;
import 'package:shared/domain/repositories/theme_repository.dart' as _i640;
import 'package:shared/domain/repositories/voice_note_repository.dart' as _i88;
import 'package:shared/presentation/account/account_bloc.dart' as _i880;
import 'package:shared/presentation/app_config/app_config_cubit.dart' as _i56;
import 'package:shared/presentation/navigation/route_change_observer.dart'
    as _i533;
import 'package:shared/presentation/voice_note_cubit.dart' as _i610;

class SharedPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) async {
    final serverpodClientModule = _$ServerpodClientModule();
    final databaseModule = _$DatabaseModule();
    gh.lazySingleton<_i90.FlutterAuthSessionManager>(
        () => serverpodClientModule.sessionManager());
    gh.lazySingleton<_i533.RouteChangeNotifier>(
        () => _i533.RouteChangeNotifier());
    gh.factory<_i47.ImageStorageDataSource>(
        () => const _i47.ImageStorageDataSourceImpl());
    gh.factory<_i510.BookCoverDataSource>(
        () => _i510.BookCoverDataSourceImpl(gh<_i361.Dio>()));
    gh.factory<_i492.OpenLibraryDataSource>(
        () => _i492.OpenLibraryDataSourceImpl(gh<_i361.Dio>()));
    gh.factory<_i357.GoogleBooksDataSource>(
        () => _i357.GoogleBooksDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i807.CipherCodec>(
        () => _i807.CipherCodec(gh<_i92.FieldCipher>()));
    gh.factory<_i88.VoiceNoteRepository>(() => _i908.VoiceNoteRepositoryImpl());
    gh.factory<_i610.VoiceNoteCubit>(() => _i610.VoiceNoteCubit(
          gh<_i88.VoiceNoteRepository>(),
          gh<_i533.RouteChangeNotifier>(),
        ));
    gh.lazySingleton<_i63.Client>(() =>
        serverpodClientModule.client(gh<_i90.FlutterAuthSessionManager>()));
    await gh.lazySingletonAsync<_i659.SyncDatabase>(
      () => databaseModule.syncDatabase(gh<_i405.DatabaseKeyStore>()),
      preResolve: true,
    );
    gh.factory<_i1039.EntitlementRemoteDataSource>(
        () => _i1039.EntitlementRemoteDataSourceImpl(gh<_i63.Client>()));
    gh.factory<_i446.EntitlementRepository>(() =>
        _i1011.EntitlementRepositoryImpl(
            gh<_i1039.EntitlementRemoteDataSource>()));
    gh.lazySingleton<_i50.AppDatabase>(
        () => databaseModule.appDatabase(gh<_i659.SyncDatabase>()));
    gh.factory<_i49.AppConfigLocalDataSource>(
        () => _i49.AppConfigLocalDataSourceImpl(gh<_i50.AppDatabase>()));
    gh.factory<_i223.AppConfigRemoteDataSource>(
        () => _i223.AppConfigRemoteDataSourceImpl(gh<_i63.Client>()));
    gh.factory<_i1026.ShelfLocalDataSource>(
        () => _i1026.ShelfLocalDataSourceImpl(
              gh<_i50.AppDatabase>(),
              gh<_i807.CipherCodec>(),
            ));
    gh.factory<_i502.ServerpodAuthDataSource>(
        () => _i502.ServerpodAuthDataSourceImpl(
              gh<_i63.Client>(),
              gh<_i90.FlutterAuthSessionManager>(),
            ));
    gh.factory<_i793.ShelfRepository>(
        () => _i812.ShelfRepositoryImpl(gh<_i1026.ShelfLocalDataSource>()));
    gh.factory<_i516.QuoteLocalDataSource>(() => _i516.QuoteLocalDataSourceImpl(
          gh<_i50.AppDatabase>(),
          gh<_i807.CipherCodec>(),
        ));
    gh.factory<_i814.ThemeLocalDataSource>(() => _i814.ThemeLocalDataSourceImpl(
          gh<_i50.AppDatabase>(),
          gh<_i807.CipherCodec>(),
        ));
    gh.factory<_i315.BookLocalDataSource>(() => _i315.BookLocalDataSourceImpl(
          gh<_i50.AppDatabase>(),
          gh<_i807.CipherCodec>(),
        ));
    gh.factory<_i541.AppConfigRepository>(() => _i509.AppConfigRepositoryImpl(
          gh<_i223.AppConfigRemoteDataSource>(),
          gh<_i49.AppConfigLocalDataSource>(),
        ));
    gh.factory<_i570.QuoteRepository>(() => _i943.QuoteRepositoryImpl(
          gh<_i516.QuoteLocalDataSource>(),
          gh<_i814.ThemeLocalDataSource>(),
          gh<_i47.ImageStorageDataSource>(),
        ));
    gh.factory<_i115.SettingsLocalDataSource>(
        () => _i115.SettingsLocalDataSourceImpl(gh<_i50.AppDatabase>()));
    gh.factory<_i56.AppConfigCubit>(
        () => _i56.AppConfigCubit(gh<_i541.AppConfigRepository>()));
    gh.factory<_i0.SettingsRepository>(() =>
        _i921.SettingsRepositoryImpl(gh<_i115.SettingsLocalDataSource>()));
    gh.factory<_i640.ThemeRepository>(
        () => _i308.ThemeRepositoryImpl(gh<_i814.ThemeLocalDataSource>()));
    gh.factory<_i1022.AuthRepository>(
        () => _i674.AuthRepositoryImpl(gh<_i502.ServerpodAuthDataSource>()));
    gh.factory<_i748.BookRepository>(() => _i245.BookRepositoryImpl(
          gh<_i315.BookLocalDataSource>(),
          gh<_i357.GoogleBooksDataSource>(),
          gh<_i492.OpenLibraryDataSource>(),
          gh<_i510.BookCoverDataSource>(),
          gh<_i1026.ShelfLocalDataSource>(),
        ));
    gh.lazySingleton<_i716.SampleDataSeeder>(() => _i716.SampleDataSeeder(
          gh<_i315.BookLocalDataSource>(),
          gh<_i516.QuoteLocalDataSource>(),
          gh<_i814.ThemeLocalDataSource>(),
          gh<_i1026.ShelfLocalDataSource>(),
        ));
    gh.factory<_i124.SampleDataRepository>(
        () => _i136.SampleDataRepositoryImpl(gh<_i716.SampleDataSeeder>()));
    gh.factory<_i880.AccountBloc>(() => _i880.AccountBloc(
          gh<_i1022.AuthRepository>(),
          gh<_i375.MasterKeyStore>(),
          gh<_i93.BackupVerifier>(),
          gh<_i446.EntitlementRepository>(),
        ));
  }
}

class _$ServerpodClientModule extends _i665.ServerpodClientModule {}

class _$DatabaseModule extends _i860.DatabaseModule {}
