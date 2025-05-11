import 'package:aviatoruz/data/entity/chapter_model.dart';
import 'package:aviatoruz/data/entity/topic_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LibraryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createChapter(ChapterModel chapter, String collection) async {
    await _firestore
        .collection(collection)
        .doc(chapter.id)
        .set(chapter.toMap());
  }

  Future<void> createTopic(
      String chapterId, TopicModel topic, String collection) async {
    await _firestore
        .collection(collection)
        .doc(chapterId)
        .collection('topics')
        .add(topic.toJson());
  }
}
