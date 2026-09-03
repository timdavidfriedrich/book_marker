import 'package:shared/domain/entities/page_quad.dart';

sealed class CropEvent {
  const CropEvent();
}

class const CropStarted() extends CropEvent;

class const CropPagesAdded(
  final List<String> imagePaths,
) extends CropEvent;

class const CropPageSelected(
  final int index,
) extends CropEvent;

class const CropPageRemoved(
  final int index,
) extends CropEvent;

class const CropPageRotated() extends CropEvent;

class const CropPageMoved(
  final int fromIndex,
  final int toIndex,
) extends CropEvent;

class const CropCornerMoved(
  final PageCorner corner,
  final PagePoint position,
) extends CropEvent;
