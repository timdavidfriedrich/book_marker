import 'package:shared/domain/entities/page_quad.dart';

sealed class CropEvent {
  const CropEvent();
}

class const CropStarted() extends CropEvent;

class const CropCornerMoved(
  final PageCorner corner,
  final PagePoint position,
) extends CropEvent;
