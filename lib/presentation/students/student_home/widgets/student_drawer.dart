// ignore_for_file: deprecated_member_use

import 'package:aviatoruz/presentation/teachers/screens/home/widgets/my_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(-20 * (1 - value), 0),
                      child: Column(
                        children: [
                          // Header
                          Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Colors.blue.shade600,
                                  Colors.blue.shade900
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: Text(
                                "AERONAVIGATSIYA",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                            height: 20,
                          ),
                          // List Tiles
                          _buildListTile(
                            context,
                            icon: Icons.info_outline,
                            title: "Ilova haqida",
                            iconColor: Colors.blue.shade600,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => _buildCustomDialog(
                                  context,
                                  title: "Ilova haqida",
                                  content:
                                      "Mazkur ilova havodagi harakatni boshqarish (aviadispetcher-muhandis), aviatsiya radioelektron qurilmalari va tizimlari (muhandis-radioelektronchi) va amaliy kosmik texnologiyalar (koinot muhandisi) mutaxassisliklari bo‘yicha bakalavriat ta’lim yo‘nalishida tahsil olayotgan talabalar uchun mo‘ljallangan mobil kutubxona bo‘lib, nazariy bilimlarni mustahkamlash va mustaqil ta‘lim olish uchun mo‘ljallangan.\n\nIlova O‘zbekiston Respublikasi Adliya Vazirligi tomonidan O'zbekiston Respublikasining Dasturiy mahsulotlar davlat reyestrida 16.04.2025 yil DGU 49690 raqami bilan ro'yxatdan o'tkazilgan.\n\nBarcha huquqlar himoyalangan.\nIlovadagi materiallarni mualliflarning roziligisiz qisman yoki to‘liq bosib chiqarish, ulashish yoki tijoriy maqsadlarda qo‘llash qat’iyan taqiqlanadi.\n© 2025 Muhammad Olim. Umaraliyev Ibroxim.",
                                ),
                              );
                            },
                          ),
                          _buildListTile(
                            context,
                            icon: Icons.person,
                            title: "Mualliflar",
                            iconColor: Colors.indigo.shade700,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => _buildCustomDialog(
                                  context,
                                  title: "Mualliflar haqida",
                                  content:
                                      "Ilova Toshkent davlat transport universiteti Aeronavigatsiya tizimlari kafedrasi qoshida yaratilgan.\n\nG‘oya muallifi - Muhammad Olim Humoyunbek Ulug‘bek o‘g‘li.\nDasturchi va dizayner - Umaraliyev Ibroxim Ikromjon o‘g‘li.\n\nMuharrirlar:\nHavodagi harakatni boshqarish - Muhammad Olim Humoyunbek Ulug‘bek o‘g‘li.\nRadioelektron qurilmalar va tizimlar, Amaliy kosmik texnologiyalar - Jabborov Ramzjon Botirqul o‘g‘li.",
                                ),
                              );
                            },
                          ),
                          _buildListTile(
                            context,
                            icon: Icons.share,
                            title: "Ulashish",
                            iconColor: Colors.green.shade600,
                            onTap: () {
                              Share.share(
                                  'check out my website https://example.com',
                                  subject: 'Look what I made!');
                            },
                          ),
                          _buildListTile(
                            context,
                            icon: Icons.call,
                            title: "Biz bilan bog`lanish",
                            iconColor: Colors.blue.shade600,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const MyBottomSheet();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutBack,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading: Icon(
                icon,
                color: iconColor,
                size: 28,
              ),
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              onTap: onTap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCustomDialog(BuildContext context,
      {required String title, required String content}) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: AlertDialog(
              backgroundColor: Colors.white.withOpacity(0.95),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.shade200, width: 1.5),
              ),
              elevation: 8,
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        content,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade600,
                                  Colors.blue.shade800
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "OK",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
