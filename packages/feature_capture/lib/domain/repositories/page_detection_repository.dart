import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/camera_frame.dart';
import 'package:shared/domain/entities/page_detection.dart';
import 'package:shared/domain/entities/page_quad.dart';

abstract class PageDetectionRepository {
  Future<AppResult<PageQuad?>> detectInFrame(CameraFrame frame);

  Future<AppResult<PageDetection>> detectInImage(String imagePath);

  Future<AppResult<String>> cropToQuad({
    required String imagePath,
    required PageQuad quad,
    required int maxSize,
  });
}
