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

  File? _image; // Make image nullable

  File? get image => _image; // Getter for image

  final picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);

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

  List meteoTopicImages = [];
}
