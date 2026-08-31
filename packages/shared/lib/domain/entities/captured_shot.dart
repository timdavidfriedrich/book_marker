import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/page_quad.dart';

part 'captured_shot.mapper.dart';

@MappableClass()
class const CapturedShot({
  required final String imagePath,
  required final PageQuad? pageQuad,
}) with CapturedShotMappable;
