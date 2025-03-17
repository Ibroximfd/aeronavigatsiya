import 'package:aviatoruz/feature/student/chat/view/pages/chat_page.dart';
import 'package:aviatoruz/feature/student/home/view/widgets/my_drawer.dart';
import 'package:aviatoruz/feature/student/news/view/pages/news_page.dart';
import 'package:aviatoruz/feature/student/pages/test_page.dart';
import 'package:aviatoruz/feature/student/sections/view/pages/sections_page.dart';
import 'package:aviatoruz/feature/student/videos/view/pages/videos_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
              Center(
                child: SizedBox(
                  child: Text(
                    "AERONAVIGATISYA",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 9, 107, 187),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const SectionsPage(),
                    ),
                  );
                },
                child: Image.asset(
                  height: height * .2,
                  fit: BoxFit.cover,
                  "assets/images/metrologiya.png",
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const TestPage(),
                    ),
                  );
                },
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
