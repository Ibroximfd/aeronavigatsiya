import 'dart:io';

import 'package:aviatoruz/core/constant/network_service_const.dart';
import 'package:aviatoruz/core/services/rtdb_service.dart';
import 'package:aviatoruz/core/services/store_service.dart';
import 'package:aviatoruz/data/entity/meteo_topic_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final meteoTopicNotifier =
    ChangeNotifierProvider((ref) => MeteoTopicNotifier());

class MeteoTopicNotifier with ChangeNotifier {
  MeteoTopicNotifier() {
    initState();
  }
  void initState() {
    init();
    notifyListeners();
  }

  void init() {
    getFile();
    getPosts().then((value) {
      isLoading = true;
      notifyListeners();
    });
  }

  List<MeteoTopicItem> list = [];
  List<String> itemList = [];
  bool isLoading = false;
  bool isStorageCame = false;
  Future<void> getPosts() async {
    list = await RTDBService.getPosts(NetworkServiceConst.meteoTopicsName);
    notifyListeners();
  }

  Future<void> deletePost(String id) async {
    await RTDBService.deletePost(NetworkServiceConst.meteoTopicsName, id);
    await getPosts();
    notifyListeners();
  }

  Future<void> create(
      String path, TextEditingController titleController) async {
    MeteoTopicItem postModel = MeteoTopicItem(
        title: titleController.text.trim().toString(),
        createdTime: DateTime.now().toIso8601String());
    await RTDBService.storeData(postModel: postModel, path: path);
    titleController.clear();
    print("Finished");
    await getPosts();
    notifyListeners();
  }

  /// firebase storage =================================================================

  Future<File> takeFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    File file = File(xFile?.path ?? "");
    return file;
  }

  Future<void> uploadFile(File file) async {
    String link = await StorageService.upload(
        path: NetworkServiceConst.meteoTopicsImage, file: file);
    print(link);
    getFile();
    notifyListeners();
  }

  Future<void> getFile() async {
    isStorageCame = false;
    itemList =
        await StorageService.getFile(NetworkServiceConst.meteoTopicsImage);
    isStorageCame = true;
    notifyListeners();
  }

  Future<void> deleteFile(String url) async {
    await StorageService.deleteFile(url);
    getFile();
    notifyListeners();
  }
}
