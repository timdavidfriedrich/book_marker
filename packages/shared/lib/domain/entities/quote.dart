import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/highlight_region.dart';

part 'quote.mapper.dart';

@MappableClass()
class const Quote({
  required final String id,
  required final String bookId,
  required final int? pageNumber,
  required final String quote,
  required final String? note,
  required final String? voiceNotePath,
  required final int? voiceNoteDurationMs,
  required final String photoPath,
  required final double imageAspectRatio,
  required final List<HighlightRegion> highlights,
  required final bool isFavorite,
  required final DateTime createdAt,
}) with QuoteMappable;
