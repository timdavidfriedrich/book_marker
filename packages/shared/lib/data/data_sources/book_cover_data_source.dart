import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

const _coversFolder = "book_covers";
const _coverExtension = ".jpg";
const _emptyCoverMessage = "empty cover response";
const _coverTimeout = Duration(seconds: 10);

abstract class BookCoverDataSource {
  Future<String> downloadCover({required String url, required String bookId});

  Future<bool> hasCover(String path);

  Future<void> deleteCover(String path);
}

@Injectable(as: BookCoverDataSource)
class const BookCoverDataSourceImpl(
  final Dio _dio,
) implements BookCoverDataSource {
  @override
  Future<String> downloadCover({required String url, required String bookId}) async {
    final response = await _dio.get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        receiveTimeout: _coverTimeout,
        sendTimeout: _coverTimeout,
      ),
    );
    final bytes = response.data;
    if (bytes == null || bytes.isEmpty) throw const FormatException(_emptyCoverMessage);
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final targetDirectory = Directory("${documentsDirectory.path}/$_coversFolder");
    if (!targetDirectory.existsSync()) {
      await targetDirectory.create(recursive: true);
    }
    final targetPath = "${targetDirectory.path}/$bookId$_coverExtension";
    await File(targetPath).writeAsBytes(bytes, flush: true);
    return targetPath;
  }

  @override
  Future<bool> hasCover(String path) => File(path).exists();

  @override
  Future<void> deleteCover(String path) async {
    final file = File(path);
    if (file.existsSync()) await file.delete();
  }
}
