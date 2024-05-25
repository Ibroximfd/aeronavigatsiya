import 'dart:io';

import 'package:aviatoruz/core/constant/network_service_const.dart';
import 'package:aviatoruz/data/entity/news_model.dart';
import 'package:aviatoruz/feature/news/utils/rtdb_servive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newsProvider = ChangeNotifierProvider((ref) => NewsNotifier());

class NewsNotifier extends ChangeNotifier {
  NewsNotifier() {
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
    notifyListeners();
  }

  bool isLoading = false;
  List<NewsModel> _items = [];
  List<NewsModel> get items => _items;

  // Future<void> deletePost(String id) async {
  //   await RTDBService.deletePost(NetworkServiceConst.meteoTopicsName, id);
  //   await fetchData();
  //   notifyListeners();
  // }

  Future<void> fetchAllData() async {
    _items = await RTDBServiceNews.getMewsPosts(
        "News", NetworkServiceConst.newsName);
    notifyListeners();
  }

  Future<void> uplodNewsItes({
    required String title,
    required String patternPath,
    required String imagePath,
    required String path,
    required String description,
    required File imageFile,
  }) async {
    await RTDBServiceNews.uploadNewsItem(
      title: title,
      patternPath: patternPath,
      imagePath: imagePath,
      path: path,
      description: description,
      imageFile: imageFile,
    );
    await fetchAllData();
    notifyListeners();
    print("Finished bro");
  }

  //animation text
}
