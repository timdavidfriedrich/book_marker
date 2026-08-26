import 'package:dart_mappable/dart_mappable.dart';

part 'remote_book.mapper.dart';

@MappableClass()
class const RemoteBook({
  required final RemoteVolumeInfo? volumeInfo,
}) with RemoteBookMappable;

@MappableClass()
class const RemoteVolumeInfo({
  required final String? title,
  required final List<String>? authors,
  required final List<RemoteIndustryIdentifier>? industryIdentifiers,
  required final RemoteImageLinks? imageLinks,
}) with RemoteVolumeInfoMappable;

@MappableClass()
class const RemoteIndustryIdentifier({
  required final String? type,
  required final String? identifier,
}) with RemoteIndustryIdentifierMappable;

@MappableClass()
class const RemoteImageLinks({
  required final String? thumbnail,
  required final String? smallThumbnail,
}) with RemoteImageLinksMappable;
