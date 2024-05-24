import 'package:aviatoruz/core/services/auth_service.dart';
import 'package:aviatoruz/data/entity/massage_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final chatService = ChatService();

class ChatService {
  //get instance firebasestore
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  // get user stream

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _store.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map(
        (doc) {
          final user = doc.data();
          return user;
        },
      ).toList();
    });
  }

  //send massage
  Future<void> sendMassege(String receiverID, massage) async {
    final String currentUserID = AuthService.auth.currentUser!.uid;
    final String currentUserEmail = AuthService.auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Massage newMassage = Massage(
      senderId: currentUserID,
      senderEmail: currentUserEmail,
      receiverId: receiverID,
      massage: massage,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserID, receiverID];
    ids.sort();

    String charRoomId = ids.join('_');

    _store.collection("chat_rooms").doc(charRoomId).collection("massage").add(
          newMassage.toMap(),
        );
  }

  Stream<QuerySnapshot> getMassages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _store
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
