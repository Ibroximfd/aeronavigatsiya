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
                child: Text(
                  "AERONAVIGATISYA",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 9, 107, 187),
                  ),
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
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      contentPadding: EdgeInsets.zero,
                      content: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.grey.shade50],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Biz haqimizda",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Ushbu ilova o‘z foydalanuvchilariga qulay va samarali xizmat taqdim etish maqsadida ishlab chiqilgan. Loyihamizning muvaffaqiyatli amalga oshirilishida quyidagi jamoa a’zolari muhim rol o‘ynadi:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 20),
                              _buildTeamMember(
                                title: "Katta o‘qituvchi",
                                name: "Muxammad Olim Humoyunbek",
                              ),
                              SizedBox(height: 16),
                              _buildTeamMember(
                                title: "Dasturchi",
                                name: "Umaraliyev Ibroxim",
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Biz jamoamiz bilan ushbu ilovani yaratishda katta mehnat va fidoyilik bilan ishladik. Har bir foydalanuvchimiz uchun eng yaxshi tajribani taqdim etishga intilamiz.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Mualliflik huquqi",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Ushbu ilova Muxammad Olim Humoyunbek va Umaraliyev Ibroxim tomonidan ishlab chiqilgan bo‘lib, barcha mualliflik huquqlari ularning mulkidir. Ilovadan foydalanishda mualliflarning huquqlariga rioya qilishni so‘raymiz. © 2025 Muxammad Olim Humoyunbek va Umaraliyev Ibroxim. Barcha huquqlar himoyalangan.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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

Widget _buildTeamMember({required String title, required String name}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          // ignore: deprecated_member_use
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$title: ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextSpan(
                    text: name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
