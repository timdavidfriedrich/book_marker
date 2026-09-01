import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/sample_data_seeder.dart';
import 'package:shared/domain/repositories/sample_data_repository.dart';

@Injectable(as: SampleDataRepository)
class const SampleDataRepositoryImpl(
  final SampleDataSeeder _seeder,
) implements SampleDataRepository {
  @override
  Future<AppResult<bool>> hasSampleData() async {
    try {
      return Success(await _seeder.hasSampleData());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> seedSampleData() async {
    try {
      await _seeder.seedSampleData();
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }
}
