import 'package:aviatoruz/feature/student/news/view/pages/news_detail.dart';
import 'package:aviatoruz/feature/student/news/view_model/news_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  @override
  void initState() {
    ref.read(newsProvider).getNewsInifo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            ? Center(child: CircularProgressIndicator.adaptive())
            : con.newsModel?.data.length == 0
                ? Center(
                    child: Text("Ma'lumot topilmadi"),
                  )
                : ListView.builder(
                    itemCount: con.newsModel!.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => NewsDetail(index),
                              ),
                            );
                          },
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
                                      con.newsModel!.data[index].image,
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
                                      text: con.newsModel!.data[index].title,
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
                  ));
  }
}
