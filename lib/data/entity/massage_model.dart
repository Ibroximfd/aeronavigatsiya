import 'package:cloud_firestore/cloud_firestore.dart';

class Massage {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String massage;
  final Timestamp timestamp;

  Massage({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.massage,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderEmail,
      "senderEmail": senderEmail,
      "receiverId": receiverId,
      "massage": massage,
      "timestamp": timestamp,
    };
  }
}
