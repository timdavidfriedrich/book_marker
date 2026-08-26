import 'package:book_marker/src/di/service_locator.config.dart';
import 'package:core/di/core_module.module.dart';
import 'package:feature_capture/di/feature_capture_module.module.dart';
import 'package:feature_library/di/feature_library_module.module.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/di/shared_module.module.dart';

final sl = GetIt.instance;

@InjectableInit(
  externalPackageModulesBefore: [
    ExternalModule(CorePackageModule),
    ExternalModule(SharedPackageModule),
    ExternalModule(FeatureCapturePackageModule),
    ExternalModule(FeatureLibraryPackageModule),
  ],
)
Future<void> configureDependencies() async => sl.init();
