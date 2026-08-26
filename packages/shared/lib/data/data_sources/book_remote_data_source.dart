import 'package:core/config/build_config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/models/remote_book.dart';

const _endpoint = "https://www.googleapis.com/books/v1/volumes";
const _fields = "items(volumeInfo(title,authors,industryIdentifiers,imageLinks))";
const _maxResults = 20;
const _isbnQueryPrefix = "isbn:";
final _isbnPattern = RegExp(r"^\d{10}(\d{3})?$");

abstract class BookRemoteDataSource {
  Future<List<RemoteBook>> searchBooks(String query);
}

@Injectable(as: BookRemoteDataSource)
class const BookRemoteDataSourceImpl(
  final Dio _dio,
) implements BookRemoteDataSource {
  @override
  Future<List<RemoteBook>> searchBooks(String query) async {
    final trimmed = query.trim();
    final isIsbn = _isbnPattern.hasMatch(trimmed);
    final response = await _dio.get<Map<String, dynamic>>(
      _endpoint,
      queryParameters: {
        "q": isIsbn ? "$_isbnQueryPrefix$trimmed" : trimmed,
        "fields": _fields,
        "maxResults": _maxResults,
        "key": googleBooksApiKey,
      },
    );
    final items = (response.data?["items"] as List<dynamic>?) ?? const [];
    return items
        .map(
          (it) => RemoteBookMapper.fromMap((it as Map<dynamic, dynamic>).cast<String, dynamic>()),
        )
        .toList();
  }
}
