import 'package:dart_mappable/dart_mappable.dart';

part 'remote_open_library_book.mapper.dart';

@MappableClass()
class const RemoteOpenLibraryBook({
  required final String? title,
  @MappableField(key: "author_name") required final List<String>? authorNames,
  required final List<String>? isbn,
  @MappableField(key: "cover_i") required final int? coverId,
}) with RemoteOpenLibraryBookMappable;
