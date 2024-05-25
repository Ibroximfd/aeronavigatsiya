import 'dart:io';

import 'package:aviatoruz/data/entity/news_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RTDBServiceNews {
  static DatabaseReference ref = FirebaseDatabase.instance.ref();

  static Future<List<NewsModel>> getMewsPosts(
      String path, String topicsName) async {
    List<NewsModel> postList = [];
    Query query = ref.child(path).child(topicsName);
    DatabaseEvent databaseEvent = await query.once();
    Iterable<DataSnapshot> result = databaseEvent.snapshot.children;
    for (DataSnapshot e in result) {
      postList
          .add(NewsModel.fromMap(Map<String, dynamic>.from(e.value as Map)));
    }
    return postList;
  }

  static Future<void> uploadNewsItem({
    required String title,
    required String description,
    required String patternPath,
    required String imagePath,
    required String path,
    required File imageFile,
  }) async {
    // Upload file to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref();
    String? key = ref.child(path).push().key;
    final String dateTime = DateTime.now().toString();
    final fileRef = storageRef.child('$imagePath/$dateTime');
    await fileRef.putFile(imageFile);

    // Get file URL
    final imageUrl = await fileRef.getDownloadURL();

    // Create model

    final newItem = NewsModel(
      id: key,
      title: title,
      description: description,
      imageUrl: imageUrl,
    );

    // Write to Realtime Database
    final databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.child(patternPath).child(path).child(newItem.id!).set(
          newItem.toMap(),
        );
  }
}
