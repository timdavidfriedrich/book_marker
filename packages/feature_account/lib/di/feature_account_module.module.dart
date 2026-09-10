// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:core/security/master_key_store.dart' as _i375;
import 'package:feature_account/presentation/recovery_code/recovery_code_bloc.dart' as _i70;
import 'package:injectable/injectable.dart' as _i526;

class FeatureAccountPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i70.RecoveryCodeBloc>(() => _i70.RecoveryCodeBloc(gh<_i375.MasterKeyStore>()));
  }
}
