import 'dart:io';

import 'package:aviatoruz/core/constant/network_service_const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:aviatoruz/data/entity/meteo_topic_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RTDBService {
  static DatabaseReference ref = FirebaseDatabase.instance.ref();

  static Future<List<MeteoTopicItem>> getPosts(
      String path, String meteoTopicsName) async {
    List<MeteoTopicItem> postList = [];
    Query query = ref.child(path).child(NetworkServiceConst.meteoTopicsName);
    DatabaseEvent databaseEvent = await query.once();
    Iterable<DataSnapshot> result = databaseEvent.snapshot.children;
    for (DataSnapshot e in result) {
      if (e != null) {
        postList.add(
            MeteoTopicItem.fromMap(Map<String, dynamic>.from(e.value as Map)));
      }
    }
    return postList;
  }

  static Future<void> uploadItem(
      {required String title,
      required List<String> imageUrls,
      required String description,
      required String patternPath,
      required String imagePath,
      required String imagePathSecond,
      required String path,
      required File imageFile,
      required File imageFileSecond,
      d}) async {
    // Upload file to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref();
    String? key = ref.child(path).push().key;
    final String dateTime = DateTime.now().toString();
    final fileRef = storageRef.child('$imagePath/$dateTime');
    await fileRef.putFile(imageFile);

    // Get file URL
    final imageUrl = await fileRef.getDownloadURL();

    final String dateTime1 = DateTime.now().toString();
    final image1FileRef = storageRef.child('$imagePathSecond/$dateTime1');
    await image1FileRef.putFile(imageFileSecond);

    // Get file URL
    final imageUrlSecond = await image1FileRef.getDownloadURL();

    // Create model

    final newItem = MeteoTopicItem(
      id: key,
      title: title,
      description: description,
      imageUrl: imageUrl,
      imageUrlSecond: imageUrlSecond,
    );

    // Write to Realtime Database
    final databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.child(patternPath).child(path).child(newItem.id!).set(
          newItem.toMap(),
        );
  }
}
