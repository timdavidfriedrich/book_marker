// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:book_marker/src/navigation/navigation_router.dart' as _i837;
import 'package:core/di/core_module.module.dart' as _i8;
import 'package:feature_capture/di/feature_capture_module.module.dart' as _i816;
import 'package:feature_library/di/feature_library_module.module.dart' as _i949;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/di/shared_module.module.dart' as _i826;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    await _i8.CorePackageModule().init(gh);
    await _i826.SharedPackageModule().init(gh);
    await _i816.FeatureCapturePackageModule().init(gh);
    await _i949.FeatureLibraryPackageModule().init(gh);
    gh.singleton<_i837.NavigationRouter>(() => _i837.NavigationRouter());
    return this;
  }
}
