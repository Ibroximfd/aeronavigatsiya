import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';

class NetworkServiceStore {
  //Create
  static Future<String> uploadImageToStorage(
      File imageFile, String imagePath) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(imagePath)
          .child('${DateTime.now().millisecondsSinceEpoch}');
      firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
      await uploadTask.whenComplete(() => null);
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint('Rasm yuklash jarayonida xatolik yuz berdi: $e');
      return '';
    }
  }

  //get image method
  static Future<String> getImageUrlFromStorage(String imagePath) async {
    try {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(imagePath);
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint('Rasmni olish jarayonida xatolik yuz berdi: $e');
      return '';
    }
  }

  //delete image method
  static Future<void> deleteImageFromStorage(String imagePath) async {
    try {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(imagePath);
      await ref.delete();
    } catch (e) {
      debugPrint('Rasmni o`chirish jarayonida xatolik yuz berdi: $e');
    }
  }
}
