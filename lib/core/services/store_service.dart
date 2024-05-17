import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final ref = FirebaseStorage.instance.ref();

  static Future<String> upload(
      {required String path, required File file}) async {
    final Reference reference = ref.child(path).child(
        "file_${DateTime.now().toIso8601String()}${file.path.substring(file.path.lastIndexOf("."))}");
    UploadTask uploadTask = reference.putFile(file);
    log("\n\nmessage1111\n\n");
    await uploadTask.whenComplete(() {});
    log("\n\nmessage22222\n\n");
    return reference.getDownloadURL();
  }

  static Future<List<String>> getFile(String path) async {
    List<String> itemList = [];
    final Reference reference = ref.child(path);
    ListResult listResult = await reference.listAll();
    for (Reference e in listResult.items) {
      itemList.add(await e.getDownloadURL());
    }
    return itemList;
  }

  static Future<void> deleteFile(String url) async {
    try {
      final Reference reference = ref.child(url);
      await reference.delete();
      print('File $url deleted successfully');
    } catch (e) {
      print('Error deleting file: $e');
    }
  }

  //other way

  static Future<bool> uploadFile(File file) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final fileName = file.path.split("/").last;
      final timestamp = DateTime.now().microsecondsSinceEpoch;
      final uploadRef =
          storageRef.child("meteoTopicImages/$timestamp-$fileName");
      await uploadRef.putFile(file);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
