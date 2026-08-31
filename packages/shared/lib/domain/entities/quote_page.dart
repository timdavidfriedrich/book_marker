import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/highlight_region.dart';

part 'quote_page.mapper.dart';

@MappableClass()
class const QuotePage({
  required final String photoPath,
  required final double imageAspectRatio,
  required final List<HighlightRegion> highlights,
}) with QuotePageMappable;
