import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    void launchTelegram() async {
      const url =
          'https://t.me/@HumoyunbekMuhammad'; // O'zingizning Telegram username-ni kiriting
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    void makePhoneCall(String phoneNumber) async {
      final url = 'tel:$phoneNumber';
      if (await canLaunch(url)) {
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
              onPressed: launchTelegram,
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
                    "Telegram orqali bog'lanish",
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
                makePhoneCall('+99899027821');
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
                    "Qo'ng'iroq qilish",
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
