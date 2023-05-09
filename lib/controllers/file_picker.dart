import 'dart:io';

// import 'package:beichee/utils/toasts.dart';
import 'package:file_picker/file_picker.dart';

Future<List<File>> pickImages() async {
  List<File>? files = [];

  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowCompression: true,
      allowedExtensions: ['jpg', 'png', 'gif', 'jpeg'],
      allowMultiple: false);

  if (result != null) {
    files = result.paths.map((path) => File(path!)).toList();
    for (var file in files) {
      if (file.lengthSync() > 500000) {
        files.remove(file);
        // errorToast("You can not upload big picture size");
        break;
      }
    }
  } else {
    // User canceled the picker
  }
  return files;
}
