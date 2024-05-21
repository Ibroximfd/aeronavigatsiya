import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final addTopicController =
    ChangeNotifierProvider((ref) => AddTopicController());

class AddTopicController with ChangeNotifier {
  //textcontroller
  TextEditingController nameContrl = TextEditingController();
  TextEditingController discCtrl = TextEditingController();

  final picker = ImagePicker();

  File? _image; // Make image nullable

  File? get image => _image; // Getter for image

  final List<String> _imageUrls = [];
  List<String> get imageUrls => _imageUrls;

  Future<void> getImage(ImageSource source) async {
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

  Future<void> getImageSecond(ImageSource source) async {
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
}
