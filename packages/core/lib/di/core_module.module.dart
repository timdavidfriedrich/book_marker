// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:core/network/dio_module.dart' as _i840;
import 'package:core/security/aes_gcm_backup_verifier.dart' as _i70;
import 'package:core/security/aes_gcm_field_cipher.dart' as _i586;
import 'package:core/security/backup_verifier.dart' as _i93;
import 'package:core/security/field_cipher.dart' as _i92;
import 'package:core/security/master_key_store.dart' as _i375;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:injectable/injectable.dart' as _i526;

class CorePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final dioModule = _$DioModule();
    final secureStorageModule = _$SecureStorageModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => secureStorageModule.secureStorage());
    gh.lazySingleton<_i375.MasterKeyStore>(
        () => _i375.MasterKeyStoreImpl(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i93.BackupVerifier>(
        () => const _i70.AesGcmBackupVerifier());
    gh.lazySingleton<_i92.FieldCipher>(
        () => _i586.AesGcmFieldCipher(gh<_i375.MasterKeyStore>()));
  }
}

class _$DioModule extends _i840.DioModule {}

class _$SecureStorageModule extends _i375.SecureStorageModule {}
