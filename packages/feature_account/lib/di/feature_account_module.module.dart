// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:core/security/backup_verifier.dart' as _i93;
import 'package:core/security/master_key_store.dart' as _i375;
import 'package:core/sync/sync_service.dart' as _i336;
import 'package:feature_account/presentation/delete_account/delete_account_bloc.dart' as _i653;
import 'package:feature_account/presentation/recovery_code/recovery_code_bloc.dart' as _i70;
import 'package:feature_account/presentation/unlock/unlock_bloc.dart' as _i900;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/data/database/library_reencryption.dart' as _i55;
import 'package:shared/domain/repositories/auth_repository.dart' as _i1022;
import 'package:shared/domain/repositories/entitlement_repository.dart' as _i446;

class FeatureAccountPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i70.RecoveryCodeBloc>(
      () => _i70.RecoveryCodeBloc(
        gh<_i375.MasterKeyStore>(),
        gh<_i93.BackupVerifier>(),
        gh<_i446.EntitlementRepository>(),
      ),
    );
    gh.factory<_i653.DeleteAccountBloc>(
      () => _i653.DeleteAccountBloc(
        gh<_i1022.AuthRepository>(),
        gh<_i336.SyncService>(),
      ),
    );
    gh.factory<_i900.UnlockBloc>(
      () => _i900.UnlockBloc(
        gh<_i446.EntitlementRepository>(),
        gh<_i93.BackupVerifier>(),
        gh<_i375.MasterKeyStore>(),
        gh<_i55.LibraryReencryption>(),
      ),
    );
  }
}
