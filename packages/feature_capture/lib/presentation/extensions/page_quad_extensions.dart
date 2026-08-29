import 'package:shared/domain/entities/page_quad.dart';

extension PageQuadExtensions on PageQuad {
  PagePoint pointAt(PageCorner corner) => switch (corner) {
    PageCorner.topLeft => topLeft,
    PageCorner.topRight => topRight,
    PageCorner.bottomRight => bottomRight,
    PageCorner.bottomLeft => bottomLeft,
  };

  PageQuad withPointAt(PageCorner corner, PagePoint point) => switch (corner) {
    PageCorner.topLeft => copyWith(topLeft: point),
    PageCorner.topRight => copyWith(topRight: point),
    PageCorner.bottomRight => copyWith(bottomRight: point),
    PageCorner.bottomLeft => copyWith(bottomLeft: point),
  };
}
