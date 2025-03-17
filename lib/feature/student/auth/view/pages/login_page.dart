import 'package:aviatoruz/core/widgets/custom_textfield.dart';
import 'package:aviatoruz/feature/student/auth/view_model/login_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(loginNotifier);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                "Hello !",
                style: GoogleFonts.merriweather(
                  fontSize: 30,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "WELCOME BACK",
                style: GoogleFonts.merriweather(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Email",
                style: GoogleFonts.nunitoSans(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              CostumTextField(
                height: 60,
                controller: TextEditingController(),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Password",
                style: GoogleFonts.nunitoSans(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CostumTextField(
                height: 60,
                controller: TextEditingController(),
                obscureText: true,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.eye),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 60,
                width: double.maxFinite,
                child: CupertinoButton(
                  color: Colors.black,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  child: const Text(
                    "LOGIN IN",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () async {},
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
