import 'package:aviatoruz/core/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatNotifier = ChangeNotifierProvider((ref) => ChatController());

class ChatController with ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final AuthService authService = AuthService();
  ChatController() {
    initState();
  }
  void initState() {
    init();
    notifyListeners();
  }

  void init() {
    authService.signInAnonymously();
    notifyListeners();
  }

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('chats').add({
        'text': controller.text,
        'createdAt': Timestamp.now(),
      });
      controller.clear();
    }
  }
}
