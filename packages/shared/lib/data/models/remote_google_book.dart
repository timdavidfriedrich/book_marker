import 'package:dart_mappable/dart_mappable.dart';

part 'remote_google_book.mapper.dart';

@MappableClass()
class const RemoteGoogleBook({
  required final RemoteGoogleVolumeInfo? volumeInfo,
}) with RemoteGoogleBookMappable;

@MappableClass()
class const RemoteGoogleVolumeInfo({
  required final String? title,
  required final List<String>? authors,
  required final List<RemoteGoogleIndustryIdentifier>? industryIdentifiers,
  required final RemoteGoogleImageLinks? imageLinks,
}) with RemoteGoogleVolumeInfoMappable;

@MappableClass()
class const RemoteGoogleIndustryIdentifier({
  required final String? type,
  required final String? identifier,
}) with RemoteGoogleIndustryIdentifierMappable;

@MappableClass()
class const RemoteGoogleImageLinks({
  required final String? thumbnail,
  required final String? smallThumbnail,
}) with RemoteGoogleImageLinksMappable;
