import 'package:aviatoruz/core/services/network_service.dart';
import 'package:aviatoruz/feature/student/meteologiya/view/pages/section_topic_detail.dart';
import 'package:aviatoruz/feature/student/meteologiya/view_model/section_topic_controller.dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class SectionTopicPage extends ConsumerStatefulWidget {
  final int index;
  const SectionTopicPage(this.index, {super.key});

  @override
  ConsumerState<SectionTopicPage> createState() => _MeteologiyaPageState();
}

class _MeteologiyaPageState extends ConsumerState<SectionTopicPage> {
  List<String> apis = [
    ClientService.apiGetAviatsiyaAsoslari,
    ClientService.apiGetAviatsiyaJihozlari,
    ClientService.apiGetRadioFrazeologiyaQoidalari,
    ClientService.apiGetAviatsiyaMeteologiyasi,
    ClientService.apiGetHavoKemalariningTuzilishi,
    ClientService.apiGetHHB,
    ClientService.apiGetAeroportdanFoydalanish,
    ClientService.apiGetAviakartografiyaTopografiya,
    ClientService.apiGetHavoNavigatsiyasi,
    ClientService.apiGetParvozRadio,
    ClientService.apiGetHududiyNavigatsiya,
    ClientService.apiGetDispatcherTexnologiyasi,
    ClientService.apiGetAviatsiyaQonunshunosligi,
    ClientService.apiGetXalqaroHavoHudi,
    ClientService.apiGetXarvozInsonOmili,
    ClientService.apiGetHHbModellashtish,
    ClientService.apiGetAviatsiyaAsoslari,
  ];
  @override
  void initState() {
    ref.read(sectionTopicProvider).getMeteoInifo(apis[widget.index]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(sectionTopicProvider);
    var con = ref.read(sectionTopicProvider);

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
            "Section Topics",
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
                                builder: (context) => SectionTopicDetailPage(
                                    con.meteoModel!.data[index]),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  con.meteoModel!.data[index].topicImage,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 200,
                                        width: double.infinity,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.image_not_supported,
                                            color: Colors.grey),
                                      ),
                                    );
                                  },
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
