// ignore_for_file: deprecated_member_use

import 'package:aeronavigatsiya/core/widgets/custom_textfield.dart';
import 'package:aeronavigatsiya/presentation/students/student_home/student_home_page.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/auth/auth_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/auth/auth_event.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/auth/auth_state.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/auth/register_page.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/teacher_home/teacher_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Muvaffaqiyatli kirish"),
                              backgroundColor: Colors.teal.shade600,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );

                          // === Role-based navigatsiya ===
                          if (state.role == 'teacher') {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TeacherHomePage(),
                              ),
                              (_) => false,
                            );
                          } else {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StudentHomePage(),
                              ),
                              (_) => false,
                            );
                          }
                        } else if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red.shade400,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 80),
                            Center(
                              child: Text(
                                "Xush kelibsiz!",
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.teal.shade900,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: Text(
                                "Tizimga kirish",
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),

                            /// Email field
                            Text(
                              "Email",
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.teal.shade900,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.teal.shade200,
                                  width: 1,
                                ),
                              ),
                              child: CostumTextField(
                                height: 50,
                                controller: emailController,
                              ),
                            ),
                            const SizedBox(height: 16),

                            /// Password field
                            Text(
                              "Parol",
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.teal.shade900,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.teal.shade200,
                                  width: 1,
                                ),
                              ),
                              child: CostumTextField(
                                height: 50,
                                controller: passwordController,
                                obscureText: !_isPasswordVisible,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? CupertinoIcons.eye_slash
                                        : CupertinoIcons.eye,
                                    color: Colors.teal.shade600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            /// Forgot password
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Parolni unutdingizmi?",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Colors.teal.shade700,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.teal.shade700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            /// Register link
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Ro'yxatdan o'tish?",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Colors.teal.shade700,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.teal.shade700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            /// Login button
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.teal.shade600,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CupertinoButton(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                onPressed: () {
                                  context.read<AuthBloc>().add(
                                    LoginRequested(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                    ),
                                  );
                                },
                                child: state is AuthLoading
                                    ? const CupertinoActivityIndicator(
                                        color: Colors.white,
                                        radius: 12,
                                      )
                                    : Text(
                                        "Kirish",
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
