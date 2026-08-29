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

enum PageCorner { topLeft, topRight, bottomRight, bottomLeft }
