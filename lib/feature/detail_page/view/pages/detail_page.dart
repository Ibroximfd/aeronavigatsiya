import 'package:aviatoruz/data/entity/meteo_topic_model.dart';
import 'package:aviatoruz/feature/detail_page/view_model/deteil_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends ConsumerWidget {
  final MeteoTopicItem item;
  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(detailNotifier);
    var con = ref.read(detailNotifier);
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
            SizedBox(
              width: double.maxFinite,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              child: Text(
                item.title,
                style: GoogleFonts.aBeeZee(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: Image.network(
                  item.imageUrlSecond,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                item.description,
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
