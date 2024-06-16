import 'package:aviatoruz/core/constant/network_service_const.dart';
import 'package:aviatoruz/core/services/auth_service.dart';
import 'package:aviatoruz/feature/detail_page/view/pages/detail_page.dart';
import 'package:aviatoruz/feature/edit_page/view/page/edit_page.dart';
import 'package:aviatoruz/feature/meteologiya/view/pages/add_mavzu.dart';
import 'package:aviatoruz/feature/meteologiya/view_model/meteo_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MeteologiyaPage extends ConsumerWidget {
  const MeteologiyaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(meteoTopicProvider);
    var con = ref.read(meteoTopicProvider);

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
        title: const Text(
          "Aviatsiya meteorologiyasi",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 9, 107, 187),
            letterSpacing: 4,
          ),
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
                          builder: (context) => DetailPage(
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
                                    "Rostan ham o'chirilsinmi?",
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
                        Stack(
                          alignment: Alignment.topRight,
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
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                        "Tahrirlashni xohlaysizmi?",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Orqaga"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) => EditPage(
                                                  con.items[index].id,
                                                  "MeteoTopic",
                                                  NetworkServiceConst
                                                      .meteoTopicsName,
                                                  NetworkServiceConst
                                                      .meteoTopicsImage,
                                                  NetworkServiceConst
                                                      .meteoTopicsImageDetail,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text("Tahrirlash"),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                              ),
                            ),
                          ],
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
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
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
                  CupertinoModalPopupRoute(
                    builder: (context) => const ADDMavzu(),
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
