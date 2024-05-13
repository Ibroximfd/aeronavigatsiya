import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginNotifier = ChangeNotifierProvider((ref) => LoginController());

class LoginController with ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passConfirmController = TextEditingController();
  bool isTapped = false;
  void isTap() {
    isTapped = !isTapped;
    notifyListeners();
  }
}
