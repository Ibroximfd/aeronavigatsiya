import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final addTopicLangController =
    ChangeNotifierProvider((ref) => AddTopicController());

class AddTopicController with ChangeNotifier {
  //textcontroller
  TextEditingController nameContrlLang = TextEditingController();
  TextEditingController discCtrlLang = TextEditingController();

  final picker = ImagePicker();

  File? _imageLang; // Make image nullable

  File? get imageLang => _imageLang; // Getter for image

  Future<void> getImageLang(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(
        source: source,
      );

      if (pickedFile != null) {
        _imageLang = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
    notifyListeners();
  }

  //another way

  File? _imageSecondLang; // Make image nullable

  File? get imageSecondLang => _imageSecondLang;

  Future<void> getImageSecondLang(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(
        source: source,
      );

      if (pickedFile != null) {
        _imageSecondLang = File(pickedFile.path);
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
}
