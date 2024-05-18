import 'dart:io';

import 'package:aviatoruz/core/constant/network_service_const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:aviatoruz/data/entity/meteo_topic_model.dart';

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

  static Future<void> uploadItem(String title, File imageFile,
      String patternPath, String imagePath, String path) async {
    // Upload file to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref();
    String? key = ref.child(path).push().key;
    final String dateTime = DateTime.now().toString();
    final fileRef = storageRef.child('$imagePath/$dateTime');
    await fileRef.putFile(imageFile);

    // Get file URL
    final imageUrl = await fileRef.getDownloadURL();

    // Create model
    final newItem = MeteoTopicItem(
      id: key,
      title: title,
      imageUrl: imageUrl,
    );

    // Write to Realtime Database
    final databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.child(patternPath).child(path).child(newItem.id!).set(
          newItem.toMap(),
        );
  }
}
