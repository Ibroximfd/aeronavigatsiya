import 'package:firebase_database/firebase_database.dart';

import '../../data/entity/meteo_topic_model.dart';

class RTDBService {
  static DatabaseReference ref = FirebaseDatabase.instance.ref();

  static const String path = "products";

  static Future<void> storeData(
      {required MeteoTopicItem postModel, required String path}) async {
    String? key = ref.child(path).push().key;
    postModel.id = key;
    await ref.child(path).child(postModel.id ?? key!).set(postModel.toJson());
  }

  static Future<List<MeteoTopicItem>> getPosts(String path) async {
    List<MeteoTopicItem> postList = [];
    Query query = ref.child(path);
    DatabaseEvent databaseEvent = await query.once();
    Iterable<DataSnapshot> result = databaseEvent.snapshot.children;
    for (DataSnapshot e in result) {
      if (e != null) {
        postList.add(
            MeteoTopicItem.fromJson(Map<String, dynamic>.from(e.value as Map)));
      }
    }
    return postList;
  }

  static Future<void> updatePost(MeteoTopicItem postModel, String path) async {
    await ref.child(path).child(postModel.id ?? "").set(postModel.toJson());
  }

  static Future<void> deletePost(String path, String id) async {
    await ref.child(path).child(id).remove();
  }
}
