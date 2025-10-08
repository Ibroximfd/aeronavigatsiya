import 'package:aeronavigatsiya/core/services/auth_service.dart';
import 'package:aeronavigatsiya/presentation/students/student_main_oage/student_main_page.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/auth/widgets/wait_verification_page.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/auth/widgets/went_wrong_page.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/auth/login_page.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/teacher_main_page/teacher_main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          final user = snapshot.data!;
          return FutureBuilder<String>(
            future: AuthService.getUserRole(user.uid),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(child: CircularProgressIndicator.adaptive()),
                );
              }

              if (roleSnapshot.hasError) {
                return WentWrongPage(snapshot: roleSnapshot);
              }

              final role = roleSnapshot.data ?? "student";

              if (role == "teacher") {
                return const TeacherMainPage();
              } else if (role == "student") {
                return const StudentMainPage();
              } else {
                return WaitVerificationPage();
              }
            },
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
