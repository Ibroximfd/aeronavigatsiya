import 'package:aviatoruz/feature/student/meteologiya/view/pages/meteo_detail_page.dart';
import 'package:aviatoruz/feature/student/meteologiya/view_model/meteo_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MeteologiyaPage extends ConsumerStatefulWidget {
  const MeteologiyaPage({super.key});

  @override
  ConsumerState<MeteologiyaPage> createState() => _MeteologiyaPageState();
}

class _MeteologiyaPageState extends ConsumerState<MeteologiyaPage> {
  @override
  void initState() {
    ref.read(meteoTopicProvider).getMeteoInifo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            "Meteorologiya",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 9, 107, 187),
              letterSpacing: 4,
            ),
          ),
        ),
        body: con.isLoading
            ? Center(child: CircularProgressIndicator.adaptive())
            : con.meteoModel?.data.length == 0
                ? Center(
                    child: Text("Ma'lumot topilmadi"),
                  )
                : ListView.builder(
                    itemCount: con.meteoModel!.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => MeteoDetailPage(index),
                              ),
                            );
                          },
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
                                          con.meteoModel!.data[index]
                                              .images[0],
                                        ),
                                      ),
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
                                        color: Color.fromARGB(255, 9, 107, 187),
                                      ),
                                    ),
                                    TextSpan(
                                      text: con.meteoModel!.data[index].title,
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
