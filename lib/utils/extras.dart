import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Extras {
  static Future<PickedFile> pickImage(bool fromCamera) async {
    final ImagePicker picker = ImagePicker();
    final PickedFile file = await picker.getImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    return file;
  }

  static getFilename(String path) {
    return basename(path);
  }
}
