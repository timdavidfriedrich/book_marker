import 'package:dart_mappable/dart_mappable.dart';

part 'highlight_region.mapper.dart';

@MappableClass()
class const HighlightRegion({
  required final String text,
  required final double left,
  required final double top,
  required final double width,
  required final double height,
}) with HighlightRegionMappable;
