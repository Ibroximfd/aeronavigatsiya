import 'package:aviatoruz/presentation/students/student_home/student_home_page.dart';
import 'package:aviatoruz/presentation/teachers/bloc/splash/splash_bloc.dart';
import 'package:aviatoruz/presentation/teachers/bloc/splash/splash_event.dart';
import 'package:aviatoruz/presentation/teachers/bloc/splash/splash_state.dart';
import 'package:aviatoruz/presentation/teachers/screens/splash/privacy_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(CheckPrivacyAccepted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is NavigateToHome) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => StudentHomePage()),
            );
          } else if (state is NavigateToPrivacy) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => PrivacyPage()),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Lottie.asset("assets/images/splash_animation.json"),
          ),
        ),
      ),
    );
  }
}
