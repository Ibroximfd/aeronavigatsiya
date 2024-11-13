import 'package:aviatoruz/feature/student/home/view/widgets/my_bottom_sheet.dart';
import 'package:aviatoruz/feature/student/auth/view/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Color(0xFFFFFFFF),
                      content: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Text(
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            "Toshkent davlat transport university tomonidan loyihalashtirilgan!\fKatta o'qituvchi Muhammad Olim Humoyunbek,"),
                      ),
                    ),
                  );
                },
                leading: const Icon(Icons.info_outline_rounded),
                title: const Text(
                  "Biz haqimizda",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Share.share('check out my website https://example.com',
                      subject: 'Look what I made!');
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
                      context: context,
                    ),
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
              // const Spacer(),
              // SizedBox(
              //     child: ListTile(
              //   onTap: () async {
              //     Navigator.pushAndRemoveUntil(
              //       context,
              //       CupertinoDialogRoute(
              //           builder: (context) => const HomePage(),
              //           context: context),
              //       (route) => false,
              //     );
              //   },
              //   leading: const Icon(Icons.exit_to_app),
              //   title: const Text(
              //     "Chiqish",
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // )),
              // const SizedBox(
              //   height: 40,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
