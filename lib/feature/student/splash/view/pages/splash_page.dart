import 'package:aviatoruz/feature/student/home/view/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'privacy_page.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkPrivacyPolicy();
  }

  Future<void> _checkPrivacyPolicy() async {
    final prefs = await SharedPreferences.getInstance();
    final hasAcceptedPrivacy = prefs.getBool('privacyAccepted') ?? false;

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (hasAcceptedPrivacy) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => HomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => PrivacyPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          "assets/images/aviatoruz_splash.json",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
