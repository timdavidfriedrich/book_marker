import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/mappers/isbn_extensions.dart';
import 'package:shared/data/models/remote_open_library_book.dart';

const _endpoint = "https://openlibrary.org/search.json";
const _fields = "title,author_name,isbn,cover_i";
const _limit = 20;

abstract class OpenLibraryDataSource {
  Future<List<RemoteOpenLibraryBook>> searchBooks(String query);
}

@Injectable(as: OpenLibraryDataSource)
class const OpenLibraryDataSourceImpl(
  final Dio _dio,
) implements OpenLibraryDataSource {
  @override
  Future<List<RemoteOpenLibraryBook>> searchBooks(String query) async {
    final response = await _dio.get<Map<String, dynamic>>(
      _endpoint,
      queryParameters: {
        // * the dedicated parameter resolves an ISBN reliably, while the free text one times out
        if (query.isIsbn) "isbn": query else "q": query,
        "fields": _fields,
        "limit": _limit,
      },
    );
    final documents = (response.data?["docs"] as List<dynamic>?) ?? const [];
    return documents
        .map(
          (it) => RemoteOpenLibraryBookMapper.fromMap(
            (it as Map<dynamic, dynamic>).cast<String, dynamic>(),
          ),
        )
        .toList();
  }
}
