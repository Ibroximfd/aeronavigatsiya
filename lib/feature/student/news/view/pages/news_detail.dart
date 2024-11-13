import 'package:aviatoruz/feature/student/news/view_model/news_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:text_scroll/text_scroll.dart';

class NewsDetail extends ConsumerWidget {
  final index;
  const NewsDetail(this.index, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(newsProvider);
    var con = ref.read(newsProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset("assets/icons/arrow_back.png"),
        ),
        title: TextScroll(
          delayBefore: Duration(milliseconds: 1200),
          numberOfReps: 5,
          pauseBetween: Duration(milliseconds: 50),
          con.newsModel!.data[index].title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 9, 107, 187),
            letterSpacing: 4,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        color: const Color(0xFFFFFFFF),
                        height: 500,
                        width: double.maxFinite,
                        child: PhotoView(
                          imageProvider:
                              NetworkImage(con.newsModel!.data[index].image),
                          minScale: PhotoViewComputedScale.contained,
                          maxScale: PhotoViewComputedScale.covered * 2,
                        ),
                      ),
                    );
                  },
                );
              },
              child: SizedBox(
                height: 300,
                width: double.maxFinite,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    con.newsModel!.data[index].image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                con.newsModel!.data[index].body,
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
