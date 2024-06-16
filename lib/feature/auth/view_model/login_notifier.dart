import 'package:aviatoruz/core/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginNotifier = ChangeNotifierProvider((ref) => LoginController());

class LoginController with ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passConfirmController = TextEditingController();
  bool isTapped = false;
  User? user;

  void isTap() {
    isTapped = !isTapped;
    notifyListeners();
  }

  void login(BuildContext context) async {
    user = await AuthService.loginUser(
      context,
      emailController.text,
      passwordController.text,
    );
    notifyListeners();
  }

  void signOut() {
    AuthService.signOut();
    notifyListeners();
  }
}
