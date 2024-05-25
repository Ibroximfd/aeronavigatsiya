import 'package:aviatoruz/core/services/auth_service.dart';
import 'package:aviatoruz/feature/aviation_lang/view/pages/news_detail.dart';
import 'package:aviatoruz/feature/news/view/pages/add_news.dart';
import 'package:aviatoruz/feature/news/view_model/news_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(newsProvider);
    var con = ref.read(newsProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFFFFFF),
        shadowColor: const Color(0xFF000000),
        elevation: 2,
        surfaceTintColor: const Color(0xFFEEEEEE),
        centerTitle: true,
        title: const Text(
          "Yangiliklar",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 9, 107, 187),
            letterSpacing: 4,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset("assets/icons/arrow_back.png"),
        ),
      ),
      body: con.isLoading
          ? ListView.builder(
              itemCount: con.items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => NewsDetail(
                            item: con.items[index],
                          ),
                        ),
                      );
                    },
                    onLongPress: AuthService.isLoginIn
                        ? () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  content: Text(
                                    "Do you really want to delete",
                                    style: GoogleFonts.adamina(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("bekor qilish"),
                                    ),
                                    TextButton(
                                      onPressed: () async {},
                                      child: const Text("o`chirish"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: 200,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                12,
                              ),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                con.items[index].imageUrl,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: con.items[index].title,
                                style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: SizedBox(
                height: 120,
                width: 120,
                child: LottieBuilder.asset(
                  "assets/images/lotti_loading_stake.json",
                ),
              ),
            ),
      floatingActionButton: AuthService.isLoginIn
          ? FloatingActionButton(
              backgroundColor: Colors.black.withOpacity(0.5),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const AddNews(),
                  ),
                );
              },
              child: const Icon(
                color: Colors.white,
                Icons.add,
                size: 30,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
