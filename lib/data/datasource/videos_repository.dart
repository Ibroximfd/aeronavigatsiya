import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aeronavigatsiya/data/entity/video_model.dart';

class VideoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName;

  VideoRepository({this.collectionName = 'videos'});

  Future<void> createVideo(VideoModel video) async {
    await _firestore
        .collection(collectionName)
        .doc(video.id)
        .set(video.toMap());
  }

  Future<List<VideoModel>> getVideos() async {
    final snapshot = await _firestore
        .collection(collectionName)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => VideoModel.fromMap(doc.data())).toList();
  }

  Future<VideoModel?> getVideoById(String id) async {
    final doc = await _firestore.collection(collectionName).doc(id).get();
    if (doc.exists) {
      return VideoModel.fromMap(doc.data()!);
    }
    return null;
  }

  Future<void> updateVideo(VideoModel video) async {
    await _firestore
        .collection(collectionName)
        .doc(video.id)
        .update(video.toMap());
  }

  Future<void> deleteVideo(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}
