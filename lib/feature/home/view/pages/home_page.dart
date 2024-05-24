import 'package:aviatoruz/feature/aviation_lang/view/pages/aviation_lang_page.dart';
import 'package:aviatoruz/feature/chat/view/pages/chat_page.dart';
import 'package:aviatoruz/feature/home/view/widgets/my_drawer.dart';
import 'package:aviatoruz/feature/meteologiya/view/pages/meteologiya_page.dart';
import 'package:aviatoruz/feature/news/news_page.dart';
import 'package:aviatoruz/feature/videos/view/pages/videos_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    List<String> icons = [
      "assets/icons/yangiliklar.png",
      "assets/icons/videos.png",
      "assets/icons/chats.png",
    ];
    List<Widget> pages = const [
      NewsPage(),
      VideosPage(),
      ChatPage(),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: SafeArea(
        key: scaffoldKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              // Center(
              //   child: Stack(
              //     alignment: Alignment.topRight,
              //     children: [
              //       SizedBox(
              //         width: width * .6,
              //         child: const Text(
              //           "AVIATOR",
              //           style: TextStyle(
              //             fontSize: 40,
              //             fontWeight: FontWeight.w700,
              //             color: Color.fromARGB(255, 9, 107, 187),
              //             letterSpacing: 4,
              //           ),
              //         ),
              //       ),
              //       const Text(
              //         "UZ",
              //         style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.w700,
              //           color: Color.fromARGB(255, 9, 107, 187),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Center(
                child: Image.asset(
                  "assets/images/logo_aviator.png",
                  height: 60,
                  width: double.maxFinite,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const MeteologiyaPage(),
                    ),
                  );
                },
                child: Image.asset(
                  height: height * .2,
                  fit: BoxFit.cover,
                  "assets/images/metrologiya.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AviationLangPage(),
                    ),
                  );
                },
                child: Image.asset(
                  height: height * .24,
                  fit: BoxFit.cover,
                  "assets/images/aviation_lang.png",
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  height: height * .16,
                  fit: BoxFit.cover,
                  "assets/images/test.png",
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          left: 40,
          right: 40,
          bottom: 40,
        ),
        child: Container(
          height: 60,
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              icons.length,
              (index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    CupertinoModalPopupRoute(
                      builder: (context) => pages[index],
                    ),
                  ),
                  child: Image.asset(
                    height: 50,
                    icons[index],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
