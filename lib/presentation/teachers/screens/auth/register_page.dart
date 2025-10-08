// ignore_for_file: deprecated_member_use

import 'package:aeronavigatsiya/core/widgets/custom_textfield.dart';
import 'package:aeronavigatsiya/presentation/students/student_main_oage/student_main_page.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/auth/auth_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/auth/auth_event.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/auth/auth_state.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/auth/widgets/wait_verification_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  final obscurePassword = ValueNotifier<bool>(true);
  final obscureConfirmPassword = ValueNotifier<bool>(true);

  bool isTeacher = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthRegistered) {
              _showSnackBar(context, state.message);

              if (isTeacher) {
                // O‘qituvchi ro‘yxatdan o‘tgan – admin tasdiqlashini kutadi
                _showSnackBar(
                  context,
                  "Ro‘yxatdan o‘tish muvaffaqiyatli. Admin tasdiqlashini kuting.",
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WaitVerificationPage(),
                  ),
                  (_) => false,
                );
              } else {
                // Student bo‘lsa to‘g‘ridan-to‘g‘ri kiradi
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const StudentMainPage()),
                  (_) => false,
                );
              }
            }
          },
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        Center(
                          child: Text(
                            "Ro'yxatdan O'tish",
                            style: GoogleFonts.roboto(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.teal.shade900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),

                        _label("Ism"),
                        _buildInputContainer(
                          child: CostumTextField(
                            height: 50,
                            controller: nameController,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _label("Email"),
                        _buildInputContainer(
                          child: CostumTextField(
                            height: 50,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),

                        const SizedBox(height: 16),
                        _label("Parol"),
                        ValueListenableBuilder(
                          valueListenable: obscurePassword,
                          builder: (_, obscure, __) => _buildInputContainer(
                            child: CostumTextField(
                              height: 50,
                              controller: passwordController,
                              obscureText: obscure,
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    obscurePassword.value = !obscure,
                                icon: Icon(
                                  obscure
                                      ? CupertinoIcons.eye_slash
                                      : CupertinoIcons.eye,
                                  color: Colors.teal.shade600,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        _label("Parolni Tasdiqlash"),
                        ValueListenableBuilder(
                          valueListenable: obscureConfirmPassword,
                          builder: (_, obscure, __) => _buildInputContainer(
                            child: CostumTextField(
                              height: 50,
                              controller: confirmPasswordController,
                              obscureText: obscure,
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    obscureConfirmPassword.value = !obscure,
                                icon: Icon(
                                  obscure
                                      ? CupertinoIcons.eye_slash
                                      : CupertinoIcons.eye,
                                  color: Colors.teal.shade600,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Men o‘qituvchiman",
                              style: GoogleFonts.roboto(fontSize: 16),
                            ),
                            SizedBox(width: 8),
                            Switch(
                              activeColor: Colors.teal,
                              value: isTeacher,
                              onChanged: (v) => setState(() => isTeacher = v),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.teal.shade600,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CupertinoButton(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            onPressed: state is AuthLoading
                                ? null
                                : () {
                                    final email = emailController.text.trim();
                                    final password = passwordController.text
                                        .trim();
                                    final confirm = confirmPasswordController
                                        .text
                                        .trim();
                                    final name = nameController.text.trim();

                                    if (email.isEmpty ||
                                        password.isEmpty ||
                                        confirm.isEmpty ||
                                        name.isEmpty) {
                                      _showSnackBar(
                                        context,
                                        "Barcha maydonlarni to‘ldiring",
                                        error: true,
                                      );
                                      return;
                                    }

                                    if (password != confirm) {
                                      _showSnackBar(
                                        context,
                                        "Parollar mos kelmadi",
                                        error: true,
                                      );
                                      return;
                                    }

                                    // ✅ Bloc eventni bool bilan yuboramiz
                                    context.read<AuthBloc>().add(
                                      RegisterRequested(
                                        name: name.trim(),
                                        email: email,
                                        password: password,
                                        isTeacher: isTeacher,
                                      ),
                                    );
                                  },
                            child: state is AuthLoading
                                ? const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Ro'yxatdan o'tish",
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
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.teal.shade900,
      ),
    ),
  );

  Widget _buildInputContainer({required Widget child}) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200, width: 1),
    ),
    child: child,
  );

  void _showSnackBar(
    BuildContext context,
    String message, {
    bool error = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red.shade400 : Colors.teal.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
