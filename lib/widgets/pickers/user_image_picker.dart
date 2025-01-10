import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.purple,
          backgroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage!),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text('Add Image'),
        ),
      ],
    );
  }
}
