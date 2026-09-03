import 'package:shared/domain/entities/page_quad.dart';

const _minConfidence = 0.7;
const _fullTurn = 4;

class const CropPage({
  required final String imagePath,
  required final double aspectRatio,
  required final PageQuad quad,
  required final double confidence,
  required final bool isAdjusted,
  required final int quarterTurns,
}) {
  bool get isUnsure => !isAdjusted && confidence < _minConfidence;

  double get displayAspectRatio => quarterTurns.isEven ? aspectRatio : 1 / aspectRatio;

  // * every page reserves the upright footprint, so a landscape one keeps the layout in place
  double get portraitAspectRatio => aspectRatio < 1 ? aspectRatio : 1 / aspectRatio;

  // * the corner roles carry the turns, so the perspective crop already writes an upright page
  PageQuad get sourceQuad {
    var source = quad;
    for (var turn = 0; turn < quarterTurns; turn++) {
      source = PageQuad(
        topLeft: _unturned(source.topLeft),
        topRight: _unturned(source.topRight),
        bottomRight: _unturned(source.bottomRight),
        bottomLeft: _unturned(source.bottomLeft),
      );
    }
    return source;
  }

  CropPage adjustedTo(PageQuad quad) => CropPage(
    imagePath: imagePath,
    aspectRatio: aspectRatio,
    quad: quad,
    confidence: confidence,
    isAdjusted: true,
    quarterTurns: quarterTurns,
  );

  CropPage turnedClockwise() => CropPage(
    imagePath: imagePath,
    aspectRatio: aspectRatio,
    quad: PageQuad(
      topLeft: _turned(quad.bottomLeft),
      topRight: _turned(quad.topLeft),
      bottomRight: _turned(quad.topRight),
      bottomLeft: _turned(quad.bottomRight),
    ),
    confidence: confidence,
    isAdjusted: isAdjusted,
    quarterTurns: (quarterTurns + 1) % _fullTurn,
  );
}

PagePoint _turned(PagePoint point) => PagePoint(x: 1 - point.y, y: point.x);

PagePoint _unturned(PagePoint point) => PagePoint(x: point.y, y: 1 - point.x);
