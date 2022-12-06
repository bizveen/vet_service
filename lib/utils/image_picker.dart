import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickImage(ImageSource imageSource) async {
  ImagePicker _imagePicker = ImagePicker();
  XFile? file = await _imagePicker.pickImage(source: imageSource);
  if (file != null) {
    return file.readAsBytes();
  }else{
    return null;
  }
}
