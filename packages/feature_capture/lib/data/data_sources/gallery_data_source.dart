import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class const GalleryDataSource() {
  Future<List<String>> pickImages() async {
    final files = await ImagePicker().pickMultiImage();
    return [for (final file in files) file.path];
  }
}
