import 'dart:io';
import 'package:aviatoruz/core/constant/network_service_const.dart';
import 'package:aviatoruz/core/services/rtdb_service.dart';
import 'package:aviatoruz/data/entity/meteo_topic_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final meteoTopicProvider =
    ChangeNotifierProvider((ref) => MeteoTopicNotifier());

class MeteoTopicNotifier extends ChangeNotifier {
  MeteoTopicNotifier() {
    initState();
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
        "MeteoTopic", NetworkServiceConst.meteoTopicsName);
    notifyListeners();
  }

  Future<void> uplodItes(String title, File imageFile, String patternPath,
      String imagePath, String path) async {
    RTDBService.uploadItem(title, imageFile, patternPath, imagePath, path);
    await fetchAllData();
    notifyListeners();
    print("Finished bro");
  }
}
