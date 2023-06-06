import 'dart:io';

import 'package:flutter_chat_app_demo/app_settings/settings.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePickerViewModel with ChangeNotifier {
  final void Function(File pickedImage) onPickedImage;
  File? pickedImageFile;

  UserImagePickerViewModel(this.onPickedImage);

  ImageProvider<Object>? getPickedImage() {
    return pickedImageFile != null ? FileImage(pickedImageFile!) : null;
  }

  void onPickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage == null) return;
    pickedImageFile = File(pickedImage.path);
    onPickedImage(pickedImageFile!);
    notifyListeners();
  }
}
