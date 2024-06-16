import 'package:aviatoruz/feature/edit_page/view_model/edit_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class EditPage extends ConsumerWidget {
  final String? id;
  final String path;
  final String patternPath;
  final String imagePath;
  final String imagePathSecond;
  const EditPage(this.id, this.patternPath, this.path, this.imagePath,
      this.imagePathSecond,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(editNotifier);
    var con = ref.read(editNotifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        surfaceTintColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text("Edit"),
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
                controller: con.newNameContrlLang,
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
                  controller: con.newDiscCtrlLang,
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
                child: con.imageSecond == null
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
                            con.imageSecond!,
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
                    con
                        .updateItemById(
                      id: id!,
                      title: con.newNameContrlLang.text,
                      patternPath: patternPath,
                      imagePath: imagePath,
                      imagePathSecond: imagePathSecond,
                      path: path,
                      description: con.newDiscCtrlLang.text,
                      imageFile: con.imageLang!,
                      imageFileSecond: con.imageSecond!,
                    )
                        .then(
                      (value) {
                        Navigator.pop(context);
                        con.newDiscCtrlLang.clear();
                        con.newNameContrlLang.clear();
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
