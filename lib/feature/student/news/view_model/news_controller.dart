import 'package:aviatoruz/data/entity/news_model.dart';
import 'package:aviatoruz/data/repository/app_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newsProvider = ChangeNotifierProvider((ref) => NewsNotifier());

class NewsNotifier extends ChangeNotifier {
  bool isLoading = false;

  NewsModel? newsModel;
  Future<void> getNewsInifo() async {
    isLoading = true;
    final result = await AppRepositoryImpl().getNews();
    if (result != null) {
      newsModel = result;
      isLoading = false;
    } else {
      newsModel = null;
    }
    notifyListeners();
  }

  double scale = 1.0;

  void zoomIn() {
    scale += 0.1;
    notifyListeners();
  }

  void zoomOut() {
    if (scale > 0.1) scale -= 0.1;
    notifyListeners();
  }
}
