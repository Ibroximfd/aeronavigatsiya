import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    Future<void> _launchTelegram() async {
      final url = Uri.parse('https://t.me/aeronavigatsiya_uz');
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw 'Telegramga o\'tolmadi: $url';
      }
    }

    void makePhoneCall(String phoneNumber) async {
      final url = 'tel:$phoneNumber';
      // ignore: deprecated_member_use
      if (await canLaunch(url)) {
        // ignore: deprecated_member_use
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Container(
      height: height * 0.4,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 10,
                width: 60,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      30,
                    ),
                  ),
                ),
              ),
            ),
            CupertinoButton(
              onPressed: _launchTelegram,
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/tg_logo.png",
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "Telegram orqali",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            CupertinoButton(
              onPressed: () {
                makePhoneCall('+998 99 027 2821');
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/phone_icon.png",
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "Qong'iroq yoki sms orqali ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
