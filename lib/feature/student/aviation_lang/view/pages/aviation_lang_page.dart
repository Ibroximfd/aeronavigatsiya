import 'package:aviatoruz/feature/student/aviation_lang/view/pages/aviation_lang_detail_page.dart';
import 'package:aviatoruz/feature/student/aviation_lang/view_model/lang_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_scroll/text_scroll.dart';

class AviationLangPage extends ConsumerStatefulWidget {
  const AviationLangPage({super.key});

  @override
  ConsumerState<AviationLangPage> createState() => _AviationLangPageState();
}

class _AviationLangPageState extends ConsumerState<AviationLangPage> {
  @override
  void initState() {
    ref.read(englishTopicProvider).getEnglishInifo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(englishTopicProvider);
    var con = ref.read(englishTopicProvider);
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          surfaceTintColor: const Color(0xFFFFFFFF),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFFFFFFF),
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
            "Aviation English and Russian",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 9, 107, 187),
              letterSpacing: 4,
            ),
          ),
        ),
        body: con.isLoading
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : con.englishModel?.data.length == 0
                ? Center(
                    child: Text("Ma'lumot topilmadi"),
                  )
                : ListView.builder(
                    itemCount: con.englishModel!.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => EnglishDetailPage(index),
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
                                      con.englishModel!.data[index].images[0],
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
                                      text: "Mavzu: ",
                                      style: GoogleFonts.openSans(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 9, 107, 187),
                                      ),
                                    ),
                                    TextSpan(
                                      text: con.englishModel!.data[index].title,
                                      style: GoogleFonts.openSans(
                                        fontSize: 20,
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
