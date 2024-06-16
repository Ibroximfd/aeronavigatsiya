import 'dart:io';
import 'package:aviatoruz/core/services/rtdb_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final editNotifier = ChangeNotifierProvider((ref) => EditNotifier());

class EditNotifier with ChangeNotifier {
  //textcontroller
  TextEditingController newNameContrlLang = TextEditingController();
  TextEditingController newDiscCtrlLang = TextEditingController();

  final picker = ImagePicker();

  File? _image; // Make image nullable

  File? get imageLang => _image; // Getter for image

  Future<void> getImageLang(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(
        source: source,
      );

      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
    notifyListeners();
  }

  //another way

  File? _imageSecond; // Make image nullable

  File? get imageSecond => _imageSecond;

  Future<void> getImageSecondLang(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(
        source: source,
      );

      if (pickedFile != null) {
        _imageSecond = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
    notifyListeners();
  }
  // final picker = ImagePicker();

  // Future<void> selectImages() async {
  //   try {
  //     final List<XFile> pickedFiles = await picker.pickMultiImage(limit: 2);
  //     if (pickedFiles.length >= 2) {
  //       _imageUrls = [];
  //       for (var pickedFile in pickedFiles) {
  //         final file = File(pickedFile.path);
  //         final storageReference = FirebaseStorage.instance.ref().child(
  //             '${NetworkServiceConst.meteoTopicsImage}/${DateTime.now().millisecondsSinceEpoch}.jpg');
  //         final uploadTask = storageReference.putFile(file);
  //         final completedTask = await uploadTask;
  //         final downloadUrl = await completedTask.ref.getDownloadURL();
  //         _imageUrls.add(downloadUrl);
  //       }
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print("Error selecting images: $e");
  //   }
  // }

  Future<void> updateItemById({
    required String id,
    required String title,
    required String patternPath,
    required String imagePath,
    required String imagePathSecond,
    required String path,
    required String description,
    required File imageFile,
    required File imageFileSecond,
  }) async {
    await RTDBService.updateItemById(
      id: id,
      newTitle: title,
      patternPath: patternPath,
      imagePath: imagePath,
      path: path,
      newDescription: description,
      imagePathSecond: imagePathSecond,
      newImageFile: imageFile,
      newImageFileSecond: imageFileSecond,
    );
    notifyListeners();
  }
}
