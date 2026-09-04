import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/recognized_page.dart';

abstract class TextRecognitionRepository {
  Future<AppResult<RecognizedPage>> recognizePage(String imagePath);
}
