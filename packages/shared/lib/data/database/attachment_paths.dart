import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

const attachmentsFolder = "attachments";
const photoExtension = "jpg";
const voiceNoteExtension = "m4a";

// * every attachment file is <root>/<id>.<ext>, which makes the id and the path
// * the same fact written two ways. The row stores the id, the entity carries
// * the resolved path, and neither the UI nor the mappers learn that a file may
// * not be on this device yet: a missing file already had to be survivable,
// * because a photo can be deleted from underneath the app at any time.
class const AttachmentPaths(
  final String root,
) {
  static Future<AttachmentPaths> resolve() async {
    final directory = await getApplicationDocumentsDirectory();
    return AttachmentPaths(p.join(directory.path, attachmentsFolder));
  }

  String pathFor(String attachmentId, String extension) => p.join(root, "$attachmentId.$extension");

  String? idFrom(String? path) => path == null ? null : p.basenameWithoutExtension(path);
}

// * an id plus what to call the file. The queue needs both, and the extension
// * is not derivable from the id
class const AttachmentReference({
  required final String id,
  required final String extension,
});
