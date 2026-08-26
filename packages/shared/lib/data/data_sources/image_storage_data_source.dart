import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

const _imagesFolder = "bookmark_photos";

abstract class ImageStorageDataSource {
  Future<String> persistImage(String sourcePath, String id);
}

@Injectable(as: ImageStorageDataSource)
class const ImageStorageDataSourceImpl() implements ImageStorageDataSource {
  @override
  Future<String> persistImage(String sourcePath, String id) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final targetDirectory = Directory("${documentsDirectory.path}/$_imagesFolder");
    if (!targetDirectory.existsSync()) {
      await targetDirectory.create(recursive: true);
    }
    final targetPath = "${targetDirectory.path}/$id.jpg";
    await File(sourcePath).copy(targetPath);
    return targetPath;
  }
}
