import 'package:core/error/app_result.dart';

abstract class SampleDataRepository {
  Future<AppResult<bool>> hasSampleData();

  Future<AppResult<()>> seedSampleData();
}
