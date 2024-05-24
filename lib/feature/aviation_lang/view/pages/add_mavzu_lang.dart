import 'package:aviatoruz/core/constant/network_service_const.dart';
import 'package:aviatoruz/feature/auth/view_model/login_notifier.dart';
import 'package:aviatoruz/feature/aviation_lang/view_model/add_lang_controller.dart';
import 'package:aviatoruz/feature/aviation_lang/view_model/lang_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddMavzuLang extends ConsumerWidget {
  const AddMavzuLang({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addTopicLangController);
    var con = ref.read(addTopicLangController);
    ref.watch(loginNotifier);
    var conMeteo = ref.read(langTopicProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        surfaceTintColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text("Add a new topic"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Topic name",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: con.nameContrlLang,
                style: const TextStyle(
                  fontSize: 22,
                ),
                decoration: const InputDecoration(
                  label: Text("name"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Topic Description",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 150,
                width: double.maxFinite,
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  maxLines: null,
                  controller: con.discCtrlLang,
                  decoration: const InputDecoration(
                      hintText: "Write a description",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    con.getImageLang(ImageSource.gallery);
                  } catch (e) {
                    debugPrint("Bomadi brat");
                  }
                },
                child: con.imageLang == null
                    ? Image.asset(
                        "assets/images/add_image.png",
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          child: Image.file(
                            con.imageLang!,
                            width: double.maxFinite,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    con.getImageSecondLang(ImageSource.gallery);
                  } catch (e) {
                    debugPrint("Bomadi brat");
                  }
                },
                child: con.imageSecondLang == null
                    ? Image.asset(
                        "assets/images/add_image.png",
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          child: Image.file(
                            con.imageSecondLang!,
                            width: double.maxFinite,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 60,
                width: double.maxFinite,
                child: CupertinoButton(
                  color: Colors.blue,
                  child: const Text("Create"),
                  onPressed: () {
                    conMeteo
                        .uplodItes(
                      title: con.nameContrlLang.text,
                      patternPath: "LangTopic",
                      imagePath: NetworkServiceConst.langTopicsImage,
                      imagePathSecond:
                          NetworkServiceConst.langTopicsImageDetail,
                      path: NetworkServiceConst.langTopicsName,
                      description: con.discCtrlLang.text,
                      imageFile: con.imageLang!,
                      imageFileSecond: con.imageSecondLang!,
                    )
                        .then(
                      (value) {
                        Navigator.pop(context);
                        con.discCtrlLang.clear();
                        con.nameContrlLang.clear();
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
      ),
    );
  }
}
