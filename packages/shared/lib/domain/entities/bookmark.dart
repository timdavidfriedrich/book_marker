import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/highlight_region.dart';

part 'bookmark.mapper.dart';

@MappableClass()
class const Bookmark({
  required final String id,
  required final String bookId,
  required final int? pageNumber,
  required final String quote,
  required final String? note,
  required final String? voicePath,
  required final int? voiceDurationMs,
  required final String photoPath,
  required final double imageAspectRatio,
  required final List<HighlightRegion> highlights,
  required final bool isFavorite,
  required final DateTime createdAt,
}) with BookmarkMappable;
