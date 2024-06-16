import 'dart:io';

import 'package:aviatoruz/core/constant/network_service_const.dart';
import 'package:aviatoruz/core/services/auth_service.dart';
import 'package:aviatoruz/core/services/rtdb_service.dart';
import 'package:aviatoruz/data/entity/meteo_topic_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final langTopicProvider = ChangeNotifierProvider((ref) => LangTopicNotifier());

class LangTopicNotifier extends ChangeNotifier {
  LangTopicNotifier() {
    initState();
    notifyListeners();
  }
  void initState() {
    init();
    notifyListeners();
  }

  void init() {
    fetchAllData().then(
      (value) {
        isLoading = true;
        notifyListeners();
      },
    );
    loadLoginStatus();
    notifyListeners();
  }

  bool isLoading = false;
  List<MeteoTopicItem> _items = [];
  List<MeteoTopicItem> get items => _items;

  // Future<void> deletePost(String id) async {
  //   await RTDBService.deletePost(NetworkServiceConst.meteoTopicsName, id);
  //   await fetchData();
  //   notifyListeners();
  // }

  Future<void> fetchAllData() async {
    _items = await RTDBService.getPosts(
        "LangTopic", NetworkServiceConst.langTopicsName);
    notifyListeners();
  }

  Future<void> uplodItes({
    required String title,
    required String patternPath,
    required String imagePath,
    required String imagePathSecond,
    required String path,
    required String description,
    required File imageFile,
    required File imageFileSecond,
  }) async {
    await RTDBService.uploadItem(
      title: title,
      patternPath: patternPath,
      imagePath: imagePath,
      path: path,
      description: description,
      imagePathSecond: imagePathSecond,
      imageFile: imageFile,
      imageFileSecond: imageFileSecond,
    );
    await fetchAllData();
    notifyListeners();
    print("Finished bro");
  }

  Future<void> loadLoginStatus() async {
    bool isLoggedIn = await AuthService.checkLoginStatus();
    AuthService.isLoginIn = isLoggedIn;
    notifyListeners();
  }
}
