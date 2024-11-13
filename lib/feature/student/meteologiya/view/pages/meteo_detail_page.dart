import 'package:aviatoruz/feature/student/meteologiya/view_model/meteo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class MeteoDetailPage extends ConsumerWidget {
  final int index;
  const MeteoDetailPage(
    this.index, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(meteoTopicProvider);
    var con = ref.read(meteoTopicProvider);
    var model = con.meteoModel!.data[index];
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset("assets/icons/arrow_back.png"),
                  ),
                ],
              ),
            ),
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
                          imageProvider: NetworkImage(model.images[0]),
                          minScale: PhotoViewComputedScale.contained,
                          maxScale: PhotoViewComputedScale.covered * 2,
                        ),
                      ),
                    );
                  },
                );
              },
              child: SizedBox(
                height: 200,
                width: double.maxFinite,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    model.images[0],
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              child: Text(
                " ${model.title}",
                style: GoogleFonts.aBeeZee(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 9, 107, 187),
                ),
              ),
            ),
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
                          imageProvider: NetworkImage(model.images[1]),
                        ),
                      ),
                    );
                  },
                );
              },
              child: SizedBox(
                height: 200,
                width: double.maxFinite,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    model.images[1],
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                model.body,
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
