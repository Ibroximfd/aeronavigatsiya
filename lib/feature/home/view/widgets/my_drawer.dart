import 'dart:ffi';

import 'package:aviatoruz/core/services/auth_service.dart';
import 'package:aviatoruz/feature/home/view/widgets/my_bottom_sheet.dart';
import 'package:aviatoruz/feature/auth/view/pages/login_page.dart';
import 'package:aviatoruz/feature/home/view/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFFFFF),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/logo_aviator.png",
                  height: 40,
                  width: double.maxFinite,
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Share.share('check out my website https://example.com', subject: 'Look what I made!');
                },
                leading: const Icon(Icons.share),
                title: const Text(
                  "Ulashish",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const MyBottomSheet();
                    },
                  );
                },
                leading: const Icon(Icons.call),
                title: const Text(
                  "Biz bilan bog`lanish",
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
                          "Chiqish",
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
