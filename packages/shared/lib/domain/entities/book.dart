import 'package:dart_mappable/dart_mappable.dart';

part 'book.mapper.dart';

@MappableEnum()
enum BookStatus { reading, paused, finished }

@MappableClass()
class const Book({
  required final String id,
  required final String title,
  required final List<String> authors,
  required final String? isbn,
  required final String? thumbnailUrl,
  required final String? coverPath,
  required final BookStatus status,
  required final DateTime createdAt,
  required final DateTime lastUsedAt,
}) with BookMappable {
  String? get coverImage => coverPath ?? thumbnailUrl;
}
