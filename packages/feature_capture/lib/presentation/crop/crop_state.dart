import 'package:core/error/app_error.dart';
import 'package:feature_capture/domain/crop_page.dart';

sealed class CropState {
  const CropState();
}

class const CropLoading() extends CropState;

class const CropReady({
  required final List<CropPage> pages,
  required final int selectedIndex,
  required final bool hasAdjusted,
  required final bool isAdding,
  required final AppError? addError,
}) extends CropState {
  CropPage get selectedPage => pages[selectedIndex];
}

class const CropFailure({
  required final AppError error,
}) extends CropState;
