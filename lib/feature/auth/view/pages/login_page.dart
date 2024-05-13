import 'package:aviatoruz/core/services/auth_service.dart';
import 'package:aviatoruz/core/widgets/custom_textfield.dart';
import 'package:aviatoruz/feature/auth/view_model/login_notifier.dart';
import 'package:aviatoruz/feature/home/view/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(loginNotifier);
    final con = ref.read(loginNotifier);
    return Scaffold(
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
                controller: con.emailController,
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
                controller: con.passwordController,
                obscureText: con.isTapped,
                suffixIcon: IconButton(
                  onPressed: () {
                    con.isTap();
                  },
                  icon: con.isTapped
                      ? const Icon(CupertinoIcons.eye_slash)
                      : const Icon(CupertinoIcons.eye),
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
                  onPressed: () async {
                    User? user;
                    user = await AuthService.loginUser(
                      context,
                      con.emailController.text,
                      con.passwordController.text,
                    );
                    if (user != null) {
                      Navigator.pushAndRemoveUntil(
                        // ignore: use_build_context_synchronously
                        context,
                        CupertinoDialogRoute(
                          builder: (context) => const HomePage(),
                          // ignore: use_build_context_synchronously
                          context: context,
                        ),
                        (route) => false,
                      );
                      AuthService.isLoginIn = true;
                      debugPrint("${AuthService.isLoginIn}");
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Completed successfully"),
                        ),
                      );
                      con.emailController.clear();
                      con.passwordController.clear();
                    }
                  },
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
