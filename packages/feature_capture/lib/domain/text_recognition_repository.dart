import 'package:core/error/app_result.dart';
import 'package:feature_capture/domain/recognized_page.dart';

abstract class TextRecognitionRepository {
  Future<AppResult<RecognizedPage>> recognizePage(String imagePath);
}
