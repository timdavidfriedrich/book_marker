import 'package:dart_mappable/dart_mappable.dart';

part 'page_quad.mapper.dart';

@MappableClass()
class const PagePoint({
  required final double x,
  required final double y,
}) with PagePointMappable;

@MappableClass()
class const PageQuad({
  required final PagePoint topLeft,
  required final PagePoint topRight,
  required final PagePoint bottomRight,
  required final PagePoint bottomLeft,
}) with PageQuadMappable;

// * marks an image that is already cropped, so page detection leaves it untouched
const fullFramePageQuad = PageQuad(
  topLeft: PagePoint(x: 0, y: 0),
  topRight: PagePoint(x: 1, y: 0),
  bottomRight: PagePoint(x: 1, y: 1),
  bottomLeft: PagePoint(x: 0, y: 1),
);

enum PageCorner { topLeft, topRight, bottomRight, bottomLeft }
