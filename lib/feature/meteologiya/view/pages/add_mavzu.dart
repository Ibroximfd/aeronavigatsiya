import 'package:aviatoruz/core/constant/network_service_const.dart';
import 'package:aviatoruz/core/services/network_service_store.dart';
import 'package:aviatoruz/feature/meteologiya/view/pages/meteologiya_page.dart';
import 'package:aviatoruz/feature/meteologiya/view/widgets/add_topic_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/services/network_service.dart';

class ADDMavzu extends ConsumerWidget {
  const ADDMavzu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addTopicController);
    var con = ref.read(addTopicController);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text("Add a new topic"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  try {
                    con.getImage(ImageSource.gallery);
                  } catch (e) {
                    debugPrint("Bomadi brat");
                  }
                },
                child: con.image == null
                    ? Image.asset(
                        "assets/images/add_image.png",
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Image.file(
                          con.image!,
                          width: double.maxFinite,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Topic name",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              controller: con.nameContrl,
              decoration: const InputDecoration(
                label: Text("name"),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 60,
              width: double.maxFinite,
              child: CupertinoButton(
                color: Colors.blue,
                child: const Text("Create"),
                onPressed: () {
                  NetworkServiceStore.uploadImageToStorage(
                      con.image!, NetworkServiceConst.meteoTopicsImage);
                  NetworkServiceMeteoTopic.create(
                      dbPath: NetworkServiceConst.meteoTopicsName,
                      data: {
                        "name": con.nameContrl.text,
                      }).then(
                    (value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MeteologiyaPage(),
                        ),
                        (route) => false,
                      );
                      con.nameContrl.clear();
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
