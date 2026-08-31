import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/page_quad.dart';

sealed class CropState {
  const CropState();
}

class const CropLoading() extends CropState;

class const CropReady({
  required final String imagePath,
  required final double aspectRatio,
  required final PageQuad quad,
}) extends CropState;

class const CropFailure({
  required final AppError error,
}) extends CropState;
