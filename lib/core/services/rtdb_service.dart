import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:aviatoruz/data/entity/meteo_topic_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RTDBService {
  static DatabaseReference ref = FirebaseDatabase.instance.ref();

  static Future<List<MeteoTopicItem>> getPosts(
      String path, String topicsName) async {
    List<MeteoTopicItem> postList = [];
    Query query = ref.child(path).child(topicsName);
    DatabaseEvent databaseEvent = await query.once();
    Iterable<DataSnapshot> result = databaseEvent.snapshot.children;
    for (DataSnapshot e in result) {
      postList.add(
          MeteoTopicItem.fromMap(Map<String, dynamic>.from(e.value as Map)));
    }
    return postList;
  }

  static Future<void> uploadItem({
    required String title,
    required String description,
    required String patternPath,
    required String imagePath,
    required String imagePathSecond,
    required String path,
    required File imageFile,
    required File imageFileSecond,
  }) async {
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

  static Future<void> updateItemById({
    required String id,
    required String newTitle,
    required String newDescription,
    required String patternPath,
    required String imagePath,
    required String imagePathSecond,
    required String path,
    File? newImageFile,
    File? newImageFileSecond,
  }) async {
    // Reference to Firebase Storage and Database
    final storageRef = FirebaseStorage.instance.ref();
    final databaseRef = FirebaseDatabase.instance.ref();

    // URLs for the updated images
    String? imageUrl;
    String? imageUrlSecond;

    // Update the first image if provided
    if (newImageFile != null) {
      final String dateTime = DateTime.now().toString();
      final fileRef = storageRef.child('$imagePath/$dateTime');
      await fileRef.putFile(newImageFile);
      imageUrl = await fileRef.getDownloadURL();
    }

    // Update the second image if provided
    if (newImageFileSecond != null) {
      final String dateTime1 = DateTime.now().toString();
      final image1FileRef = storageRef.child('$imagePathSecond/$dateTime1');
      await image1FileRef.putFile(newImageFileSecond);
      imageUrlSecond = await image1FileRef.getDownloadURL();
    }

    // Fetch the current data of the item from the database
    final itemRef = databaseRef.child(patternPath).child(path).child(id);
    final snapshot = await itemRef.get();
    if (!snapshot.exists) {
      throw Exception("Item with id $id does not exist");
    }

    // Create updated model
    final updatedItem = MeteoTopicItem(
        id: id,
        title: newTitle,
        description: newDescription,
        imageUrl: imageUrl!,
        imageUrlSecond: imageUrlSecond!);
    // Write updated data to Realtime Database
    await itemRef.set(updatedItem.toMap());
  }
}
