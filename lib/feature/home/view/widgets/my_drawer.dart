import 'package:aviatoruz/core/services/auth_service.dart';
import 'package:aviatoruz/feature/auth/view/pages/login_page.dart';
import 'package:aviatoruz/feature/home/view/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Drawer(
      backgroundColor: const Color(0xFFFFFFFF),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  SizedBox(
                    width: width * .48,
                    child: const Text(
                      "AVIATOR",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 9, 107, 187),
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                  const Text(
                    "UZ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 9, 107, 187),
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.share),
                title: const Text(
                  "Share with friends",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.call),
                title: const Text(
                  "Contact us",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoDialogRoute(
                        builder: (context) => const LoginPage(),
                        context: context),
                  );
                },
                leading: const Icon(CupertinoIcons.profile_circled),
                title: const Text(
                  "Admin panel",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                child: AuthService.isLoginIn
                    ? ListTile(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoDialogRoute(
                                builder: (context) => const HomePage(),
                                context: context),
                            (route) => false,
                          );
                          AuthService.isLoginIn = false;
                          debugPrint("${AuthService.isLoginIn}");
                        },
                        leading: const Icon(Icons.exit_to_app),
                        title: const Text(
                          "Log out",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
