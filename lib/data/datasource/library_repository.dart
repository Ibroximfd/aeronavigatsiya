import 'package:aviatoruz/data/entity/chapter_model.dart';
import 'package:aviatoruz/data/entity/topic_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LibraryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createChapter(ChapterModel chapter) async {
    await _firestore.collection('library').doc(chapter.id).set(chapter.toMap());
  }

  Future<void> createTopic(String chapterId, TopicModel topic) async {
    await _firestore
        .collection('library')
        .doc(chapterId)
        .collection('topics')
        .add(topic.toJson());
  }
}
