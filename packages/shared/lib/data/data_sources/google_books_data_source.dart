import 'package:core/config/build_config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/mappers/isbn_extensions.dart';
import 'package:shared/data/models/remote_google_book.dart';

const _endpoint = "https://www.googleapis.com/books/v1/volumes";
const _fields = "items(volumeInfo(title,authors,industryIdentifiers,imageLinks))";
const _maxResults = 20;
const _isbnQueryPrefix = "isbn:";

abstract class GoogleBooksDataSource {
  Future<List<RemoteGoogleBook>> searchBooks(String query);
}

@Injectable(as: GoogleBooksDataSource)
class const GoogleBooksDataSourceImpl(
  final Dio _dio,
) implements GoogleBooksDataSource {
  @override
  Future<List<RemoteGoogleBook>> searchBooks(String query) async {
    final response = await _dio.get<Map<String, dynamic>>(
      _endpoint,
      queryParameters: {
        // * a bare number matches nothing; the catalogue only resolves an ISBN behind its prefix
        "q": query.isIsbn ? "$_isbnQueryPrefix$query" : query,
        "fields": _fields,
        "maxResults": _maxResults,
        if (googleBooksApiKey.isNotEmpty) "key": googleBooksApiKey,
      },
    );
    final items = (response.data?["items"] as List<dynamic>?) ?? const [];
    return items
        .map(
          (it) => RemoteGoogleBookMapper.fromMap(
            (it as Map<dynamic, dynamic>).cast<String, dynamic>(),
          ),
        )
        .toList();
  }
}
