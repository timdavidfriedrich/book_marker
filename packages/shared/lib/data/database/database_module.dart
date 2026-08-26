import 'package:injectable/injectable.dart';
import 'package:shared/data/database/app_database.dart';

@module
abstract class DatabaseModule {
  @lazySingleton
  AppDatabase appDatabase() => AppDatabase();
}
