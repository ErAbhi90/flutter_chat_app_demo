import 'dart:io';

import 'package:flutter_chat_app_demo/app_settings/settings.dart';
import 'package:flutter_chat_app_demo/widgets/image_picker/user_image_picker_view_model.dart';

class UserImagePicker extends StatelessWidget {
  const UserImagePicker({super.key, required this.onPickedImage});

  final void Function(File pickedImage) onPickedImage;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserImagePickerViewModel>(
      create: (_) => UserImagePickerViewModel(onPickedImage),
      child: Consumer<UserImagePickerViewModel>(
        builder: (context, vm, _) => Column(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundColor: AppColors.borderColor,
              foregroundImage: vm.getPickedImage(),
            ),
            TextButton.icon(
              onPressed: vm.onPickImage,
              icon: const Icon(Icons.image),
              label: Text(
                'Add Image',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
