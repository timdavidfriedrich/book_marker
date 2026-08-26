import 'package:dart_mappable/dart_mappable.dart';

part 'book.mapper.dart';

@MappableClass()
class const Book({
  required final String id,
  required final String title,
  required final List<String> authors,
  required final String? isbn,
  required final String? thumbnailUrl,
  required final DateTime createdAt,
  required final DateTime lastUsedAt,
}) with BookMappable;
