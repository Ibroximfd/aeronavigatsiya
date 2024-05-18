import 'dart:async';
import 'dart:io';
import 'package:aviatoruz/data/entity/meteo_topic_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NetworkServiceMeteoTopic {
  static final DatabaseReference database = FirebaseDatabase.instance.ref();

  // CREATE (Qo'shish)

  static Future<void> create(
      {required String dbPath, required Map<String, dynamic> data}) async {
    String? key = database.child(dbPath).push().key;
    await database.child(dbPath).child(key!).set(data);
  }

  // static Future<void> addItem(
  //     MeteoTopicItem item, String path, String imagePAth) async {
  //   // Image faylini ma'lumotlar bazasiga yuklab olish
  //   if (item.image != null) {
  //     final String imageUrl =
  //         await uploadImageToStorage(item.image!, imagePAth);

  //     // Image url ni itemga qo'shib qo'yamiz:
  //     item.imageUrl = imageUrl;
  //   }

  //   await database.child(path).push().set(item.toJson());
  // }

  // READ (O'qish)
  static Future<List<MeteoTopicItem>> getItems(
      {required String parentPath}) async {
    List<MeteoTopicItem> list = [];

    final path = database.child(parentPath);
    DatabaseEvent databaseEvent = await path.once();
    var result = databaseEvent.snapshot.children;
    for (var e in result) {
      list.add(
          MeteoTopicItem.fromMap(Map<String, dynamic>.from(e.value as Map)));
    }
    print(list.length);
    return list;
  }

  // UPDATE (Yangilash)
  static Future<void> updateItem(
      String id, MeteoTopicItem newItem, String path) async {
    await database.child('$path/$id').update(newItem.toMap());
    await database.child('$path/$id').update(newItem.toMap());
  }

  // DELETE (O'chirish)
  static Future<void> deleteItem(String id, String path) async {
    await database.child('$path/$id').remove();
  }

  // Faylni ma'lumotlar bazasiga yuklash
  static Future<String> uploadImageToStorage(
      File file, String imagePAth) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    // Faylni ma'lumotlar bazasiga yuklash uchun fayl nomini aniqlang
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = storage.ref().child('$imagePAth/$fileName');
    UploadTask uploadTask = reference.putFile(file);

    // Yuklashni kuzatish va URL ni qaytarish
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    // Faylni muvaffaqiyatli yuklash bo'lsa URL ni qaytarish
    return downloadUrl;
  }
}
