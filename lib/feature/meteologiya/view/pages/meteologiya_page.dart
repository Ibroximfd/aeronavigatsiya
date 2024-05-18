import 'package:aviatoruz/core/services/auth_service.dart';
import 'package:aviatoruz/feature/meteologiya/view/pages/add_mavzu.dart';
import 'package:aviatoruz/feature/meteologiya/view_model/meteo_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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
          backgroundColor: const Color(0xFFFFFFFF),
          title: const Text(
            "Meteologiya",
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: InkWell(
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
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          // await con.deletePost(
                                          //   con.items[index].id ?? "",
                                          // );
                                          // await con
                                          //     .deleteFile(
                                          //   con.items[index].imageUrl!,
                                          // )
                                          //     .then((value) {
                                          //   Navigator.pop(context);
                                          // });
                                          // print(
                                          //   "bolarkanu aaaaaaa ${con.itemList[index]}",
                                          // );
                                        },
                                        child: const Text("Delete"),
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
                          Text(
                            "Mavzu: ${con.items[index].title}",
                            style: GoogleFonts.poiretOne(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
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
            : const Center(
                child: CircularProgressIndicator(),
              ),
        floatingActionButton: FloatingActionButton(
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
        ));
  }
}
