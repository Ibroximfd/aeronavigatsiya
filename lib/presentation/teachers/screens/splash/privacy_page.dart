import 'package:aviatoruz/presentation/students/student_home/student_home_page.dart';
import 'package:aviatoruz/presentation/teachers/bloc/privacy/privacy_bloc.dart';
import 'package:aviatoruz/presentation/teachers/bloc/privacy/privacy_event.dart';
import 'package:aviatoruz/presentation/teachers/bloc/privacy/privacy_state.dart';
import 'package:aviatoruz/presentation/teachers/screens/splash/widgets/privacy_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivacyPage extends StatelessWidget {
  final PageController pageController = PageController();

  PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrivacyBloc, PrivacyState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Privacy Policy'),
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: const [
                    PrivacyContent(language: 'UZ'),
                    PrivacyContent(language: 'RU'),
                    PrivacyContent(language: 'EN'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: state.isAccepted,
                    onChanged: (value) {
                      context.read<PrivacyBloc>().add(
                            TogglePrivacyAccepted(value ?? false),
                          );
                    },
                  ),
                  const Text('I accept the privacy policy'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 58,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: state.isAccepted
                        ? () {
                            context
                                .read<PrivacyBloc>()
                                .add(SubmitPrivacyPolicy());
                            Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => StudentHomePage()),
                                (_) => false);
                          }
                        : null,
                    child: const Text(
                      'Continue',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
