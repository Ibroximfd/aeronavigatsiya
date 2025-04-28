import 'package:aviatoruz/presentation/teachers/screens/home/home_page.dart';
import 'package:aviatoruz/presentation/teachers/screens/splash/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // foydalanuvchi holati
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Ma'lumotlarni tekshiryapti
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          // Agar foydalanuvchi tizimga kirgan bo'lsa
          return const HomePage();
        } else {
          // Agar foydalanuvchi login qilmagan bo'lsa
          return const SplashPage();
        }
      },
    );
  }
}
